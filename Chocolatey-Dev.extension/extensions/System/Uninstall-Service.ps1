function Uninstall-Service {
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $serviceName
    )

    $service = Get-Service $serviceName -ErrorAction SilentlyContinue

    if ($service) {
        Stop-Service $service

        & sc.exe delete $serviceName
    }
}