$global:mustDismountIso         = $false
$global:pinTool                 = Join-Path $PSScriptRoot 'Bin\syspin.exe' -Resolve
$global:defaultValidExitCodes   =  @(0, 1603, 1641, 3010)


$existingFunctions = Get-ChildItem Function:\*

# Include file names that start with capital letters, ignore .Tests
Get-ChildItem -Recurse "$PSScriptRoot\*.ps1" | Where-Object { $_.Name -cmatch '^[A-Z]+' -and $_.Name -notmatch '\.Tests' } | ForEach-Object { . $_  }

$existingAndNewFunctions = Get-ChildItem Function:\*

$exportFunctions = Compare-Object $existingFunctions $existingAndNewFunctions | Select-Object -Expand InputObject | Select-Object -Expand Name

# Export functions that start with capital letter, others are private
$exportFunctions | Where-Object { $_ -cmatch '^[A-Z]+'} | ForEach-Object { Export-ModuleMember -Function $_ }