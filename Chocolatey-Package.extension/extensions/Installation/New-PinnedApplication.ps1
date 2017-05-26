function New-PinnedApplication {
    param(
        [PSCustomObject] $applicationPath
    )

    try {
        if ($applicationPath.Contains('$')) {
            $applicationPath = Invoke-Expression $applicationPath
        }

        if ([System.IO.File]::Exists($applicationPath)) {
            $applicationShortcutPath = $applicationPath -replace '\.\w+$', '.lnk'

            Write-Message "New-PinnedApplication: Pinning $applicationPath with $applicationShortcutPath"

            Install-ChocolateyShortcut `
                -ShortcutFilePath $applicationShortcutPath `
                -TargetPath $applicationPath `
                -RunAsAdmin

            & $global:pinTool $applicationPath c:"Pin to taskbar" | Out-Null
        }
    }
    catch {
        Write-Message "Invoke-PinApplication Failed: $($_.Exception.Message)"
    }
}