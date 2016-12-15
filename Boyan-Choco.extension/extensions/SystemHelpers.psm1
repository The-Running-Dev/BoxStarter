function IsSystem32Bit()
{
    return 
        ($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
        ($Env:PROCESSOR_ARCHITEW6432 -eq $null)
}

function Start-ScheduledTask() {
    param(
        [Hashtable] $arguments
    )

    $action = New-ScheduledTaskAction -Execute $arguments['file'] -Argument $arguments['silentArgs']
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)

    Register-ScheduledTask -TaskName $arguments['packageName'] -Action $action -Trigger $trigger
    Start-ScheduledTask -TaskName $arguments['packageName']
    Start-Sleep -s 1
    Unregister-ScheduledTask -TaskName $arguments['packageName'] -Confirm:$false
}