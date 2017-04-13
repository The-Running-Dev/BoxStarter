function Invoke-AutoHotKey {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $true, Position = 2)][object] $files = @{}
    )

    if (!$files) {
        $files = Get-ChildItem -Path $baseDir -Filter *.ahk -Recurse
    }

    foreach ($f in $files) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}