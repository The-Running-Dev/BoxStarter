function Invoke-AutoHotKey {
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][String] $baseDir
    )

    Get-ChildItem $baseDir*.ahk -Recurse | ForEach-Object {
        Start-Process $global:ahkCompiler "/in $($_.FullName)" -Wait
    }
}