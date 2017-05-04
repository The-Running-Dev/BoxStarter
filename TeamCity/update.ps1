$endpointUrl = iwr 'https://www.jetbrains.com/teamcity/download/download-thanks.html?platform=linux' `
    -UseBasicParsing `
    | select -Expand links `
    | ? { $_.href -match '.*download\?code=TC' } `
    | Select -First 1 -Expand href

$downloadUrl = ((Get-WebURL -Url "http:$endpointUrl&platform=linux").ResponseUri).AbsoluteUri
# Outputs: https://download-cf.jetbrains.com/teamcity/TeamCity-2017.1.tar.gz