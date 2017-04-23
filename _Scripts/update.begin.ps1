# packageDir is defined in the individual update script
Set-Location $packageDir

$toolsPath = Join-Path $packageDir 'tools'
$installersPath = Join-Path $packageDir '..\..\..\BoxStarter\Installers' -Resolve

function global:au_BeforeUpdate {
    $packageInstaller = [System.IO.Path]::GetFileName($Latest.Url32) -replace '%20', ' '
    $existingPackageInstaller = Join-Path $installersPath $packageInstaller

    if (![System.IO.File]::Exists($existingPackageInstaller)) {
        # Use the AU function to get the installer
        Get-RemoteFiles

        # Find the downloaded file
        $downloadedFile = Get-ChildItem -Recurse *.exe, *.msi, *.zip | Select-Object -First 1

        # Remove the _32 and any HTML encoded space
        $installer = Join-Path $packageDir (((Split-Path -Leaf $downloadedFile) -replace '_x32', '') -replace '%20', ' ')

        # Move the installer to the package directory
        # because I don't like it under the tools directory
        Move-Item $downloadedFile $installer -Force

        # Create a .ignore file for each found executable
        New-Item "$($installer).ignore" -Force

        $packageInstaller = [System.IO.Path]::GetFileName($installer)
    }
    else {
        Copy-Item $existingPackageInstaller $packageDir -Force
        Copy-Item "$($existingPackageInstaller).ignore" $packageDir -Force

        $Latest.Checksum32 = (Get-FileHash $existingPackageInstaller).Hash
    }

    $Latest.FileName32 = $packageInstaller
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}