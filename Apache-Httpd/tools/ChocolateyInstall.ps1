﻿$pp = Get-Parameters
$arguments = @{
    url         = 'https://www.apachehaus.com/downloads/httpd-2.4.33-x64-vc11-r2.zip'
    destination = if ($pp.installLocation) { $pp.installLocation } else { $env:APPDATA }
    port        = if ($pp.Port) { $pp.Port } else { 80 }
    serviceName = if ($pp.serviceName) { $pp.serviceName } else { 'Apache' }
}

if (-not (Assert-TcpPortIsOpen $arguments.port)) {
    throw 'Please specify a different port number...'
}

Install-Apache $arguments
