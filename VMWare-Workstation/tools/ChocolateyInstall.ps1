$arguments          = @{
    url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-12.5.6-5528349.exe'
    checksum        = 'EC5C654C2F61AF93EB38B6A28B45743916AA5FDD6D522492F36EC0B4B4434223'
    silentArgs      = '/s /v/qn EULAS_AGREED=1'
}

Install-Package $arguments
