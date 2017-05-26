# Gets the change log for the specified build ID
function Get-TeamCityChangeLog([string] $serverUrl, [string] $username, [string] $password, [int] $buildId){
	$changelog = ""

    # If the build is running inside TeamCity
    if ($env:TEAMCITY_VERSION) {
		$buildUrl = "$serverUrl/httpAuth/app/rest/changes?build=id:$($buildId)"
		$authToken = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($username + ":" + $password))

		# Get all the changes
		$request = [System.Net.WebRequest]::Create($buildUrl)
		$request.Headers.Add("Authorization", "Basic $authToken");
		$xml = [xml](new-object System.IO.StreamReader $request.GetResponse().GetResponseStream()).ReadToEnd()

		# Get all commit messages for each of them
		$changelog = Microsoft.PowerShell.Utility\Select-Xml $xml -XPath `
			"/changes/change" | Foreach {
				Get-TeamCityCommitMessage $serverUrl $username $password $_.Node.id
			}
    }

    return $changelog
}