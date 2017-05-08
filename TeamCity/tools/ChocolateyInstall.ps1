. (Join-Path $PSScriptRoot 'Helpers.ps1')

$arguments        = @{
    url           = 'https://download-cf.jetbrains.com/teamcity/TeamCity-2017.1.1.exe'
    checksum      = '8A469B0B1D912A15AEF79BCF55CD6D2155D48F795D9AE3C42F402D5AC08FCE5C'
    unzipLocation = 'C:\TeamCity'
    runAsSystem   = $true
    serviceName   = 'TeamCity'
    userName      = ''
    domain        = ''
    password      = ''
}

$packageArgs = Get-Arguments $arguments

Set-ChocolateyPackageOptions $packageArgs

if ($packageArgs.userName -and $packageArgs.password -ne '') {
    $packageArgs.runAsSystem = $false
}

$service = Get-Service | Where-Object Name -eq $packageArgs.serviceName
if ($service -ne $null) {
    Stop-Service $service
}

$binPath = Join-Path $packageArgs.unzipLocation 'bin'
if ((Test-Path $binPath) -and ($service -ne $null)) {
    Push-Location $binPath
    & "$binPath\teamcity-server.bat service delete"
    Pop-Location
}

if (![System.IO.File]::Exists($packageArgs.file)) {
  Get-ChocolateyWebFile @packageArgs
}

Get-ChocolateyUnzip -FileFullPath $packageArgs.file -Destination $packageArgs.unzipLocation

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

Push-Location $binPath

& "$binPath\teamcity-server.bat service install" $($installArgs -join ' ')

Pop-Location

Export-CLIXml -Path (Join-Path $PSScriptRoot 'Options.xml') -InputObject $packageArgs

Remove-Item $packageArgs.file
