Remove-Item (Join-Path $env:AppData 'DBMigration') -Recurse -Force

$destdir = ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
Remove-Item "$destdir\DBMigration.lnk" -force -ErrorAction SilentlyContinue