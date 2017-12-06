$arguments      = @{
    url         = 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.10-winx64.msi'
    checksum    = 'ABB03477D1AF0748573B06C436A0A58F619607E6D63E3E9063E8120FD587294E'
    silentArgs  = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-Package $arguments
