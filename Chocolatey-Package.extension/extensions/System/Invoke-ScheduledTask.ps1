function Invoke-ScheduledTask() {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $executable,
        [Parameter(Position = 2, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $arguments
    )

    $action = New-ScheduledTaskAction -Execute $executable -Argument $arguments
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)

    Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger | Out-Null
    Start-ScheduledTask -TaskName $name | Out-Null
    Start-Sleep -s 1
    Unregister-ScheduledTask -TaskName $name -Confirm:$false | Out-Null
}