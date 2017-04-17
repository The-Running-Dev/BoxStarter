function Install-WithProcess() {
    param(
        [PSCustomObject] $arguments
    )

    $arguments.file = Get-Installer $arguments

    if (Test-FileExists $arguments['file']) {
        Write-Message "Install-WithProcess: Installing '$($arguments['file'])'"

        Start-Process $arguments['file'] $arguments['silentArgs'] -Wait -NoNewWindow

        CleanUp
    }
    else {
		Write-Message 'Install-WithProcess: No installer or url provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}