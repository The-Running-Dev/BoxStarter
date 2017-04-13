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