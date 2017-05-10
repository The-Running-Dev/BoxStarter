. (Join-Path $PSScriptRoot 'Helpers.ps1')

$packageDir             = $env:ChocolateyPackageFolder
$arguments = @{
    url                 = 'https://download-cf.jetbrains.com/teamcity/TeamCity-2017.1.1.exe'
    checksum            = '8A469B0B1D912A15AEF79BCF55CD6D2155D48F795D9AE3C42F402D5AC08FCE5C'
    installDir          = 'C:\TeamCity'
    dataDir             = 'C:\TeamCity\Data'
    javaDir             = 'C:\TeamCity\jre'
    runAsSystem         = $true
    serviceName         = 'TeamCity'
    servicePortNumber   = 8090
    userName            = ''
    domain              = ''
    password            = ''
    serverConfig        = Join-Path $env:ChocolateyPackageFolder 'server.xml'
}

if (Get-TeamCityService $arguments.serviceName) {
    Write-Host 'TeamCity service is alredy installed...aborting.'

    return
}

$process = Get-NetTCPConnection -State Listen -LocalPort $arguments.servicePortNumber -ErrorAction SilentlyContinue | `
    Select-Object -First 1 -ExpandProperty OwningProcess | `
    Select-Object @{Name = "Id"; Expression = {$_} } | `
    Get-Process | `
    Select-Object Name, Path

if ($process) {
    Write-Host 'Port' $arguments.servicePortNumber 'is in use by' $process.Name 'with path'  $process.Path
    Write-Host 'Please specify a different port. TeamCity cannot be installed...aborting.'

    return
}

$packageArgs = Get-Arguments $arguments

Set-ChocolateyPackageOptions $packageArgs


if ([System.IO.Directory]::Exists($($parameters.installDir))) {
    $packageArgs.installDir = $parameters.installDir
}

if ([System.IO.Directory]::Exists($($parameters.dataDir))) {
    $packageArgs.dataDir = $parameters.dataDir
}

if ([System.IO.Directory]::Exists($($parameters.javaDir))) {
    $packageArgs.javaDir = $parameters.javaDir
}

if ($packageArgs.userName -and $packageArgs.password) {
    $packageArgs.runAsSystem = $false
}

if (![System.IO.File]::Exists($packageArgs.file)) {
    $packageArgs.file = Get-ChocolateyWebFile @packageArgs
}

Get-ChocolateyUnzip -FileFullPath $packageArgs.file -Destination $packageArgs.installDir | Out-Null
Copy-Item $packageArgs.serverConfig "$($packageArgs.installDir)\conf\server.xml"
Remove-Item "$($packageArgs.installDir)\`$PLUGINSDIR"
Remove-Item "$($packageArgs.installDir)\`$TEMP"

# Create the data directory and sub-directories
New-Item -ItemType Directory $($packageArgs.dataDir) -Force | Out-Null
New-Item -ItemType Directory "$($packageArgs.dataDir)\config" -Force | Out-Null
New-Item -ItemType Directory "$($packageArgs.dataDir)\lib\jdbc" -Force | Out-Null
New-Item -ItemType Directory "$($packageArgs.dataDir)\plugins" -Force | Out-Null

Copy-Item "$packageDir\Database\sqljdbc_auth_x86.dll" "$($packageArgs.javaDir)\bin\sqljdbc_auth.dll"
Copy-Item "$packageDir\database.properties" "$($packageArgs.dataDir)\config" -Force
Copy-Item "$packageDir\sqljdbc42.jar" "$($packageArgs.dataDir)\lib\jdbc" -Force
Copy-Item "$packageDir\Plugins" "$($packageArgs.dataDir)" -Recurse -Force

$installArgs = @()
if ($packageArgs.runAsSystem) {
    $installArgs += '/runAsSystem'
}
else {
    $installArgs += "/user=`"$($packageArgs.userName)`""
    $installArgs += "/password=`"$($packageArgs.password)`""

    if ($packageArgs.domain) {
        $installArgs += "/domain=`"$($packageArgs.domain)`""
    }
}

Start-ChocolateyProcessAsAdmin "$($arguments.installLocation)\bin\teamcity-server.bat configure"
Start-ChocolateyProcessAsAdmin "$($arguments.installLocation)\bin\teamcity-server.bat service install $($installArgs -join ' ')"
Start-ChocolateyProcessAsAdmin "$($arguments.installLocation)\buildAgent\bin\service.install.bat"

Export-CLIXml -Path (Join-Path $PSScriptRoot 'Arguments.xml') -InputObject $packageArgs
#Remove-Item $packageArgs.file -Recurse -Force
