$excludeFiles = $('update.ps1', 'chocolateyInstall.ps1', '*.nupkg')

# packageDir is defined in the individual update script
Push-Location $packageDir

$toolsPath = Join-Path $packageDir 'tools'
$installersPath = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Installers' -Resolve

function global:au_BeforeUpdate {
    if ($Latest.Url32) {
        $packageInstaller = [System.IO.Path]::GetFileName($Latest.Url32) -replace '%20', ' '
    }
    elseif ($Latest.FileName32) {
        $packageInstaller = $Latest.FileName32
    }
    else {
        $packageInstaller = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)file\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1
    }

    $existingPackageInstaller = Join-Path $installersPath $packageInstaller

    if (![System.IO.File]::Exists($existingPackageInstaller) -and $Latest.Url32) {
        # Use the AU function to get the installer
        Get-RemoteFiles -NoSuffix `
            -FileNameBase $([System.IO.Path]::GetFileNameWithoutExtension($existingPackageInstaller))

        # Find the downloaded file
        $downloadedFile = Get-ChildItem -Recurse *.exe, *.msi, *.zip | Select-Object -First 1

        # Remove the _32 and any HTML encoded space
        $installer = Join-Path $packageDir ((Split-Path -Leaf $downloadedFile) -replace '%20', ' ')

        # Move the installer to the package directory
        # because I don't like it under the tools directory
        Move-Item $downloadedFile $installer -Force

        if ($installer -match '\.(exe|msi)$') {
            # Create a .ignore file for each found executable
            New-Item "$($installer).ignore" -Force
        }

        $packageInstaller = [System.IO.Path]::GetFileName($installer)
        $Latest.FileName32 = $packageInstaller
    }
    elseif ([System.IO.File]::Exists($existingPackageInstaller)) {
        Copy-Item $existingPackageInstaller $packageDir -Force

        if ($existingPackageInstaller -match '\.(exe|msi)$') {
            # Create a .ignore file for each found executable
            New-Item "$packageDir\$(Split-Path -Leaf $existingPackageInstaller).ignore" -Force
        }

        $Latest.Checksum32 = (Get-FileHash $existingPackageInstaller).Hash
        $Latest.FileName32 = $packageInstaller
    }

    if ([System.IO.Directory]::Exists($settingsDir) -and $settingsZip) {
        Compress-Archive -Path $settingsDir -DestinationPath $settingsZip -Force
    }
}

function global:au_GetLatest {
    # Get the version from the nuspec
    $version = (Get-Item "$($Latest.PackageName).nuspec" `
        | Select-String "(?i)<version>([0-9\.]+)</version>") `
        | ForEach-Object { $_.Matches[0].Groups[1].Value }

    try {
        # Get the last updated on date from the ChocolateyInstall file
        $updatedOn = [DateTime]((Get-Item $packageDir\tools\ChocolateyInstall.ps1 | Select-String "(?i)^[$]updatedOn\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1)
    }
    catch {}

    # Get a list of updated files after the last updated on date
    $updatedFiles = Get-ChildItem $packageDir -Recurse -File -Exclude '*.nuspec', 'ChocolateyInstall.ps1' | Where-Object { Test-Path -Path $_.FullName -NewerThan $updatedOn }

    if ($updatedFiles -or $force) {
        $newVersion = ([version]$version)
        $newVersion = "$($newVersion.Major).$($newVersion.Minor).$($newVersion.Build + 1)"

        $updatedOn = (get-date).ToString('yyyy.MM.dd HH:mm:ss')
        $version = $newVersion
        $global:au_Version = $newVersion
    }

    return @{ Version = $version; UpdatedOn = $updatedOn }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]updatedOn\s*=\s*)('.*')" = "`$1'$($Latest.UpdatedOn)'"
        }
    }
}