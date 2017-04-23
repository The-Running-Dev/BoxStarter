param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_BeforeUpdate {
    $packageInstaller = [System.IO.Path]::GetFileName($Latest.Url32)
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

function global:au_GetLatest {
    $releaseUrl = 'https://www.getpaint.net/index.html'
    $versionRegEx = 'paint\.net\s+([0-9\.]+)'
    $urlString = 'https://www.dotpdn.com/files/paint.net.$version.install.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $url = $ExecutionContext.InvokeCommand.ExpandString($urlString)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')