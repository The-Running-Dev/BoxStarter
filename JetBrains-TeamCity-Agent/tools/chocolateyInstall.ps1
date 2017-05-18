if ($env:chocolateyPackageParameters -eq $null) {
	throw "No parameters have been passed into Chocolatey install, e.g. -params 'serverUrl=http://... agentName=... agentDir=...'"
}

$parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")

## Validate parameters
if ($parameters["serverUrl"] -eq $null) {
    throw "Please specify the TeamCity server URL by passing it as a parameter to Chocolatey install, e.g. -params 'serverUrl=http://...'"
}
if ($parameters["agentDir"] -eq $null) {
    $parameters["agentDir"] = "$env:SystemDrive\buildAgent"
    Write-Host No agent directory is specified. Defaulting to $parameters["agentDir"]
}
if ($parameters["agentName"] -eq $null) {
    $parameters["agentName"] = "$env:COMPUTERNAME"
    Write-Host No agent name is specified. Defaulting to $parameters["agentName"]
}
if ($parameters["ownPort"] -eq $null) {
    $parameters["ownPort"] = "9090"
    Write-Host No agent port is specified. Defaulting to $parameters["ownPort"]
}

## Make local variables of it
$serverUrl = $parameters["serverUrl"];
$agentDir = $parameters["agentDir"];
$agentName = $parameters["agentName"];
$ownPort = $parameters["ownPort"];
$agentDrive = split-path $agentDir -qualifier

## Temporary folder
$tempFolder = $env:TEMP

## Download from TeamCity server
Get-ChocolateyWebFile 'buildAgent.zip' "$tempFolder\buildAgent.zip" "$serverUrl/update/buildAgent.zip"

## Extract
New-Item -ItemType Directory -Force -Path $agentDir
Get-ChocolateyUnzip "$tempFolder\buildAgent.zip" $agentDir  

## Clean up
#del /Q "$tempFolder\buildAgent.zip"

# Configure agent
copy $agentDir\conf\buildAgent.dist.properties $agentDir\conf\buildAgent.properties
(Get-Content $agentDir\conf\buildAgent.properties) | Foreach-Object {
    $_ -replace 'serverUrl=http://localhost:8111/', "serverUrl=$serverUrl" `
	   -replace 'name=', "name=$agentName" `
	   -replace 'ownPort=9090', "ownPort=$ownPort"
    } | Set-Content $agentDir\conf\buildAgent.properties

# Configure service wrapper to allow multiple instances on a single machine
(Get-Content $agentDir\launcher\conf\wrapper.conf) | Foreach-Object {
    $_ -replace 'TCBuildAgent', "$agentName" `
    	   -replace 'TeamCity Build Agent', "TeamCity Build Agent $agentName" `
    } | Set-Content $agentDir\launcher\conf\wrapper.conf

Start-ChocolateyProcessAsAdmin "/C `"$agentDrive && cd /d $agentDir\bin && $agentDir\bin\service.install.bat && $agentDir\bin\service.start.bat`"" cmd
