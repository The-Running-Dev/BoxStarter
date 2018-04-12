$arguments          = @{
    url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-14.1.1-7528167.exe'
    checksum        = '2D360E5F90CDBEF9CBD1EC598B99890DFC26A06D7227BCBC30DA1EC635D055E8'
    silentArgs      = '/s /v/qn EULAS_AGREED=1'
}

Install-Package $arguments
