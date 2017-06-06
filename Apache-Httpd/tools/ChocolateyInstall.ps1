$pp = Get-Parameters
$arguments = @{
    file        = 'httpd-2.4.25-x64-vc14-r1.zip'
    destination = if ($pp.installLocation) { $pp.installLocation } else { $env:APPDATA }
    port        = if ($pp.Port) { $pp.Port } else { 80 }
    serviceName = if ($pp.serviceName) { $pp.serviceName } else { 'Apache' }
}

if (-not (Assert-TcpPortIsOpen $arguments.port)) {
    throw 'Please specify a different port number...'
}

Install-Apache $arguments
