# Get the commit messages, and files changed for the specified change id
# Ignores empty lines, lines containing "#ignore", "merge branch"" or "TeamCity"
Function Get-TeamCityCommitMessage([string]$serverUrl, [string]$username, [string]$password, [int]$changeId) {
    $getFilesChanged = $false;
    $request = [System.Net.WebRequest]::Create("$serverUrl/httpAuth/app/rest/changes/id:$changeId")
    $authToken = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($username + ":" + $password))
    $request.Headers.Add("Authorization", "Basic $authToken");

    $xml = [xml](new-object System.IO.StreamReader $request.GetResponse().GetResponseStream()).ReadToEnd()

    Microsoft.PowerShell.Utility\Select-Xml $xml -XPath "/change" |
        where { ($_.Node["comment"].InnerText.Length -ne 0) `
            -and (-Not $_.Node["comment"].InnerText.Contains('#ignore')) `
            -and (-Not $_.Node["comment"].InnerText.StartsWith("Merge branch")) `
            -and (-Not $_.Node["comment"].InnerText.StartsWith("TeamCity change"))} |
        foreach {
        $getFilesChanged = $true
        $username = (& {If ($_.Node["user"] -ne $null) {$_.Node["user"].name.Trim()} Else { $_.Node.Attributes["username"].Value }})
        "<br /><strong>$($username + " on " + ([System.DateTime]::ParseExact($_.Node.Attributes["date"].Value, "yyyyMMddTHHmmsszzzz", [System.Globalization.CultureInfo]::InvariantCulture)))</strong><br /><br />"

        "$($_.Node["comment"].InnerText.Trim().Replace("`n", "`n<br />"))"
    }

    if ($getFilesChanged) {
        "<br /><br /><strong>Files Changed</strong><br /><br />"
        Microsoft.PowerShell.Utility\Select-Xml $xml -XPath "/change/files" |
            where { ($_.Node["file"].Length -ne 0)} |
            foreach { Select-Xml $_.Node -XPath 'file' |
                foreach { "$($_.Node.Attributes["file"].Value)<br />" }
        }
    }
}