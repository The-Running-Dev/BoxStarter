function Get-FromJson
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [string] $file
    )

    try {
    	$fileAsJson = Get-Content $file `
            -Raw -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue | ConvertFrom-JsonNewtonsoft `
            -ErrorAction:SilentlyContinue `
            -WarningAction:SilentlyContinue
    } catch {
    	Write-Error -Message "The File $file Cannot Be Read!"
    }

    # Check the file
    if (!($fileAsJson)) {
    	Write-Error -Message "The File $file Cannot Be Read!"
    }

    return $fileAsJson
}