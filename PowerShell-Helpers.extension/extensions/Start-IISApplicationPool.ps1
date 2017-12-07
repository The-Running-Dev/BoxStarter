function Start-IISApplicationPool {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    $pool = Get-Item "IIS:\AppPools\$name" -ErrorAction SilentlyContinue

    if ($pool -and ((Get-WebAppPoolState -name $name).Value -eq "Stopped")) {
        Write-Host "Starting application pool '$name'..."
        Start-WebAppPool -Name $pool | Out-Null
    }
}