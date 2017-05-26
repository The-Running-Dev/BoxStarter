function Get-ProGetInstallArguments {
    $notSilengArgs = @('HostIp', 'HostHeader', 'UseSSL')

    $packageArgs = @{
        ConfigureIIS           = 'true'
        ConnectionString       = 'Server=localhost\SQLExpress;Database=ProGet;Integrated Security=SSPI;'
        Edition                = 'Express'
        EmailAddress           = 'email@home.com'
        FullName               = 'Name'
        InstallSQLExpress      = 'false'
        HostIp                 = '*'
        HostHeader             = 'proget.local'
        LogFile                = "$env:Temp\ProGet_Install.log"
        Port                   = 80
        S                      = ''
        UseIntegratedWebServer = 'false'
        UseSSL                 = 'false'
    }

    # Get the user specified package arguments
    $userArguments = Get-Parameters

    # and ovewrite the package arguments with the ones from the user
    $userArguments.Keys | ForEach-Object {
        $packageArgs.$_ = $userArguments.$_
    }

    if (-not (Assert-IsValidSqlServerConnectionString $packageArgs.ConnectionString)) {
        Throw "$($packageArgs.ConnectionString) is not valid...aborting"
    }

    # Check if the user specified a port and that port is open
    if ($packageArgs.Port -ne 80 -and $packageArgs.Port -ne 443) {
        if (-not (Assert-TcpPortIsOpen $packageArgs.port) ) {
            Throw 'Please provide an open port number...aborting'
        }
    }

    if ($packageArgs.UseSSL -eq 'true' -and $packageArgs.Port -eq 80) {
        $packageArgs.Port = 443
    }

    if ($packageArgs.UseIntegratedWebServer -eq 'true') {
        Write-Host 'The UseIntegratedWebServer setting does not work...ignoring'

        $packageArgs.UseIntegratedWebServer = 'false'
        $packageArgs.ConfigureIIS = 'true'
    }

    if (-not $packageArgs.WebServerPrefixes) {
        $protocol = 'http'

        if ($packageArgs.UseSSL -eq 'true') {
            $protocol = 'https'
        }

        $packageArgs.WebServerPrefixes = "$protocol`://$($packageArgs.HostHeader):$($packageArgs.Port)/"
    }

    if ((Get-Service 'ProGet' -ErrorAction SilentlyContinue)) {
        Write-Host 'ProGet is alredy installed...will upgrade.'

        $packageArgs.Upgrade = ''
    }

    # Construct the silent arguments
    $packageArgs.Keys | Where-Object { $notSilengArgs -notcontains $_} | ForEach-Object {
        $silentArgs += ' "/' + $_

        If ($packageArgs.$_) {
            $silentArgs += '=' + $packageArgs.$_
        }

        $silentArgs += '"'
    }

    $packageArgs.silentArgs = $silentArgs

    return $packageArgs
}

function Set-ProGetWebSiteBindings {
    param(
        [Parameter(Position = 0, Mandatory)][hashtable] $arguments
    )

    if ($arguments.HostHeader -match '\.local') {
        Set-HostsEntry 127.0.0.1 $arguments.HostHeader
    }

    if ($arguments.UseSSL -eq 'true') {
        Get-WebBinding -Port $arguments.Port -Name 'ProGet' | Remove-WebBinding
        New-WebBinding -Name 'ProGet' -IPAddress $arguments.HostIp -HostHeader $arguments.HostHeader -Port $arguments.Port -Protocol 'https'

        Write-Host "ProGet is running at 'https://$($arguments.hostHeader)' on port '$($arguments.Port)' and IP '$($arguments.HostIp)'"
        Write-Host "You will need to configure the SSL certificate manually before the web site will work..."
    }
    else {
        Get-WebBinding -Port $packageArgs.Port -Name 'Proget' | Remove-WebBinding
        New-WebBinding -Name 'ProGet' -IPAddress $arguments.HostIp -HostHeader $arguments.HostHeader -Port $arguments.Port -Protocol 'http'

        Write-Host "ProGet is running at 'http://$($arguments.hostHeader)' on port '$($arguments.Port)' and IP '$($arguments.HostIp)'"
    }

    Start-Website -Name 'ProGet' -ErrorAction SilentlyContinue
}