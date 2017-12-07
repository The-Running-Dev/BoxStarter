..\build-push.ps1 .\ProGet\ -f

Restore-Win10VMSnapshot

Connect-BoxStarterShare

Copy-Item D:\Dropbox\BoxStarter\ProGet.4.7.11.nupkg \\win10-vm\BoxStarter
Copy-Item D:\Dropbox\BoxStarter\Powershell-Carbon.2.4.1.nupkg \\win10-vm\BoxStarter
Copy-Item D:\Dropbox\BoxStarter\Windows-IIS* \\win10-vm\BoxStarter

Invoke-Command -ComputerName Win10-VM -ScriptBlock {
    cd C:\BoxStarter
    choco install ProGet -s . --params '/ConnectionString="Server=badass;Database=ProGet;Integrated Security=SSPI;"'
}