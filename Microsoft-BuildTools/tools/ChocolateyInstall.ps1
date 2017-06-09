$updatedOn = '502188E31A70A0FD746BAC58A3B7229C8A3C83BCA554CBA050D6301600BAF531'
$arguments = @{
    file           = 'Microsoft-Build-Tools.7z'
    url            = 'https://download.microsoft.com/download/9/6/B/96BB3A55-857C-4E4A-A805-67E078405018/vs_BuildTools.exe'
    checksum       = 'F7ACFDF9B3FE53A7AFCCAA2257B625EB430D63D38161005C7F28E71A7030F5EC'
    executable     = 'Microsoft-Build-Tools\vs_BuildTools.exe'
    executableArgs = '--quiet --norestart --add Microsoft.Net.Component.4.6.1.SDK;Microsoft.Net.Component.4.6.1.TargetingPack;Microsoft.VisualStudio.Workload.WebBuildTools'
}

Install-FromZip $arguments
