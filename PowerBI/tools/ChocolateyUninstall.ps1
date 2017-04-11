$packageName = 'PowerBI'

# HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall
# HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\
# http://stackoverflow.com/questions/450027/uninstalling-an-msi-file-from-the-command-line-without-using-msiexec
$msiArgs = "/X{1824D216-16BB-44E2-9895-39B5C9B4D05C} /qb-! REBOOT=ReallySuppress"
Start-ChocolateyProcessAsAdmin "$msiArgs" 'msiexec'
