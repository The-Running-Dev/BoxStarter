function Invoke-Executables {
    param(
		[string] $path
	)

    $exes = Get-ChildItem -Path $path -Filter *.exe -Recurse

    foreach ($e in $exes) {
        try {
            Write-Message "Running $e"

            & $e
        }
        catch {
            Write-Message "Invoke-Executables Failed: $e, Message: $($_.Exception.Message)"
        }
    }
}