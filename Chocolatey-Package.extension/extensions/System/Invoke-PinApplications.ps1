function Invoke-PinApplications([string] $configFile) {
    try {
        foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
            Invoke-PinApplication $line
        }
    }
    catch {
        Write-Host "Invoke-PinApplications Failed: $($_.Exception.Message)"
    }
}