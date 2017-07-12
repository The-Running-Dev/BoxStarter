$arguments          = @{
    url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-12.5.7-5813279.exe'
    checksum        = '43E89499B9AFD473B09D8BE71A6AB4C9ADE7D3BE572186FF51832931CA7B271D'
    silentArgs      = '/s /v/qn EULAS_AGREED=1'
}

Install-Package $arguments
