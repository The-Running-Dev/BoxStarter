function Stop-ProcessSafe {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
        Stop-Process -processname $name
    }
}