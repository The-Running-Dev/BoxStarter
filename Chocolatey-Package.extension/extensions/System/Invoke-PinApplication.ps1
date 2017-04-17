function Invoke-PinApplication {
    param(
		[string] $applicationPath
	)

    try {
        if ($applicationPath.Contains('$')) {
            $applicationPath = Invoke-Expression $applicationPath
        }

        if ([System.IO.File]::Exists($applicationPath)) {
            & $global:pinTool $applicationPath c:"Pin to taskbar" | Out-Null
        }
    }
    catch {
        Write-Message "Invoke-PinApplication Failed: $($_.Exception.Message)"
    }
}