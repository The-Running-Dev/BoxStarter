$packageName = 'microsoft-build-tools'
$installerType = 'EXE'
$url = 'https://download.microsoft.com/download/5/A/8/5A8B8314-CA70-4225-9AF0-9E957C9771F7/vs_BuildTools.exe'
$checksum = 'E77D433C44F3D0CBF7A3EFA497101DE93918C492C2EBCAEC79A1FAF593D419BC'
$checksumType = 'sha256'
$silentArgs = "--quiet --norestart --add Microsoft.VisualStudio.Workload.WebBuildTools"
$validExitCodes = @(0,3010)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum "$checksum" -checksumType "$checksumType" -validExitCodes $validExitCodes