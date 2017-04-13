function Save-ToJson
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][object] $json,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $file
    )

    try {
    	$json | ConvertTo-JsonNewtonsoft > $file `
            -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue
    } catch {
    	Write-Error -Message "The File $file Cannot Be Saved!"
    }
}