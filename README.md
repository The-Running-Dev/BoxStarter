## Windows 10 Dev PC BoxStarter
  1. With Custom Visual Studio AdminFile.xml
  2. With Custom SQL Server Configuration.ini

## To Run as Is
  * Chocolatey, in PowerShell run
  ```
  Set-ExecutionPolicy Unrestricted
  iex ((New-Object System.Net.WebClient).DownloadString('http://bit.ly/win10boxstarter-choco'))
  ```

## Chocolatey Packages
  * ConEmu
    ```
    choco install ConEmu -s "https://www.myget.org/F/win10"
    ```
  * Internet Information Service (IIS)
    ```
    choco install WinIIS -s"https://www.myget.org/F/win10/api/v2"
    ```
  * JetBrains DataGrip
    ```
    choco install DataGrip -s "https://www.myget.org/F/win10"
    ```
    ```
    choco install DataGrip -s "https://www.myget.org/F/win10" `
      -params='/SettingsPath="D:\Dropbox\Settings\.DataGrip2016.2.zip"'
    ```
  * JetBrains ReSharper

    Installs ReShraper and all other applications. Plus the Visual Studio 2015 addin.
    ```
    choco install ReSharper -s "https://www.myget.org/F/win10"
    ```
  * JetBrains WebStorm
    ```
    choco install WebStorm -s "https://www.myget.org/F/win10"
    ```
    ```
    choco install WebStorm -s "https://www.myget.org/F/win10" `
      -params='/SettingsPath="D:\Dropbox\Settings\.WebStorm2016.3.zip"'
    ```
  * Microsoft SQL Server 2014 Developer

    Features installed through the default configuraiton file
    ```
    Database Engine Services, Data Qualty Client, Client Tools Connectivity, Integration Services, ManagemetnT Tools - Basic, ManagemetnT Tools - Complete.
    ```
    ```
    choco install MSSQLServer2014Developer `
      -s "https://www.myget.org/F/win10;https://chocolatey.org/api/v2" `
      -params='/SetupPath="E:\setup.exe"'
    ````

    ```
    choco install MSSQLServer2014Developer `
      -s "https://www.myget.org/F/win10;https://chocolatey.org/api/v2" `
      -params='/SetupPath="E:\setup.exe" /SECURITYMODE="SQL" /SAPWD="SetComplexPassword" /InstallSQLDataDir="D:\SQLData" /SQLBACKUPDIR="D:\SQLData\Backup" /SQLUSERDBDIR="D:\SQLData" /SQLTEMPDBDIR="D:\SQLData"'
    ```
  * Microsoft SQL Server 2014 Express

    Install with the default parameters from the Configuration.ini inside the package.
    ```
    choco install MSSQLServer2014Express -s "https://www.myget.org/F/win10"
    ```

    Install with SQL Authentication. You have to specify the "sa" password.
    ```
    choco install MSSQLServer2014Express `
      -s "https://www.myget.org/F/win10" `
      -params='/SECURITYMODE="SQL" /SAPWD="SetYourOwn"'
    ```

    Install overriding some parameters.
    ```
    choco install MSSQLServer2014Express `
      -s "https://www.myget.org/F/win10" `
      -params='/SAPWD="SetYourOwn" /InstallSQLDataDir="C:\SQLData" /SQLBACKUPDIR="C:\SQLData\Backup" /SQLUSERDBDIR="C:\SQLData" /SQLTEMPDBDIR="C:\SQLData" /SQLSYSADMINACCOUNTS="Boyan"'
    ```

    Install with overriding some parameters, and your own Configuraiton.ini (by specifing the URL to Configuration.ini).
    ```
    choco install MSSQLServer2014Express `
      -s "https://www.myget.org/F/win10" `
      -params='/SAPWD="SetYourOwn" /InstallSQLDataDir="C:\SQLData" /SQLBACKUPDIR="C:\SQLData\Backup" /SQLUSERDBDIR="C:\SQLData" /SQLTEMPDBDIR="C:\SQLData" /ConfigurationFile="http://bit.ly/2doxBU1"'
    ```
  * Slack
    ```
    choco install Slack -s "https://www.myget.org/F/win10"
    ```
    ```
    choco install Slack `
      -s "https://www.myget.org/F/win10" `
      -params='/SettingsPath="D:\Dropbox\Settings\Slack.zip"'
    ```
  * Spotify
    ```
    choco install Spotify -s "https://www.myget.org/F/win10"
    ```

## Short Links
  * [Install BoxStarter.](http://bit.ly/win10boxstarter)
  * [Install Chocolatey.](http://bit.ly/win10boxstarter-choco)
  * [SQL Server Configuration.](http://bit.ly/win10boxstarter-sqlserverconfig)
  * [Visual Studio AdminFile.](http://bit.ly/win10boxstarter-vsadmin)
  * [Visual Studio BuildOnSave Add-In.](http://bit.ly/win10boxstarert-vs-buildonsave)
  * [Visual Studio SaveAllTheTime Add-In.](http://bit.ly/win10boxstarert-vs-saveallthetime)
  * [Visual Studio SpellChecker Add-In.](http://bit.ly/win10boxstarter-vs-spellchecker)

## References
  * [Running Visual Studio Install from the Command Line.](https://msdn.microsoft.com/en-us/library/mt720584.aspx)
  * [Visual Studio Package on Chocolatey.](https://chocolatey.org/packages/VisualStudio2015Enterprise)

## Gotchas
  * BOXSTARTER USES OLDER VERSION OF CHOCOLATEY. Big gotcha!

## Editor
https://jbt.github.io/markdown-editor