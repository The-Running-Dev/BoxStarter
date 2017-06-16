$arguments = @{
    file       = 'VMware-PowerCLI-6.5.0-4624819.exe'
    checksum   = 'F5AE37B2B010884924850C9C29EFBB0D544709217DD57CF291FB42C5C4D1954F'
    silentArgs = '/S /v/qn'
}

Install-Package $arguments

$env:PSModulePath += ";${env:ProgramFiles(x86)}\VMware\Infrastructure\PowerCLI\Modules"
