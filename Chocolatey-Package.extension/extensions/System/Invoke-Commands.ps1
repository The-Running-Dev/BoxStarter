function Invoke-Commands {
    param(
		[string] $file,
        [string] $commandTemplate
	)

    try {
        foreach ($line in Get-Content -Path $file | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $commmand = $commandTemplate.replace("##token##", $line)

            Write-Message "Running: $commmand"

            Invoke-Expression $commmand
        }
    }
    catch {
         Write-Message "Invoke-Commands Failed: $($_.Exception.Message)"
    }
}