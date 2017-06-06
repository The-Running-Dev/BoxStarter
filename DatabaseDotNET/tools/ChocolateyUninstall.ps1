$destdir = ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))

Remove-Item (Join-Path $env:AppData 'DatabaseDotNET') -Recurse -Force
Remove-Item "$destdir\Database4.lnk" -force -ErrorAction SilentlyContinue