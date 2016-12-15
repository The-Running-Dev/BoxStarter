$global:ahkCompiler = Join-Path $PSScriptRoot "AutoHotKey\Ahk2Exe.exe"

function CompileAutoHotKey([string] $directoryPath) {
    $ahkFiles = Get-ChildItem -Path $directoryPath -Filter *.ahk -Recurse

    foreach ($f in $ahkFiles) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}