param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'

    $json = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing | ConvertFrom-Json

    if ($force) {
        $global:au_Version = $json.productVersion
    }

    return @{ Url32 = $json.Url; Version = $json.productVersion }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')