$arguments      = @{
    file        = 'mysql-workbench-community-6.3.9-winx64.msi'
    $url        = 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.9-winx64.msi'
    $checksum   = 'FA93CFF0124F65E94DAC4749A4C2BCDF5F79E1ECAE3777E5D276B4D5491B7FC5'
    silentArgs  = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
