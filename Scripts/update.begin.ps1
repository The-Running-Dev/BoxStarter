$excludeFiles = $('update.ps1', 'chocolateyInstall.ps1', '*.nupkg', '*.nuspec')

# packageDir is defined in the individual update script
Push-Location $packageDir

$installersPath = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Installers' -Resolve
$isFixedVersion = $true

function global:au_BeforeUpdate {
    if ($Latest.FileName32) {
        $packageInstaller = $Latest.FileName32
    }
    elseif ($Latest.Url32) {
        $packageInstaller = [System.IO.Path]::GetFileName($Latest.Url32) -replace '%20', ' '
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
        $downloadedFile = Get-ChildItem `
            -Recurse *.7z, *.zip, *.tar.gz, *.exe, *.msi | Select-Object -First 1

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
}

function global:au_GetLatest {
    # Get the version from the nuspec
    $version = (Get-Item "$($Latest.PackageName).nuspec" `
            | Select-String "(?i)<version>([0-9\.]+)</version>") `
        | ForEach-Object { $_.Matches[0].Groups[1].Value }

    # Force the version to be the same by default
    $global:au_Version = $version

    $url = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)url\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1
    $checksum = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)checksum\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1

    try {
        # Get the last updated on date from the ChocolateyInstall file
        $updatedOn = [DateTime]((Get-Item $packageDir\tools\ChocolateyInstall.ps1 | Select-String "(?i)^[$]updatedOn\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1)
    }
    catch {}

    # Get a list of updated files after the last updated on date
    $updatedFiles = Get-ChildItem $packageDir -Recurse -File -Exclude $excludeFiles | Where-Object { $_.LastWriteTime -ge $updatedOn }

    if (($updatedFiles -or $force) -and (-not $isFixedVersion)) {
        $newVersion = ([version]$version)
        $newVersion = "$($newVersion.Major).$($newVersion.Minor).$($newVersion.Build + 1)"

        $updatedOn = (get-date).ToString('yyyy.MM.dd HH:mm:ss')
        $version = $newVersion
        $global:au_Version = $newVersion
    }

    $latestData = @{ Version = $version; UpdatedOn = $updatedOn }
    if ($url) { $latestData.Url32 = $url }
    if ($checksum) { $latestData.Checksum32 = $checksum }

    return $latestData
}

function global:au_SearchReplace {
    if (-not (Test-Path (Join-Path $packageDir 'tools\chocolateyInstall.ps1'))) {
        return @{}
    }

    $searchReplace = @{
        ".\tools\chocolateyInstall.ps1" = @{
        }
    }

    $file = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)file\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1
    $url = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)url\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1
    $checksum = (Get-Item $packageDir\tools\chocolateyInstall.ps1 | Select-String "(?i)checksum\s*=\s*'.*'") -split "=|'" | Select-Object -Last 1 -Skip 1

    if ($file) { $searchReplace[".\tools\chocolateyInstall.ps1"]["(?i)(file\s*=\s*)('.*')"] = "`$1'$($Latest.FileName32)'" }
    if ($url) { $searchReplace[".\tools\chocolateyInstall.ps1"]["(?i)(url\s*=\s*)('.*')"] = "`$1'$($Latest.Url32)'" }
    if ($checksum) { $searchReplace[".\tools\chocolateyInstall.ps1"]["(?i)(checksum\s*=\s*)('.*')"] = "`$1'$($Latest.Checksum32)'" }

    return $searchReplace
}