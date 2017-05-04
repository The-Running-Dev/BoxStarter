# packageDir is defined in the individual update script
Push-Location $packageDir

$toolsPath = Join-Path $packageDir 'tools'
$installersPath = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Installers' -Resolve

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
            Copy-Item "$($existingPackageInstaller).ignore" $packageDir -Force
        }

        $Latest.Checksum32 = (Get-FileHash $existingPackageInstaller).Hash
        $Latest.FileName32 = $packageInstaller
    }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}