$parameters = Get-Parameters
$arguments = @{
    url         = 'https://www.apachehaus.com/downloads/httpd-2.4.37-x64-vc11-r2.zip'
    checksum    = 'EB2CE662C54E2A91E410B880DE02CE476E70905E3C576A3AA04CE6526C0F6EDD'
    destination = if ($parameters.installLocation) { $parameters.installLocation } else { $env:APPDATA }
    port        = if ($parameters.Port) { $parameters.Port } else { 80 }
    serviceName = if ($parameters.serviceName) { $parameters.serviceName } else { 'Apache' }
}

if (-not (Assert-TcpPortIsOpen $arguments.port)) {
    throw 'Please specify a different port number...'
}

Install-Apache $arguments
