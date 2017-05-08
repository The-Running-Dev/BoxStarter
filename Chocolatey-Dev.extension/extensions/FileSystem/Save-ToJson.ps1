function Save-ToJson
{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][object] $json,
        [Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $true)][string] $file
    )

    try {
    	$json | ConvertTo-JsonNewtonsoft > $file `
            -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue
    } catch {
    	Write-Error -Message "The File $file Cannot Be Saved!"
    }
}