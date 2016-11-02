## Windows 10 Dev PC BoxStarter
  1. With Custom Visual Studio AdminFile.xml
  2. With Custom SQL Server Configuration.ini

## To Run as Is
  * Full Install, in CMD run

  ```
  start http://bit.ly/win10boxstarter
  ```

  * Chocolatey Only, in PowerShell run
  ```
  Set-ExecutionPolicy Unrestricted
  iex ((New-Object System.Net.WebClient).DownloadString('http://bit.ly/win10boxstarter-choco'))
  ```

## ToDo
  * Create PowerShell script with registery changes
  * Create a way to do silent install of other software without chocolatey package
  * Restore settings for various application (WebStorm, DataGrip)

## Chocolatey Packages
  * Microsoft SQL Server 2014 Express

    Because you need to specify the source of the NuGet package and it's not possible to use GitHub as the source (I tried),
    you have to download the NuGet package first. Here is the script to do that. Create it in save it in C:\Temp.

    ```
    $url = "http://bit.ly/2dsDNp9"
    $packageName = "MSSQLServer2014Express"
    $version = "12.0.4100.20160621"
    $tempDir = $(Get-Item $env:TEMP)
    $output = "$tempDir\$packageName.$version.nupkg"
    Invoke-WebRequest -Uri $url -OutFile $output
    choco install $packageName -y -source "'$tempDir;https://chocolatey.org/api/v2/'" -params='Your Params' (See Below)
    ```

    Install with the default parameters from the Configuration.ini inside the package (Data directory is D:\SQLData)

    ```
    choco install MSSQLServer2014Express -s $PSScriptRoot
    ```

    Install with overriding some parameters. Replace -params='Your Params' above.

    ```
    -params='/SAPWD="SetYourOwn" /InstallSQLDataDir="C:\SQLData" /SQLBACKUPDIR="C:\SQLData\Backup" /SQLUSERDBDIR="C:\SQLData" /SQLTEMPDBDIR="C:\SQLData"'
    ```

    Install with overriding some parameters and your own Configuraiton.ini (by specifing the URL to Configuration.ini). Replace -params='Your Params' above.

    ```
    -params='/SAPWD="SetYourOwn" /InstallSQLDataDir="C:\SQLData" /SQLBACKUPDIR="C:\SQLData\Backup" /SQLUSERDBDIR="C:\SQLData" /SQLTEMPDBDIR="C:\SQLData" /ConfigurationFile="http://bit.ly/2doxBU1"'
    ```

  * Internet Information Service (IIS)
    ```
    $url = "http://bit.ly/2f19w2P"
    $packageName = "WinIIS"
    $tempDir = $(Get-Item $env:TEMP)
    $output = "$tempDir\WinIIS.2016.11.02.nupkg"
    Invoke-WebRequest -Uri $url -OutFile $output
    choco install $packageName -y -source "'$tempDir;https://chocolatey.org/api/v2/'"
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
  * The SQL Server package does not allow for passing some parameters as they are passed as part of the silent install, so the configuration file doesn't work completely.

## Editor
https://jbt.github.io/markdown-editor