param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $response = Invoke-RestMethod -Uri "https://go.microsoft.com/fwlink/?LinkId=841665"
    $version = $response.component.version
    $downloadUrl = Get-RedirectUrl $response.link.href

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')