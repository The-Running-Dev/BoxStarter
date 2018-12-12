$arguments          = @{
    url             = 'http://razerdrivers.s3.amazonaws.com/drivers/Synapse2/win/Razer_Synapse_Installer_v2.21.21.1.exe'
    checksum        = '40A8BACA006828D8DD73BA2BE98E0EB244A5227B1A5661108153889D14540CFD'
    silentArgs      = '/s'
}

Install-WithAutoHotKey $arguments
