$arguments          = @{
    url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-14.1.0-7370693.exe'
    checksum        = 'CEAE5D2D1F4542FC29D3D1D9DE77E9707829CF6BB9098EC598C04A4D15B31DFC'
    silentArgs      = '/s /v/qn EULAS_AGREED=1'
}

Install-Package $arguments
