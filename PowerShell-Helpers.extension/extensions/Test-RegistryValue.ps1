function Test-RegistryValue {
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()] $path,
        [parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()] $value
    )

    try {
        if (Test-Path $path) {
            Get-ItemProperty -Path $path | Select-Object -ExpandProperty $value -ErrorAction Stop | Out-Null
            return $true
        }
    }
    catch {
        return $false
    }
}