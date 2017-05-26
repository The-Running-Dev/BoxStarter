function New-StartMenuShortcut {
    param(
        [PSCustomObject] $applicationPath
    )

    $linkFile = (Split-Path -Leaf $applicationPath) -replace '\.\w+$', '.lnk'
    $applicationShortcutPath = Join-Path (Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs') $linkFile

    Write-Message "New-StartMenuShortcu: Creating shortcut to $applicationPath with $applicationShortcutPath"

    Install-ChocolateyShortcut `
        -ShortcutFilePath $applicationShortcutPath `
        -TargetPath $applicationPath `
}