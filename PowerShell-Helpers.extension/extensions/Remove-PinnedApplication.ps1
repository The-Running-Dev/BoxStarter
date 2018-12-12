function Remove-PinnedApplication {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $path
    )

    try {
        if ($path -match '\$') {
            $path = Invoke-Expression $path
        }

        if ([System.IO.File]::Exists($path)) {
            Write-Message "Remove-PinnedApplication: Removing Taskbar Pin '$path'..."

            & $global:pinTool $path c:"Unpin from taskbar" | Out-Null
        }
    }
    catch {
        Write-Message "Invoke-PinApplication Failed: $($_.Exception.Message)"
    }
}