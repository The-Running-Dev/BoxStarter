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