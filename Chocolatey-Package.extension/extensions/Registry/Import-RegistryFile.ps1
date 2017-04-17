function Import-RegistryFile
{
    param (
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][Hashtable] $parameters
    )

    try {
        # If settings are provided and the file exists
        if ([System.IO.File]::Exists($parameters['file'])) {
            if ([System.IO.File]::Exists($parameters['executable'])) {
                & $parameters['executable']
            }

            if ($parameters['process']) {
                if (Get-Process -Name $parameters['process']) {
                    # Kill the started application
                    Stop-Process -Name $parameters['process']
                }
            }

            # Import the provided settings
            Write-Message "Importing: $($parameters['file'])"
            & regedit /s $parameters['file']
        }
    }
    catch {
        Write-Message "Failed Importing: $($parameters['file']), Message: $($_.Exception.Message)"
    }
}