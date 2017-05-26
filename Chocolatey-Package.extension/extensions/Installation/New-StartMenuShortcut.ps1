function New-StartMenuShortcut {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $path
    )

    $linkFile = (Split-Path -Leaf $path) -replace '\.\w+$', '.lnk'
    $applicationShortcutPath = Join-Path (Join-Path $env:AppData 'Microsoft\Windows\Start Menu\Programs') $linkFile

    Write-Message "New-StartMenuShortcu: Creating shortcut to '$path' with '$applicationShortcutPath'..."

    Install-ChocolateyShortcut `
        -ShortcutFilePath $applicationShortcutPath `
        -TargetPath $path `

}