$arguments          = @{
    url             = 'http://razerdrivers.s3.amazonaws.com/drivers/Synapse2/win/Razer_Synapse_Installer_v2.21.00.830.exe'
    checksum        = 'DFFAE78BD4290910122639BA8C7C4ADB2FD90BC58B728CF6D7ACEF5273D91F9A'
    silentArgs      = '/s'
}

Install-WithAutoHotKey $arguments
