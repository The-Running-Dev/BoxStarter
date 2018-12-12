$arguments          = @{
    url             = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-15.0.2-10952284.exe'
    checksum        = 'C4ADC199A474BDAF865F0EE661024A4B5A9E6C73D4C4047BB82128417D07C75C'
    silentArgs      = '/s /v/qn EULAS_AGREED=1'
}

Install-Package $arguments
