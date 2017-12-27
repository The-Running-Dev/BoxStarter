param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://zoom.us/client/latest/ZoomInstaller.exe'
    $installer = "$packageDir\ZoomInstaller.exe"

    Invoke-WebRequest -Uri $url -OutFile $installer
    $version = (Get-Item $installer).VersionInfo.ProductVersion

    Remove-ITem $installer

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')