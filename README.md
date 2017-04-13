## Chocolatey Custom Packages

  * Packages are updated faster than the same packages on the Chocoloatey community feed
  * Packages support custom installer location through a Chocolatey extension
    * As part of the package itself
    * A local or network location where to look for the installer
    * Downloading the installer from the internet
    * Installer inside a zip file
  * Most packages support automatic updates through the AU module, with the provided ```update.ps1``` script
  * AutoHotkey is used whenver full silent installation is not possible (Example ESET Nod32 Antivirus)

## To Run as Is
  * Chocolatey, in PowerShell run
  ```
  Set-ExecutionPolicy Unrestricted

  choco source add -n='BoxStarter' -s 'http://54.210.14.187/NuGet.Hosting/nuget' -priority=1
  choco source add -n=Chocolatey -s "https://chocolatey.org/api/v2/" -priority=2
  ```

## Chocolatey Packages
  * ConEmu
    ```
    choco install ConEmu
    ```
  * Internet Information Service (IIS)
    ```
    choco install Windows.IIS
    ```
  * JetBrains DataGrip
    ```
    choco install JetBrains.DataGrip
    ```
  * JetBrains ReSharper

    Installs ReShraper and all other applications. Plus the Visual Studio 2015 addin.
    ```
    choco install JetBrains.ReSharper
    ```
  * JetBrains WebStorm
    ```
    choco install JetBrains.WebStorm
    ```
    ```
    choco install WebStorm
    ```
  * Microsoft SQL Server 2014 Developer

    Features installed through the default configuraiton file
    ```
    Database Engine Services, Data Qualty Client, Client Tools Connectivity, Integration Services, ManagemetnT Tools - Basic, ManagemetnT Tools - Complete.
    ```
    ```
    choco install MSSQLServer2014Developer -params '/SetupPath="E:\setup.exe"'
    ````
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
  * Slack
    ```
    choco install Slack
    ```
    ```
  * Spotify
    ```
    choco install Spotify
    ```

## Short Links
  * [Install BoxStarter](http://bit.ly/win10boxstarter)
  * [Install Chocolatey](http://bit.ly/win10boxstarter-choco)
  * [SQL Server Configuration](http://bit.ly/win10boxstarter-sqlserverconfig)
  * [Visual Studio AdminFile](http://bit.ly/win10boxstarter-vsadmin)
  * [Visual Studio BuildOnSave Add-In](http://bit.ly/win10boxstarert-vs-buildonsave)
  * [Visual Studio SaveAllTheTime Add-In](http://bit.ly/win10boxstarert-vs-saveallthetime)
  * [Visual Studio SpellChecker Add-In](http://bit.ly/win10boxstarter-vs-spellchecker)

## References
  * [Running Visual Studio Install from the Command Line](https://msdn.microsoft.com/en-us/library/mt720584.aspx)
  * [Visual Studio Package on Chocolatey](https://chocolatey.org/packages/VisualStudio2015Enterprise)

## Editor
https://jbt.github.io/markdown-editor