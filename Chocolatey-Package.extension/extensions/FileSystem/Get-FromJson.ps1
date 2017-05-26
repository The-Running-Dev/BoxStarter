function Get-FromJSON {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $file
    )

    try {
        $fileAsJson = Get-Content $file `
            -Raw -ErrorAction:SilentlyContinue | `
            ConvertFrom-JsonNewtonsoft -ErrorAction:SilentlyContinue
    } catch {
        Write-Error -Message "The file $file cannot be read..."
    }

    # Check the file
    if (!($fileAsJson)) {
        Write-Error -Message "The File $file cannot be read..."
    }

    return $fileAsJson
}