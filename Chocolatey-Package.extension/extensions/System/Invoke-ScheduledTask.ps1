function Invoke-ScheduledTask() {
    param(
        [string] $name,
        [string] $executable,
        [string] $arguments
    )

    $action = New-ScheduledTaskAction -Execute $executable -Argument $arguments
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)

    Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger
    Start-ScheduledTask -TaskName $name
    Start-Sleep -s 1
    Unregister-ScheduledTask -TaskName $name -Confirm:$false
}