## Windows 10 Dev PC BoxStarter

1. With Custom Visual Studio AdminFile.xml
2. With Custom SQL Server Configuration.ini

## To Run as Is
  * Full Install, in CMD run
  ```start http://bit.ly/win10boxstarter```
  * Chocolatey Only, in PowerShell run
  ```iex ((New-Object System.Net.WebClient).DownloadString('http://bit.ly/win10boxstarter-choco'))```

## ToDo 
   * Create NuGet package for SQL Server and make BoxStarter use it
   * Create PowerShell script with registery changes
   * Create a way to do silent install on other software without chocolatey package
   * Restore settings for various application (WebStorm, DataGrip)
  
## Short Links
* Install BoxStarter. http://bit.ly/win10boxstarter
* Install Chocolatey. http://bit.ly/win10boxstarter-choco
* SQL Server Configuration. http://bit.ly/win10boxstarter-sqlserverconfig
* Visual Studio AdminFile. http://bit.ly/win10boxstarter-vsadmin
* Visual Studio BuildOnSave Add-In. http://bit.ly/win10boxstarert-vs-buildonsave
* Visual Studio SaveAllTheTime Add-In. http://bit.ly/win10boxstarert-vs-saveallthetime
* Visual Studio SpellChecker Add-In. http://bit.ly/win10boxstarter-vs-spellchecker

## References
* Running Visual Studio Install from the Command Line  
https://msdn.microsoft.com/en-us/library/mt720584.aspx
* Visual Studio Package on Chocolatey  
https://chocolatey.org/packages/VisualStudio2015Enterprise

## Editor
https://jbt.github.io/markdown-editor
