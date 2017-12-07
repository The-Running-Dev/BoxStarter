function Start-Service() {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )
    $serviceInstance = Get-Service $name -ErrorAction SilentlyContinue

    if ($serviceInstance -ne $null) {
        Write-Output "Starting $name..."

        if ($serviceInstance.Status -eq "Running") {
        Write-Output "The $name Service is Already Running."
        } else {
            start-service $name
            $serviceInstance.WaitForStatus('Running', '00:01:00')
            Write-Output "Started $name"
        }
    }
    else {
        Write-Output "The $name Does Not Exist."
    }
}