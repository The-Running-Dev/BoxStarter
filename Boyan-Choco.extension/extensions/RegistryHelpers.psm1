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

function ImportRegistrySettings([string] $path) {
    $files = Get-ChildItem -Path $path -Filter *.reg -Recurse

    foreach ($f in $files) {
        try {
            & regedit /s $f
        }
        catch {
            Write-Host "Failed Importing: $f, Message: $($_.Exception.ToString())"
        }
    }
}