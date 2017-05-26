$packageName = 'databasenet'
$zipfileName = 'DatabaseNet4.zip'
try {
	$destdir = ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
	remove-item "$destdir\Database4.lnk" -force -erroraction silentlycontinue
} catch {
	throw
}