$scriptRoot = Split-Path $MyInvocation.MyCommand.Definition

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo')
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SmoExtended')

$pre = Get-ChildItem Function:\*
Get-ChildItem -Recurse "$scriptRoot\*.ps1" | Where-Object { $_.Name -cmatch '^[A-Z]+' } | ForEach-Object { . $_  }

$post = Get-ChildItem Function:\*
$funcs = Compare-Object $pre $post | Select-Object -Expand InputObject | Select-Object -Expand Name
$funcs | Where-Object { $_ -cmatch '^[A-Z]+'} | ForEach-Object { Export-ModuleMember -Function $_ }