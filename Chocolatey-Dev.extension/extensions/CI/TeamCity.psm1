if ($env:TEAMCITY_VERSION) {
	# When PowerShell is started through TeamCity's Command Runner, the standard
	# output will be wrapped at column 80 (a default). This has a negative impact
	# on service messages, as TeamCity quite naturally fails parsing a wrapped
	# message. The solution is to set a new, much wider output width. It will
	# only be set if TEAMCITY_VERSION exists, i.e., if started by TeamCity.
	$host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(8192, 50)
}

function Write-TeamCityMessage([string]$text, [string]$status = 'NORMAL', [string]$errorDetails) {
	$messageAttributes = @{ text=$text; status=$status }

	if ($errorDetails) {
		$messageAttributes.errorDetails = $errorDetails
	}

	Write-TeamCityServiceMessage 'message' $messageAttributes
}

function Set-TeamCityBlockOpened([string]$name, [string]$description) {
	$messageAttributes = @{ name=$name }

	if ($description) {
		$messageAttributes.description = $description
	}

	Write-TeamCityServiceMessage 'blockOpened' $messageAttributes
}

function Set-TeamCityBlockClosed([string]$name) {
	Write-TeamCityServiceMessage 'blockClosed' @{ name=$name }
}

function Set-TeamCityTestSuiteStarted([string]$name) {
	Write-TeamCityServiceMessage 'testSuiteStarted' @{ name=$name }
}

function Set-TeamCityTestSuiteFinished([string]$name) {
	Write-TeamCityServiceMessage 'testSuiteFinished' @{ name=$name }
}

function Set-TeamCityTestStarted([string]$name) {
	Write-TeamCityServiceMessage 'testStarted' @{ name=$name }
}

function Set-TeamCityTestFinished([string]$name, [int]$duration) {
	$messageAttributes = @{name=$name; duration=$duration}

	if ($duration -gt 0) {
		$messageAttributes.duration=$duration
	}

	Write-TeamCityServiceMessage 'testFinished' $messageAttributes
}

function Set-TeamCityTestIgnored([string]$name, [string]$message='') {
	Write-TeamCityServiceMessage 'testIgnored' @{ name=$name; message=$message }
}

function Set-TeamCityTestOutput([string]$name, [string]$output) {
	Write-TeamCityServiceMessage 'testStdOut' @{ name=$name; out=$output }
}

function Set-TeamCityTestError([string]$name, [string]$output) {
	Write-TeamCityServiceMessage 'testStdErr' @{ name=$name; out=$output }
}

function Set-TeamCityTestFailed([string]$name, [string]$message, [string]$details='', [string]$type='', [string]$expected='', [string]$actual='') {
	$messageAttributes = @{ name=$name; message=$message; details=$details }

	if (![string]::IsNullOrEmpty($type)) {
		$messageAttributes.type = $type
	}

	if (![string]::IsNullOrEmpty($expected)) {
		$messageAttributes.expected=$expected
	}
	if (![string]::IsNullOrEmpty($actual)) {
		$messageAttributes.actual=$actual
	}

	Write-TeamCityServiceMessage 'testFailed' $messageAttributes
}

# See http://confluence.jetbrains.net/display/TCD5/Manually+Configuring+Reporting+Coverage
function Set-TeamCityDotNetCoverage([string]$key, [string]$value) {
    Write-TeamCityServiceMessage 'dotNetCoverage' @{ $key=$value }
}

function Import-TeamCityDotNetCoverageResult([string]$tool, [string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='dotNetCoverage'; tool=$tool; path=$path }
}

# See http://confluence.jetbrains.net/display/TCD5/FxCop_#FxCop_-UsingServiceMessages
function Import-TeamCityFxCopResult([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='FxCop'; path=$path }
}

function Import-TeamCityDuplicatesResult([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='DotNetDupFinder'; path=$path }
}

function Import-TeamCityInspectionCodeResult([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='ReSharperInspectCode'; path=$path }
}

function Import-TeamCityNUnitReport([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='nunit'; path=$path }
}

function Import-TeamCityJSLintReport([string]$path) {
	Write-TeamCityServiceMessage 'importData' @{ type='jslint'; path=$path }
}

function Publish-TeamCityArtifacts([string] $path) {
	Write-TeamCityServiceMessage 'publishArtifacts' $path
}

function Write-TeamCityBuildStart([string]$message) {
	Write-TeamCityServiceMessage 'progressStart' $message
}

function Write-TeamCityBuildProgress([string]$message) {
	Write-TeamCityServiceMessage 'progressMessage' $message
}

function Write-TeamCityBuildFinished([string]$message) {
	Write-TeamCityServiceMessage 'progressFinish' $message
}

function Write-TeamCityBuildStatus([string]$status=$null, [string]$text='') {
	$messageAttributes = @{ text=$text }

	if (![string]::IsNullOrEmpty($status)) {
		$messageAttributes.status = $status
	}

	Write-TeamCityServiceMessage 'buildStatus' $messageAttributes
}

function Set-TeamCityBuildProblem([string]$description, [string]$identity=$null) {
	$messageAttributes = @{ description=$description }

	if (![string]::IsNullOrEmpty($identity)) {
		$messageAttributes.identity=$identity
	}

	Write-TeamCityServiceMessage 'buildProblem' $messageAttributes
}

function Set-TeamCityBuildNumber([string]$buildNumber) {
	Write-TeamCityServiceMessage 'buildNumber' $buildNumber
}

function Set-TeamCityParameter([string]$name, [string]$value) {
	Write-TeamCityServiceMessage 'setParameter' @{ name=$name; value=$value }
}

function Set-TeamCityBuildStatistic([string]$key, [string]$value) {
	Write-TeamCityServiceMessage 'buildStatisticValue' @{ key=$key; value=$value }
}

function Enable-TeamCityServiceMessages() {
	Write-TeamCityServiceMessage 'enableServiceMessages'
}

function Disable-TeamCityServiceMessages() {
	Write-TeamCityServiceMessage 'disableServiceMessages'
}

function Initialize-TeamCityInfoDocument([string]$buildNumber='', [boolean]$status=$true, [string[]]$statusText=$null, [System.Collections.IDictionary]$statistics=$null) {
	$doc=New-Object xml;
	$buildEl=$doc.CreateElement('build');

	if (![string]::IsNullOrEmpty($buildNumber)) {
		$buildEl.SetAttribute('number', $buildNumber);
	}

	$buildEl = $doc.AppendChild($buildEl);
	$statusEl = $doc.CreateElement('statusInfo');

	if ($status) {
		$statusEl.SetAttribute('status', 'SUCCESS');
	} else {
		$statusEl.SetAttribute('status', 'FAILURE');
	}

	if ($statusText -ne $null) {
		foreach ($text in $statusText) {
			$textEl=$doc.CreateElement('text');
			$textEl.SetAttribute('action', 'append');
			$textEl.set_InnerText($text);
			$textEl=$statusEl.AppendChild($textEl);
		}
	}

	$statusEl = $buildEl.AppendChild($statusEl);

	if ($statistics -ne $null) {
		foreach ($key in $statistics.Keys) {
			$val=$statistics.$key
			if ($val -eq $null) {
				$val=''
			}

			$statEl=$doc.CreateElement('statisticsValue');
			$statEl.SetAttribute('key', $key);
			$statEl.SetAttribute('value', $val.ToString());
			$statEl=$buildEl.AppendChild($statEl);
		}
	}

	return $doc;
}

function Write-TeamCityInfoDocument([xml]$doc) {
	$dir=(Split-Path $buildFile)
	$path=(Join-Path $dir 'teamcity-info.xml')

	$doc.Save($path);
}

function Write-TeamCityServiceMessage([string]$messageName, $messageAttributesHashOrSingleValue) {
	function escape([string]$value) {
		([char[]] $value |
				%{ switch ($_)
						{
								"|" { "||" }
								"'" { "|'" }
								"`n" { "|n" }
								"`r" { "|r" }
								"[" { "|[" }
								"]" { "|]" }
								([char] 0x0085) { "|x" }
								([char] 0x2028) { "|l" }
								([char] 0x2029) { "|p" }
								default { $_ }
						}
				} ) -join ''
		}

	if ($messageAttributesHashOrSingleValue -is [hashtable]) {
		$messageAttributesString = ($messageAttributesHashOrSingleValue.GetEnumerator() |
			%{ "{0}='{1}'" -f $_.Key, (escape $_.Value) }) -join ' '
      $messageAttributesString = " $messageAttributesString"
	} elseif ($messageAttributesHashOrSingleValue) {
		$messageAttributesString = (" '{0}'" -f (escape $messageAttributesHashOrSingleValue))
	}

	Write-Output "##teamcity[$messageName$messageAttributesString]"
}

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

# Get the commit messages, and files changed for the specified change id
# Ignores empty lines, lines containing "#ignore", "merge branch"" or "TeamCity"
Function Get-TeamCityCommitMessage([string]$serverUrl, [string]$username, [string]$password, [int]$changeId)
{
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
			$username = (&{If($_.Node["user"] -ne $null) {$_.Node["user"].name.Trim()} Else { $_.Node.Attributes["username"].Value }})
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

Export-ModuleMember -Function *