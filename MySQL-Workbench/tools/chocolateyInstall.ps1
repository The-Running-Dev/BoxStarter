$arguments      = @{
    url         = 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.13-winx64.msi'
    checksum    = '12CD112C94FCFEDA9A895889FFE2DD879A2D096B5C7AC1AE284AB2AB910A9970'
    silentArgs  = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
