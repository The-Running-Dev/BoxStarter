## Chocolatey Packages
  * Packages support custom installer location through a Chocolatey extension
    * The installer can embedded into the package
    * The installer can be in a local or network location (by setting $env:packagesInstallers)
    * The installer can be downloaded from the internet (like most packages on the Community feed)
    * The installer can be inside a zip file (local or downloaded from the internet)
    * The installer can be inside an ISO image
  * Most packages support automatic updates through the AU module, with the provided ```update.ps1``` script
  * AutoHotkey is used whenever full silent installation is not possible (Example ESET Nod32 Antivirus)

## Sample Install Script
  ```
  # Execute https://raw.githubusercontent.com/The-Running-Dev/Chocolatey-BoxStarter/master/Install/install.sample.ps1
  iwr http://bit.ly/2pj2nQb -UseBasicParsing | iex
  ```

## Packages
 $packages

## Links
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