function Save-ToJson {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $json,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $file
    )

    try {
        $json | ConvertTo-JsonNewtonsoft > $file `
            -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue
    } catch {
        Write-Error -Message "The File $file Cannot Be Saved!"
    }
}