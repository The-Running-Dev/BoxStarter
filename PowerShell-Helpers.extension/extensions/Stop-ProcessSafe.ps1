function Stop-ProcessSafe {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [switch] $wait
    )

    if ($wait) {
        $done = $false
        do {
            if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
                Stop-Process -Name $name
                $done = $true
            }

            Start-Sleep 5

        }
        until ($done)
    }
    elseif (Get-Process -Name $name -ErrorAction SilentlyContinue) {
        Stop-Process -Name $name
    }
}