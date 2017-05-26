function Assert-TcpPortIsOpen {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][int] $portNumber
    )

    $process = Get-NetTCPConnection -State Listen -LocalPort $portNumber -ErrorAction SilentlyContinue | `
        Select-Object -First 1 -ExpandProperty OwningProcess | `
        Select-Object @{Name = "Id"; Expression = {$_} } | `
        Get-Process | `
        Select-Object Name, Path

    if ($process) {
        Write-Host 'Port' $arguments.servicePortNumber 'is in use by' $process.Name 'with path'  $process.Path
        Write-Host 'Please specify a different port. TeamCity cannot be installed...aborting.'

        return $false
    }

    return $true
}