Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

$c = Get-DirectoryConfiguration (Join-Path -Resolve . Drivers)

write-host $($c.remote.include | out-string)
write-host $($c.local.include | out-string)
#Get-ChildItem -Recurse -Include $c.local.include