Remove-Item (Join-Path $env:AppData 'DatabaseDotNET') -Recurse -Force

$destdir = ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
Remove-Item "$destdir\Database4.lnk" -force -ErrorAction SilentlyContinue