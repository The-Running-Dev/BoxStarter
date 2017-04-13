function Get-GitHubVersion {
    Param (
        [Parameter(Mandatory = $true)][string] $repository,
        [Parameter(Mandatory = $false)][string] $downloadUrlRegEx
    )
    $release = @{
        Version = ''
        DownloadUrl = ''
    }

    $releaseParams = @{
        Uri = $ExecutionContext.InvokeCommand.ExpandString($global:gitHubApiUrl)
        Method = 'GET';
        ContentType = 'application/json';
        Body = (ConvertTo-Json $releaseData -Compress)
    }

    $servicePoint = [System.Net.ServicePointManager]::FindServicePoint($($releaseParams.Uri))
    $results = Invoke-RestMethod @releaseParams
    $assets = $result.assets

    ForEach ($result in $results) {
        $release.Version = $result.tag_name -replace '^v', ''

        foreach ($url in $result.assets.browser_download_url) {
            if ($downloadUrlRegEx) {
                if ($url -match $downloadUrlRegEx) {
                    $release.DownloadUrl = $url
                }
            }
            else {
                $release.DownloadUrl += $url
            }
        }
    }

    $servicePoint.CloseConnectionGroup('') | Out-Null

    return $release
}