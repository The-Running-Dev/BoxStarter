function Invoke-AutoHotKey {
    param (
        [Parameter(Position = 0, Mandatory = $true)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Position = 1, Mandatory = $true)][object] $files = @{}
    )

    if (!$files) {
        $files = Get-ChildItem -Path $baseDir -Filter *.ahk -Recurse
    }

    foreach ($f in $files) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}