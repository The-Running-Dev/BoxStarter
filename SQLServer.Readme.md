## Microsoft SQL Server Instructions
  * Microsoft SQL Server 2014 Developer

    Features installed through the default configuration file
    ```
    Database Engine Services, Data Qualty Client, Client Tools Connectivity, Integration Services, ManagemetnT Tools - Basic, ManagemetnT Tools - Complete.
    ```
    choco install MSSQLServer2014Developer -params '/SetupPath="E:\setup.exe"'
    ```
    choco install MSSQLServer2014Developer `
      -params '/SetupPath="E:\setup.exe" /SECURITYMODE="SQL" /SAPWD="SetComplexPassword" /InstallSQLDataDir="D:\SQLData" /SQLBACKUPDIR="D:\SQLData\Backup" /SQLUSERDBDIR="D:\SQLData" /SQLTEMPDBDIR="D:\SQLData"'

    choco isnstall MSSQLServer2016Developer `
      -params "/file='Path\To\en_sql_server_2016_developer_with_service_pack_1_x64_dvd_9548071.iso'"
    ```
  * Microsoft SQL Server 2014 Express

    Install with the default parameters from the Configuration.ini inside the package.
    ```
    choco install MSSQLServer2014Express
    ```
    Install with SQL Authentication. You have to specify the "sa" password.
    ```
    choco install MSSQLServer2014Express `
      -params='/SECURITYMODE="SQL" /SAPWD="SetYourOwn"'
    ```
    Install overriding some parameters.
    ```
    choco install MSSQLServer2014Express `
      -params='/SAPWD="SetYourOwn" /InstallSQLDataDir="C:\SQLData" /SQLBACKUPDIR="C:\SQLData\Backup" /SQLUSERDBDIR="C:\SQLData" /SQLTEMPDBDIR="C:\SQLData" /SQLSYSADMINACCOUNTS="Boyan"'
    ```

    Install with overriding some parameters, and your own Configuraiton.ini (by specifing the URL to Configuration.ini).
    ```
    choco install MSSQLServer2014Express `
      -params='/SAPWD="SetYourOwn" /InstallSQLDataDir="C:\SQLData" /SQLBACKUPDIR="C:\SQLData\Backup" /SQLUSERDBDIR="C:\SQLData" /SQLTEMPDBDIR="C:\SQLData" /ConfigurationFile="http://bit.ly/2doxBU1"'
    ```