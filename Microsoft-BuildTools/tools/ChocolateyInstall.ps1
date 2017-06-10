$updatedOn = ''
$arguments = @{
    file           = 'Microsoft-Build-Tools.7z'
    url            = 'https://download.visualstudio.microsoft.com/download/pr/10674754/e64d79b40219aea618ce2fe10ebd5f0d/vs_BuildTools.exe'
    checksum       = '502188E31A70A0FD746BAC58A3B7229C8A3C83BCA554CBA050D6301600BAF531'
    executable     = 'Microsoft-Build-Tools\vs_BuildTools.exe'
    executableArgs = '--quiet --norestart --add Microsoft.Net.Component.4.6.1.SDK;Microsoft.Net.Component.4.6.1.TargetingPack;Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-FromZip $arguments
