Import-Module (Join-Path -Resolve $PSScriptRoot 'Newtonsoft.psm1')

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

function Expand-ToDirectory()
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $file,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $destination
    )

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}

function Copy-Files
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $source,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $destination
    )

    Write-Host "Starting to Copy $source to $destination"

    $timer = [System.Diagnostics.Stopwatch]::StartNew()
    $success = $false
    do
    {
        try
        {
            Copy-Item -Recurse -Force $source $destination
            $success = $true
        }
        catch { }

        if(!$success)
        {
            Write-Host "Trying Again in 5 Seconds..."
            Start-Sleep -s 5
        }
    }
    while(!$success -and $timer.Elapsed -le (New-TimeSpan -Seconds $timeoutSeconds))

    $timer.Stop()

    if(!$success)
    {
        throw "Copy Failed - Giving Up."
    }

    Write-Host "Copy Sucesss!"
}

Export-ModuleMember -Function *