function Stop-ProcessSafe
{
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $name
    )

    if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
        Stop-Process -processname $name
    }
}

function Get-ProcessPath {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $name
    )

    $path = ''
    $process = Get-Process -Name $name -ErrorAction SilentlyContinue

    if ($process) {
        $path = $process.Path
    }

    return $path
}

Export-ModuleMember -Function *