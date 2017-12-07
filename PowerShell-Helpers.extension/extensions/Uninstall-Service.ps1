function Uninstall-Service {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $serviceName
    )

    if (Get-Service $serviceName -ErrorAction SilentlyContinue) {
        Stop-Service $serviceName
        & sc.exe delete $serviceName
    }
}