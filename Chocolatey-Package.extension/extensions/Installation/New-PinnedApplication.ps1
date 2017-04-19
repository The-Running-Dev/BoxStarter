function New-PinnedApplication() {
    param(
        [PSCustomObject] $shortcutTargetPath
    )

    $shortcutFilePath = $shortcutTargetPath -replace '\.\w+$', '.lnk'

    Install-ChocolateyShortcut `
        -ShortcutFilePath $shortcutFilePath `
        -TargetPath $shortcutTargetPath `
        -WindowStyle 3 `
        -RunAsAdmin `
        -PinToTaskbar
}