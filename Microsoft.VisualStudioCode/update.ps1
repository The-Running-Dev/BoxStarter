param([switch] $force)

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'

    $json = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl | ConvertFrom-Json

    if ($force) {
        $global:au_Version = $json.productVersion
    }

    return @{ Url32 = $json.Url; Version = $json.productVersion }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')