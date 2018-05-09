$updatedOn = ''
$arguments = @{
    file           = 'vs_BuildTools.exe'
    url            = 'https://download.visualstudio.microsoft.com/download/pr/12210059/e64d79b40219aea618ce2fe10ebd5f0d/vs_BuildTools.exe'
    checksum       = '274D5604741D99951BAEC415966D278018F871A99EA1A11EA9FC2ADBD13F5D1D'
    executable     = 'Microsoft-Build-Tools\vs_BuildTools.exe'
    executableArgs = '--quiet --norestart --add Microsoft.Net.Component.4.6.1.SDK;Microsoft.Net.Component.4.6.1.TargetingPack;Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-FromZip $arguments
