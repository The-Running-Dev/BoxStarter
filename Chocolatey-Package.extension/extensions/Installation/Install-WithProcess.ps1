function Install-WithProcess() {
    param(
        [PSCustomObject] $arguments,
        [switch] $wait
    )

    $packageArgs = Get-Arguments $arguments

    if ((Test-FileExists $packageArgs.file)) {
        Write-Message "Install-WithProcess: Installing $($arguments.file)"

        if ($wait) {
            Start-Process $packageArgs.file $arguments.silentArgs -Wait -NoNewWindow
        }
        else {
            Start-Process $packageArgs.file $arguments.silentArgs -NoNewWindow
        }
    }
    else {
        Write-Message 'Install-WithProcess: No installer or url provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}