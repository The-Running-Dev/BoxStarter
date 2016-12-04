function CompileAutoHotKey([string] $directoryPath) {
    $ahkCompiler = 'C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe'
    $ahkFiles = Get-ChildItem -Path $directoryPath -Filter *.ahk -Recurse

    foreach ($f in $ahkFiles) {
        Start-Process $ahkCompiler "/in $($f.FullName)" -Wait
    }
}