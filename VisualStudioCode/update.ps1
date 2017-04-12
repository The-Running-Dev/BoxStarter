. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'

    $json = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl | ConvertFrom-Json

    return @{ Url32 = $json.Url; Version = $json.productVersion }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion