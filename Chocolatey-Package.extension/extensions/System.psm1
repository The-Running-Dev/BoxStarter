$global:pinTool = (Join-Path $PSScriptRoot 'syspin.exe')

function IsSystem32Bit() {
    return
    ($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null)
}

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

function Invoke-PinApplications([string] $configFile) {
    try {
        foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
            Invoke-PinApplication $line
        }
    }
    catch {
        Write-Host "Invoke-PinApplications Failed: $($_.Exception.Message)"
    }
}

function Invoke-PinApplication([string] $applicationPath) {
    try {
        if ($applicationPath.Contains('$')) {
            $applicationPath = Invoke-Expression $applicationPath
        }

        if ([System.IO.File]::Exists($applicationPath)) {
            & $global:pinTool $applicationPath c:"Pin to taskbar" | Out-Null
        }
    }
    catch {
        Write-Host "Invoke-PinApplication Failed: $($_.Exception.Message)"
    }
}

Export-ModuleMember *