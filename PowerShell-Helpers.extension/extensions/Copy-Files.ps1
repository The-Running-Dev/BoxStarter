function Copy-Files {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_})][string] $source,
        [Parameter(Position = 1, Mandatory, ValueFromPipeline)][string] $destination
    )

    Write-Host "Starting to copy $source to $destination"

    $timer = [System.Diagnostics.Stopwatch]::StartNew()
    $success = $false
    do {
        try {
            Copy-Item -Recurse -Force $source $destination
            $success = $true
        }
        catch { }

        if (!$success) {
            Write-Host "Trying again in 5 seconds..."
            Start-Sleep 5
        }
    }
    while (!$success -and $timer.Elapsed -le (New-TimeSpan -Seconds $timeoutSeconds))

    $timer.Stop()

    if (!$success) {
        throw "Copy failed...giving up."
    }

    Write-Host "Copy Sucesseeded!"
}