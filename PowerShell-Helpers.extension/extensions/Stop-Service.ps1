function Stop-Service() {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    Write-Output "Stopping $name..."

    $serviceInstance = Get-Service $name -ErrorAction SilentlyContinue
    if ($serviceInstance -ne $null) {
        Stop-Service $name -Force
        $serviceInstance.WaitForStatus('Stopped', '00:01:00')
        Write-Output "Service $name stopped."
    } else {
        Write-Output "The $name service could not be located."
    }
}