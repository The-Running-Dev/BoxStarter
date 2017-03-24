<#
function Test-RegistryValue
{
    param (
        [parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $path,
        [parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] $value
    )

    try
    {
        if (Test-Path -Path $Path)
        {
            Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
            return $true
        }
    }
    catch
    {
        return $false
    }
}

function Import-RegistrySettings([string] $path)
{
    $files = Get-ChildItem -Path $path -Filter *.reg -Recurse

    foreach ($f in $files) {
        try {
            Write-Host "Importing: $($f.FullName)"
            & regedit /s $f.FullName
        }
        catch {
            Write-Host "Failed Importing: $f, Message: $($_.Exception.ToString())"
        }
    }
}

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
            Write-Host "Importing: $($parameters['file'])"
            & regedit /s $parameters['file']
        }
    }
    catch {
        Write-Host "Failed Importing: $($parameters['file']), Message: $($_.Exception.Message)"
    }
}
#>