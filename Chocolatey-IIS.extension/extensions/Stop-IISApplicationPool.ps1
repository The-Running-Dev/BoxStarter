function Stop-IISApplicationPool {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    $pool = Get-Item "IIS:\AppPools\$name" -ErrorAction SilentlyContinue

    if ($pool -and ((get-WebAppPoolState -name $name).Value -eq "Started")) {
        Write-Host "Stopping application pool '$name'..."
        Stop-WebAppPool -Name $appPool
    }
}