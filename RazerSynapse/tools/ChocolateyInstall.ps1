$arguments          = @{
    url             = 'http://razerdrivers.s3.amazonaws.com/drivers/Synapse2/win/Razer_Synapse_Installer_v2.21.18.115.exe'
    checksum        = 'CA5371480D60513F45D73C3961A860ED0779F8A5C30C084833C517B7C71CD244'
    silentArgs      = '/s'
}

Install-WithAutoHotKey $arguments
