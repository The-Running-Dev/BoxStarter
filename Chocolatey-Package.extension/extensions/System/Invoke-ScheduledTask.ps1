function Invoke-ScheduledTask() {
    param(
        [string] $name,
        [string] $executable,
        [string] $arguments
    )

    $action = New-ScheduledTaskAction -Execute $executable -Argument $arguments
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)

    Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger | Out-Null
    Start-ScheduledTask -TaskName $name | Out-Null
    Start-Sleep -s 1
    Unregister-ScheduledTask -TaskName $name -Confirm:$false | Out-Null
}