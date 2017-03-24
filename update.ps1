function Get-GitHubVersion {
    Param (
        [Parameter(Mandatory = $true)][string] $user,
        [Parameter(Mandatory = $true)][string] $repository
    )
    $release = @{
        Version = ''
        DownloadUrls = ''
    }

    $releaseParams = @{
        Uri = "https://api.github.com/repos/$user/$repository/releases/latest";
        Method = 'GET';
        ContentType = 'application/json';
        Body = (ConvertTo-Json $releaseData -Compress)
    }
    $servicePoint = [System.Net.ServicePointManager]::FindServicePoint($($releaseParams.Uri))

    $results = Invoke-RestMethod @releaseParams
    $assets = $result.assets
    ForEach ($result in $results) {
        $release.Version = $result.tag_name -replace '^v', ''
        $release.DownloadUrls = $result.assets.browser_download_url
    }

    $servicePoint.CloseConnectionGroup('') | Out-Null

    return $release
}

function Get-RedirectUrl([string] $url) {
    return ((Get-WebURL -Url $url).ResponseUri).AbsoluteUri
}

function Get-Version([string] $url, [string] $versionRegEx) {
    return $($url -replace $versionRegEx, '$1')
}

function Get-LatestVersion([string] $url, [string] $versionRegEx) {
    return $(Get-Version (Get-RedirectUrl $url) $versionRegEx)
}

echo "ConEmu: $((GitHubVersion 'Maximus5' 'ConEmu').Version)"
echo "ClipboardFusion: $(Get-LatestVersion 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104' '.*?([0-9\.]+)\.\w+$')"
echo "Dropbox: $(Get-LatestVersion 'https://www.dropbox.com/download?full=1&plat=win' '.*Dropbox%20([0-9\.]+).*')"
echo "OctopusDeploy: $(Get-LatestVersion 'http://octopusdeploy.com/downloads/latest/OctopusServer64' '.*Octopus\.([0-9\.]+)\-.*')"

<#
if (Test-Path($artifactsPath)) {
    Remove-Item $artifactsPath\** -Recurse -Force
}

New-Item -Path $artifactsPath -ItemType Directory -Force

if ($package -eq '') {
    foreach ($p in (Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse)) {
        CompileAutoHotKey((Split-Path -Parent $p.FullName))

        choco pack $p.FullName --outputdirectory $artifactsPath
    }
}
else {
    $packages = Get-ChildItem -Path $PSScriptRoot -Filter *.nuspec -Recurse | Where-Object { $_.Name -match "^$package.*"}

    foreach ($p in $packages) {
        CompileAutoHotKey((Split-Path -Parent $p.FullName))

        choco pack $p.FullName --outputdirectory $artifactsPath
    }
}
#>