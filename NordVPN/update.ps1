param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'https://downloads.nordcdn.com/apps/windows/10/NordVPN/latest/NordVPNSetup.exe'
    $installer = "$packageDir\NordVPNSetup.exe"

    Invoke-WebRequest -Uri $url -OutFile $installer
    $version = (Get-Item $installer).VersionInfo.ProductVersion

    Remove-Item $installer

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')