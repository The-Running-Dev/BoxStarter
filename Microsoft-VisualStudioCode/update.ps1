param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'

    $json = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing | ConvertFrom-Json

    if ($force) {
        $global:au_Version = $json.productVersion
    }

    return @{ Url32 = $json.Url; Version = $json.productVersion }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')