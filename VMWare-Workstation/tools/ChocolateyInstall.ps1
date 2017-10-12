$arguments          = @{
    url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-14.0.0-6661328.exe'
    checksum        = 'C596279ECEB407D376DAAE2E91038529182AF24A3144AFC451AA85E9F41D48DD'
    silentArgs      = '/s /v/qn EULAS_AGREED=1'
}

Install-Package $arguments
