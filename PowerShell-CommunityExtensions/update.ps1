param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $module = Invoke-RestMethod "https://www.powershellgallery.com/api/v2/Packages?`$filter=Id eq 'PSCX' and IsLatestVersion"
    $version = $module.properties.version
    $url = Get-RedirectUrl $module.Content.src

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

# install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')