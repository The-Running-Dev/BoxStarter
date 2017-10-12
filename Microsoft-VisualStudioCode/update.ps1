param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'
    $json = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing | ConvertFrom-Json

    if ($force) {
        $global:au_Version = $json.productVersion
    }

    return @{ Url32 = $json.Url -replace 'ia32', 'x64'; Version = $json.productVersion }
}

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')