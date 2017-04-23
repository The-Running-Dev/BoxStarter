function Install-WithScheduledTask() {
    param(
        [Hashtable] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if (!(Test-FileExists $packageArgs.file)) {
        Write-Message "Install-WithScheduledTask: Downloading from '$($packageArgs.url)'"
        $packageArgs.file = Get-ChocolateyWebFile @packageArgs
    }

    Write-Message "Install-WithScheduledTask: Installing '$($packageArgs.file)'"
    Invoke-ScheduledTask $packageArgs.packageName $packageArgs.file $packageArgs.silentArgs
}