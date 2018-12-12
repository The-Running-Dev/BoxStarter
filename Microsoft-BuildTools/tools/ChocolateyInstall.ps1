$updatedOn = ''
$arguments = @{
    file           = 'vs_buildtools.exe'
    url            = 'https://download.visualstudio.microsoft.com/download/pr/a46d2db7-bd7b-43ee-bd7b-12624297e4ec/11b9c9bd44ec2b475f6da3d1802b3d00/vs_buildtools.exe'
    checksum       = '274D5604741D99951BAEC415966D278018F871A99EA1A11EA9FC2ADBD13F5D1D'
    executable     = 'Microsoft-Build-Tools\vs_BuildTools.exe'
    executableArgs = '--quiet --norestart --add Microsoft.Net.Component.4.6.1.SDK;Microsoft.Net.Component.4.6.1.TargetingPack;Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-FromZip $arguments
