function Resolve-PathSafe
{
    param(
        [string] $path
    )

    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

function Add-Directory
{
    param(
        [string] $path
    )

    New-Item -ItemType Directory -Force -Path $path
}

function Remove-Directory
{
    param(
        [string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}

function Clear-Directory
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [Parameter(ValueFromPipeline = $true)][string[]] $exclude
    )

    Remove-Item -Path $path\** -exclude $exclude -recurse -force
}

function Remove-ItemSafe {
    [Alias("rm")]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}

Export-ModuleMember -Function *