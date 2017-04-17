function Install-WithScheduledTask() {
    param(
        [Hashtable] $arguments
    )

    $arguments.file = Get-Installer $arguments

    if (Test-FileExists $arguments['file']) {
		Write-Message "Install-WithScheduledTask: Installing '$($arguments['file'])'"

        Invoke-ScheduledTask $arguments['packageName'] $arguments['file'] $arguments['silentArgs']

        CleanUp
    }
    else {
		Write-Message 'Install-WithProcess: No Installer or Url Provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}