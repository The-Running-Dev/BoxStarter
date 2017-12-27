$updatedOn = ''
$arguments = @{
    file           = 'vs_BuildTools.exe'
    url            = 'https://download.visualstudio.microsoft.com/download/pr/100404314/e64d79b40219aea618ce2fe10ebd5f0d/vs_BuildTools.exe'
    checksum       = '6A77083C2FAF9CA044E665665DDBE7C0FD8EBEC9608F9615F77B0BDED97AAB69'
    executable     = 'Microsoft-Build-Tools\vs_BuildTools.exe'
    executableArgs = '--quiet --norestart --add Microsoft.Net.Component.4.6.1.SDK;Microsoft.Net.Component.4.6.1.TargetingPack;Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-FromZip $arguments
