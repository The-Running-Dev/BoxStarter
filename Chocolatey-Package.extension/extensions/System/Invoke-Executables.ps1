function Invoke-Executables([string] $path) {
    $exes = Get-ChildItem -Path $path -Filter *.exe -Recurse

    foreach ($e in $exes) {
        try {
            Write-Host "Running $e"

            & $e
        }
        catch {
            Write-Host "Invoke-Executables Failed: $e, Message: $($_.Exception.Message)"
        }
    }
}