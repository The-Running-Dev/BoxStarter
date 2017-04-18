function Install-WithScheduledTask() {
    param(
        [Hashtable] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if (!(Test-FileExists $packageArgs.file)) {
        Write-Message "Install-WithCopy: Downloading from '$($arguments.url)'"
        $arguments.file = Get-ChocolateyWebFile @packageArgs
    }

    Write-Message "Install-WithScheduledTask: Installing '$($arguments.file)'"
    Invoke-ScheduledTask $arguments.packageName $arguments.file $arguments.silentArgs
}