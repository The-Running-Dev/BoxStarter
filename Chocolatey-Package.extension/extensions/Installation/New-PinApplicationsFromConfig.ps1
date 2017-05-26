function Invoke-PinApplications {
    param(
		[string] $configFile
	)

    try {
        foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
            New-PinnedApplication $line
        }
    }
    catch {
        Write-Message "Invoke-PinApplications Failed: $($_.Exception.Message)"
    }
}