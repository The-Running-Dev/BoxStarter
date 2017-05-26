$packageChecksum    = '502188E31A70A0FD746BAC58A3B7229C8A3C83BCA554CBA050D6301600BAF531'
$arguments          = @{
    file            = 'Microsoft-Build-Tools.7z'
    url             = 'https://download.microsoft.com/download/A/6/3/A637DB94-8BA8-43BB-BA59-A7CF3420CD90/vs_BuildTools.exe'
    executable      = 'vs_BuildTools.exe'
    executableArgs  = '--quiet --norestart --add Microsoft.Net.Component.4.6.1.SDK;Microsoft.Net.Component.4.6.1.TargetingPack;Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-FromZip $arguments
