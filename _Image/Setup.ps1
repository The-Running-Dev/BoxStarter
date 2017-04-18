# Execute each PowerShell script under the "Scripts" directory
foreach ($s in (Get-ChildItem -Path 'C:\Setup' -Filter *.ps1 -Recurse)) {
    & $s.FullName > C:\Setup\Setup.log
}