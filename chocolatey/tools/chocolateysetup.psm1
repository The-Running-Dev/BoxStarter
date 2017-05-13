$thisScriptFolder = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$chocInstallVariableName = "ChocolateyInstall"
$sysDrive = $env:SystemDrive
$tempDir = $env:TEMP
$defaultChocolateyPathOld = "$sysDrive\Chocolatey"

$originalForegroundColor = $host.ui.RawUI.ForegroundColor

function Write-ChocolateyWarning {
param (
  [string]$message = ''
)

  try {
    Write-Host "WARNING: $message" -ForegroundColor "Yellow" -ErrorAction "Stop"
  } catch {
    Write-Output "WARNING: $message"
  }
}

function  Write-ChocolateyError {
param (
  [string]$message = ''
)

  try {
    Write-Host "ERROR: $message" -ForegroundColor "Red" -ErrorAction "Stop"
  } catch {
    Write-Output "ERROR: $message"
  }
}

function Initialize-Chocolatey {
<#
  .DESCRIPTION
    This will initialize the Chocolatey tool by
      a) setting up the "chocolateyPath" (the location where all chocolatey nuget packages will be installed)
      b) Installs chocolatey into the "chocolateyPath"
            c) Instals .net 4.0 if needed
      d) Adds Chocolatey to the PATH environment variable so you have access to the choco commands.
  .PARAMETER  ChocolateyPath
    Allows you to override the default path of (C:\ProgramData\chocolatey\) by specifying a directory chocolatey will install nuget packages.

  .EXAMPLE
    C:\PS> Initialize-Chocolatey

    Installs chocolatey into the default C:\ProgramData\Chocolatey\ directory.

  .EXAMPLE
    C:\PS> Initialize-Chocolatey -chocolateyPath "D:\ChocolateyInstalledNuGets\"

    Installs chocolatey into the custom directory D:\ChocolateyInstalledNuGets\

#>
param(
  [Parameter(Mandatory=$false)][string]$chocolateyPath = ''
)
  Write-Debug "Initialize-Chocolatey"

  $installModule = Join-Path $thisScriptFolder 'chocolateyInstall\helpers\chocolateyInstaller.psm1'
  Import-Module $installModule -Force

  if ($chocolateyPath -eq '') {
    $programData = [Environment]::GetFolderPath("CommonApplicationData")
    $chocolateyPath = Join-Path "$programData" 'chocolatey'
  }

  # variable to allow insecure directory:
  $allowInsecureRootInstall = $false
  if ($env:ChocolateyAllowInsecureRootDirectory -eq 'true') { $allowInsecureRootInstall = $true }

  # if we have an already environment variable path, use it.
  $alreadyInitializedNugetPath = Get-ChocolateyInstallFolder
  if ($alreadyInitializedNugetPath -and $alreadyInitializedNugetPath -ne $chocolateyPath -and ($allowInsecureRootInstall -or $alreadyInitializedNugetPath -ne $defaultChocolateyPathOld)){
    $chocolateyPath = $alreadyInitializedNugetPath
  }
  else {
    Set-ChocolateyInstallFolder $chocolateyPath
  }
  Create-DirectoryIfNotExists $chocolateyPath
  Ensure-Permissions $chocolateyPath

  #set up variables to add
  $chocolateyExePath = Join-Path $chocolateyPath 'bin'
  $chocolateyLibPath = Join-Path $chocolateyPath 'lib'

  if ($tempDir -eq $null) {
    $tempDir = Join-Path $chocolateyPath 'temp'
    Create-DirectoryIfNotExists $tempDir
  }

  $yourPkgPath = [System.IO.Path]::Combine($chocolateyLibPath,"yourPackageName")
@"
We are setting up the Chocolatey package repository.
The packages themselves go to `'$chocolateyLibPath`'
  (i.e. $yourPkgPath).
A shim file for the command line goes to `'$chocolateyExePath`'
  and points to an executable in `'$yourPkgPath`'.

Creating Chocolatey folders if they do not already exist.

"@ | Write-Output

  Write-ChocolateyWarning "You can safely ignore errors related to missing log files when `n  upgrading from a version of Chocolatey less than 0.9.9. `n  'Batch file could not be found' is also safe to ignore. `n  'The system cannot find the file specified' - also safe."

  #create the base structure if it doesn't exist
  Create-DirectoryIfNotExists $chocolateyExePath
  Create-DirectoryIfNotExists $chocolateyLibPath

  Install-ChocolateyFiles $chocolateyPath
  Ensure-ChocolateyLibFiles $chocolateyLibPath

  Install-ChocolateyBinFiles $chocolateyPath $chocolateyExePath

  $chocolateyExePathVariable = $chocolateyExePath.ToLower().Replace($chocolateyPath.ToLower(), "%DIR%..\").Replace("\\","\")
  Initialize-ChocolateyPath $chocolateyExePath $chocolateyExePathVariable
  Process-ChocolateyBinFiles $chocolateyExePath $chocolateyExePathVariable

  $realModule = Join-Path $chocolateyPath "helpers\chocolateyInstaller.psm1"
  Import-Module "$realModule" -Force

  if (-not $allowInsecureRootInstall -and (Test-Path($defaultChocolateyPathOld))) {
    Upgrade-OldChocolateyInstall $defaultChocolateyPathOld $chocolateyPath
    Install-ChocolateyBinFiles $chocolateyPath $chocolateyExePath
  }

  Add-ChocolateyProfile
  Install-DotNet4IfMissing
  if ($env:ChocolateyExitCode -eq $null -or $env:ChocolateyExitCode -eq '') {
    $env:ChocolateyExitCode = 0
  }

@"
Chocolatey (choco.exe) is now ready.
You can call choco from anywhere, command line or powershell by typing choco.
Run choco /? for a list of functions.
You may need to shut down and restart powershell and/or consoles
 first prior to using choco.
"@ | write-Output

  if (-not $allowInsecureRootInstall) {
    Remove-OldChocolateyInstall $defaultChocolateyPathOld
  }
}

function Set-ChocolateyInstallFolder {
param(
  [string]$folder
)
  Write-Debug "Set-ChocolateyInstallFolder"

  $environmentTarget = [System.EnvironmentVariableTarget]::User
  # removing old variable
  Install-ChocolateyEnvironmentVariable -variableName "$chocInstallVariableName" -variableValue $null -variableType $environmentTarget
  if (Test-ProcessAdminRights) {
    Write-Debug "Administrator installing so using Machine environment variable target instead of User."
    $environmentTarget = [System.EnvironmentVariableTarget]::Machine
    # removing old variable
    Install-ChocolateyEnvironmentVariable -variableName "$chocInstallVariableName" -variableValue $null -variableType $environmentTarget
  } else {
    Write-ChocolateyWarning "Setting ChocolateyInstall Environment Variable on USER and not SYSTEM variables.`n  This is due to either non-administrator install OR the process you are running is not being run as an Administrator."
  }

  Write-Output "Creating $chocInstallVariableName as an environment variable (targeting `'$environmentTarget`') `n  Setting $chocInstallVariableName to `'$folder`'"
  Write-ChocolateyWarning "It's very likely you will need to close and reopen your shell `n  before you can use choco."
  Install-ChocolateyEnvironmentVariable -variableName "$chocInstallVariableName" -variableValue "$folder" -variableType $environmentTarget
}

function Get-ChocolateyInstallFolder(){
  Write-Debug "Get-ChocolateyInstallFolder"
  [Environment]::GetEnvironmentVariable($chocInstallVariableName)
}

function Create-DirectoryIfNotExists($folderName){
  Write-Debug "Create-DirectoryIfNotExists"
  if (![System.IO.Directory]::Exists($folderName)) { [System.IO.Directory]::CreateDirectory($folderName) | Out-Null }
}

function Get-LocalizedWellKnownPrincipalName {
param (
  [Parameter(Mandatory = $true)]
  [Security.Principal.WellKnownSidType] $WellKnownSidType
)
  $sid = New-Object -TypeName 'System.Security.Principal.SecurityIdentifier' -ArgumentList @($WellKnownSidType, $null)
  $account = $sid.Translate([Security.Principal.NTAccount])

  return $account.Value
}

function Ensure-Permissions {
param(
  [string]$folder
)
  Write-Debug "Ensure-Permissions"

  $defaultInstallPath = "$env:SystemDrive\ProgramData\chocolatey"
  try {
    $defaultInstallPath = Join-Path ([Environment]::GetFolderPath("CommonApplicationData")) 'chocolatey'
  } catch {
      # keep first setting
  }

  if ($folder.ToLower() -ne $defaultInstallPath.ToLower()) {
    Write-ChocolateyWarning "Installation folder is not the default. Not changing permissions. Please ensure your installation is secure."
    return
  }

  # Everything from here on out applies to the default installation folder

  if (!(Test-ProcessAdminRights)) {
    throw "Installation of Chocolatey to default folder requires Administrative permissions. Please run from elevated prompt. Please see https://chocolatey.org/install for details and alternatives if needing to install as a non-administrator."
  }

  $currentEA = $ErrorActionPreference
  $ErrorActionPreference = 'Stop'
  try {
    # get current acl
    $acl = (Get-Item $folder).GetAccessControl('Access,Owner')

    Write-Debug "Removing existing permissions."
    $acl.Access | % { $acl.RemoveAccessRuleAll($_) }

    $inheritanceFlags = ([Security.AccessControl.InheritanceFlags]::ContainerInherit -bor [Security.AccessControl.InheritanceFlags]::ObjectInherit)
    $propagationFlags = [Security.AccessControl.PropagationFlags]::None

    $rightsFullControl = [Security.AccessControl.FileSystemRights]::FullControl
    $rightsModify = [Security.AccessControl.FileSystemRights]::Modify
    $rightsReadExecute = [Security.AccessControl.FileSystemRights]::ReadAndExecute
    $rightsWrite = [Security.AccessControl.FileSystemRights]::Write

    Write-Output "Restricting write permissions to Administrators"
    $builtinAdmins = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid)
    $adminsAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($builtinAdmins, $rightsFullControl, $inheritanceFlags, $propagationFlags, "Allow")
    $acl.SetAccessRule($adminsAccessRule)
    $localSystem = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::LocalSystemSid)
    $localSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($localSystem, $rightsFullControl, $inheritanceFlags, $propagationFlags, "Allow")
    $acl.SetAccessRule($localSystemAccessRule)
    $builtinUsers = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::BuiltinUsersSid)
    $usersAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($builtinUsers, $rightsReadExecute, $inheritanceFlags, $propagationFlags, "Allow")
    $acl.SetAccessRule($usersAccessRule)

    $allowCurrentUser = $env:ChocolateyInstallAllowCurrentUser -eq 'true'
    if ($allowCurrentUser) {
      # get current user
      $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()

      if ($currentUser.Name -ne $localSystem) {
        $userAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($currentUser.Name, $rightsModify, $inheritanceFlags, $propagationFlags, "Allow")
        Write-ChocolateyWarning 'Adding Modify permission for current user due to $env:ChocolateyInstallAllowCurrentUser. This could lead to escalation of privilege attacks. Consider not allowing this.'
        $acl.SetAccessRule($userAccessRule)
      }
    } else {
      Write-Debug 'Current user no longer set due to possible escalation of privileges - set $env:ChocolateyInstallAllowCurrentUser="true" if you require this.'
    }

    Write-Debug "Set Owner to Administrators"
    $builtinAdminsSid = New-Object System.Security.Principal.SecurityIdentifier([Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid, $null)
    $acl.SetOwner($builtinAdminsSid)

    Write-Debug "Default Installation folder - removing inheritance with no copy"
    $acl.SetAccessRuleProtection($true, $false)

    # enact the changes against the actual
    (Get-Item $folder).SetAccessControl($acl)

    # set an explicit append permission on the logs folder
    Write-Debug "Allow users to append to log files."
    $logsFolder = "$folder\logs"
    Create-DirectoryIfNotExists $logsFolder
    $logsAcl = (Get-Item $logsFolder).GetAccessControl('Access')
    $usersAppendAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($builtinUsers, $rightsWrite, [Security.AccessControl.InheritanceFlags]::ObjectInherit, [Security.AccessControl.PropagationFlags]::InheritOnly, "Allow")
    $logsAcl.SetAccessRule($usersAppendAccessRule)
    $logsAcl.SetAccessRuleProtection($false, $true)
    (Get-Item $logsFolder).SetAccessControl($logsAcl)
  } catch {
    Write-ChocolateyWarning "Not able to set permissions for $folder."
  }
  $ErrorActionPreference = $currentEA
}

function Upgrade-OldChocolateyInstall {
param(
  [string]$chocolateyPathOld = "$sysDrive\Chocolatey",
  [string]$chocolateyPath =  "$($env:ALLUSERSPROFILE)\chocolatey"
)

  Write-Debug "Upgrade-OldChocolateyInstall"

  if (Test-Path $chocolateyPathOld) {
    Write-Output "Attempting to upgrade `'$chocolateyPathOld`' to `'$chocolateyPath`'."
    Write-ChocolateyWarning "Copying the contents of `'$chocolateyPathOld`' to `'$chocolateyPath`'. `n This step may fail if you have anything in this folder running or locked."
    Write-Output 'If it fails, just manually copy the rest of the items out and then delete the folder.'
    Write-ChocolateyWarning "!!!! ATTN: YOU WILL NEED TO CLOSE AND REOPEN YOUR SHELL !!!!"
    #-ForegroundColor Magenta -BackgroundColor Black

    $chocolateyExePathOld = Join-Path $chocolateyPathOld 'bin'
    'Machine', 'User' |
    % {
      $path = Get-EnvironmentVariable -Name 'PATH' -Scope $_
      $updatedPath = [System.Text.RegularExpressions.Regex]::Replace($path,[System.Text.RegularExpressions.Regex]::Escape($chocolateyExePathOld) + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
      if ($updatedPath -ne $path) {
        Write-Output "Updating `'$_`' PATH to reflect removal of '$chocolateyPathOld'."
        try {
          Set-EnvironmentVariable -Name 'Path' -Value $updatedPath -Scope $_ -ErrorAction Stop
        } catch {
          Write-ChocolateyWarning "Was not able to remove the old environment variable from PATH. You will need to do this manually"
        }

      }
    }

    Copy-Item "$chocolateyPathOld\lib\*" "$chocolateyPath\lib" -force -recurse

    $from = "$chocolateyPathOld\bin"
    $to = "$chocolateyPath\bin"
    $exclude = @("choco.exe", "chocolatey.exe", "cinst.exe", "clist.exe", "cpack.exe", "cpush.exe", "cuninst.exe", "cup.exe", "cver.exe", "RefreshEnv.cmd")
    Get-ChildItem -Path $from -recurse -Exclude $exclude |
      % {
        Write-Debug "Copying $_ `n to $to"
        if ($_.PSIsContainer) {
          Copy-Item $_ -Destination (Join-Path $to $_.Parent.FullName.Substring($from.length)) -Force -ErrorAction SilentlyContinue
        } else {
          $fileToMove = (Join-Path $to $_.FullName.Substring($from.length))
          try {
           Copy-Item $_ -Destination $fileToMove -Exclude $exclude -Force -ErrorAction Stop
          }
          catch {
            Write-ChocolateyWarning "Was not able to move `'$fileToMove`'. You may need to reinstall the shim"
          }
        }
      }
  }
}

function Remove-OldChocolateyInstall {
param(
  [string]$chocolateyPathOld = "$sysDrive\Chocolatey"
)
  Write-Debug "Remove-OldChocolateyInstall"

  if (Test-Path $chocolateyPathOld) {
    Write-ChocolateyWarning "This action will result in Log Errors, you can safely ignore those. `n You may need to finish removing '$chocolateyPathOld' manually."
    try {
      Get-ChildItem -Path "$chocolateyPathOld" | % {
        if (Test-Path $_.FullName) {
          Write-Debug "Removing $_ unless matches .log"
          Remove-Item $_.FullName -exclude *.log -recurse -force -ErrorAction SilentlyContinue
        }
      }

      Write-Output "Attempting to remove `'$chocolateyPathOld`'. This may fail if something in the folder is being used or locked."
      Remove-Item "$($chocolateyPathOld)" -force -recurse -ErrorAction Stop
    }
    catch {
      Write-ChocolateyWarning "Was not able to remove `'$chocolateyPathOld`'. You will need to manually remove it."
    }
  }
}

function Install-ChocolateyFiles {
param(
  [string]$chocolateyPath
)
  Write-Debug "Install-ChocolateyFiles"

  Write-Debug "Removing install files in chocolateyInstall, helpers, redirects, and tools"
  "$chocolateyPath\chocolateyInstall", "$chocolateyPath\helpers", "$chocolateyPath\redirects", "$chocolateyPath\tools" | % {
    #Write-Debug "Checking path $_"

    if (Test-Path $_) {
      Get-ChildItem -Path "$_" | % {
        #Write-Debug "Checking child path $_ ($($_.FullName))"
        if (Test-Path $_.FullName) {
          Write-Debug "Removing $_ unless matches .log"
          Remove-Item $_.FullName -exclude *.log -recurse -force -ErrorAction SilentlyContinue
        }
      }
    }
  }

  Write-Debug "Attempting to move choco.exe to choco.exe.old so we can place the new version here."
  # rename the currently running process / it will be locked if it exists
  $chocoExe = Join-Path $chocolateyPath 'choco.exe'
  if (Test-Path ($chocoExe)) {
    Write-Debug "Renaming '$chocoExe' to '$chocoExe.old'"
    try {
      Remove-Item "$chocoExe.old" -force -ErrorAction SilentlyContinue
      Move-Item $chocoExe "$chocoExe.old" -force -ErrorAction SilentlyContinue
    }
    catch {
      Write-ChocolateyWarning "Was not able to rename `'$chocoExe`' to `'$chocoExe.old`'."
    }
  }

  Write-Debug "Unpacking files required for Chocolatey."
  $chocInstallFolder = Join-Path $thisScriptFolder "chocolateyInstall"
  $chocoExe = Join-Path $chocInstallFolder 'choco.exe'
  $chocoExeDest = Join-Path $chocolateyPath 'choco.exe'
  Copy-Item $chocoExe $chocoExeDest -force

  Write-Debug "Copying the contents of `'$chocInstallFolder`' to `'$chocolateyPath`'."
  Copy-Item $chocInstallFolder\* $chocolateyPath -recurse -force
}

function Ensure-ChocolateyLibFiles {
param(
  [string]$chocolateyLibPath
)
  Write-Debug "Ensure-ChocolateyLibFiles"
  $chocoPkgDirectory = Join-Path $chocolateyLibPath 'chocolatey'

  Create-DirectoryIfNotExists $chocoPkgDirectory

  if (!(Test-Path("$chocoPkgDirectory\chocolatey.nupkg"))) {
    Write-Output "chocolatey.nupkg file not installed in lib.`n Attempting to locate it from bootstrapper."
    $chocoZipFile = Join-Path $tempDir "chocolatey\chocInstall\chocolatey.zip"

    Write-Debug "First the zip file at '$chocoZipFile'."
    Write-Debug "Then from a neighboring chocolatey.*nupkg file '$thisScriptFolder/../../'."

    if (Test-Path("$chocoZipFile")) {
      Write-Debug "Copying '$chocoZipFile' to '$chocoPkgDirectory\chocolatey.nupkg'."
      Copy-Item "$chocoZipFile" "$chocoPkgDirectory\chocolatey.nupkg" -Force -ErrorAction SilentlyContinue
    }

    if (!(Test-Path("$chocoPkgDirectory\chocolatey.nupkg"))) {
      $chocoPkg = Get-ChildItem "$thisScriptFolder/../../" | ?{$_.name -match "^chocolatey.*nupkg" } | Sort name -Descending | Select -First 1
      if ($chocoPkg -ne '') { $chocoPkg = $chocoPkg.FullName }
      "$chocoZipFile", "$chocoPkg" | % {
        if ($_ -ne $null -and $_ -ne '') {
          if (Test-Path $_) {
            Write-Debug "Copying '$_' to '$chocoPkgDirectory\chocolatey.nupkg'."
            Copy-Item $_ "$chocoPkgDirectory\chocolatey.nupkg" -Force -ErrorAction SilentlyContinue
          }
        }
      }
    }
  }
}

function Install-ChocolateyBinFiles {
param(
  [string] $chocolateyPath,
  [string] $chocolateyExePath
)
  Write-Debug "Install-ChocolateyBinFiles"
  Write-Debug "Installing the bin file redirects"
  $redirectsPath = Join-Path $chocolateyPath 'redirects'
  if (!(Test-Path "$redirectsPath")) {
    Write-ChocolateyWarning "$redirectsPath does not exist"
    return
  }

  $exeFiles = Get-ChildItem "$redirectsPath" -include @("*.exe","*.cmd") -recurse
  foreach ($exeFile in $exeFiles) {
    $exeFilePath = $exeFile.FullName
    $exeFileName = [System.IO.Path]::GetFileName("$exeFilePath")
    $binFilePath = Join-Path $chocolateyExePath $exeFileName
    $binFilePathRename = $binFilePath + '.old'
    $batchFilePath = $binFilePath.Replace(".exe",".bat")
    $bashFilePath = $binFilePath.Replace(".exe","")
    if (Test-Path ($batchFilePath)) { Remove-Item $batchFilePath -force -ErrorAction SilentlyContinue }
    if (Test-Path ($bashFilePath)) { Remove-Item $bashFilePath -force -ErrorAction SilentlyContinue }
    if (Test-Path ($binFilePathRename)) {
      try {
        Write-Debug "Attempting to remove $binFilePathRename"
        Remove-Item $binFilePathRename -force -ErrorAction Stop
      }
      catch {
        Write-ChocolateyWarning "Was not able to remove `'$binFilePathRename`'. This may cause errors."
      }
    }
    if (Test-Path ($binFilePath)) {
     try {
        Write-Debug "Attempting to rename $binFilePath to $binFilePathRename"
        Move-Item -path $binFilePath -destination $binFilePathRename -force -ErrorAction Stop
      }
      catch {
        Write-ChocolateyWarning "Was not able to rename `'$binFilePath`' to `'$binFilePathRename`'."
      }
    }

    try {
      Write-Debug "Attempting to copy $exeFilePath to $binFilePath"
      Copy-Item -path $exeFilePath -destination $binFilePath -force -ErrorAction Stop
    }
    catch {
      Write-ChocolateyWarning "Was not able to replace `'$binFilePath`' with `'$exeFilePath`'. You may need to do this manually."
    }

    $commandShortcut = [System.IO.Path]::GetFileNameWithoutExtension("$exeFilePath")
    Write-Debug "Added command $commandShortcut"
  }
}

function Initialize-ChocolateyPath {
param(
  [string]$chocolateyExePath = "$($env:ALLUSERSPROFILE)\chocolatey\bin",
  [string]$chocolateyExePathVariable = "%$($chocInstallVariableName)%\bin"
)
  Write-Debug "Initialize-ChocolateyPath"
  Write-Debug "Initializing Chocolatey Path if required"
  $environmentTarget = [System.EnvironmentVariableTarget]::User
  if (Test-ProcessAdminRights) {
    Write-Debug "Administrator installing so using Machine environment variable target instead of User."
    $environmentTarget = [System.EnvironmentVariableTarget]::Machine
  } else {
    Write-ChocolateyWarning "Setting ChocolateyInstall Path on USER PATH and not SYSTEM Path.`n  This is due to either non-administrator install OR the process you are running is not being run as an Administrator."
  }

  Install-ChocolateyPath -pathToInstall "$chocolateyExePath" -pathType $environmentTarget
}

function Process-ChocolateyBinFiles {
param(
  [string]$chocolateyExePath = "$($env:ALLUSERSPROFILE)\chocolatey\bin",
  [string]$chocolateyExePathVariable = "%$($chocInstallVariableName)%\bin"
)
  Write-Debug "Process-ChocolateyBinFiles"
  $processedMarkerFile = Join-Path $chocolateyExePath '_processed.txt'
  if (!(test-path $processedMarkerFile)) {
    $files = get-childitem $chocolateyExePath -include *.bat -recurse
    if ($files -ne $null -and $files.Count -gt 0) {
      Write-Debug "Processing Bin files"
      foreach ($file in $files) {
        Write-Output "Processing $($file.Name) to make it portable"
        $fileStream = [System.IO.File]::Open("$file", 'Open', 'Read', 'ReadWrite')
        $reader = New-Object System.IO.StreamReader($fileStream)
        $fileText = $reader.ReadToEnd()
        $reader.Close()
        $fileStream.Close()

        $fileText = $fileText.ToLower().Replace("`"" + $chocolateyPath.ToLower(), "SET DIR=%~dp0%`n""%DIR%..\").Replace("\\","\")

        Set-Content $file -Value $fileText -Encoding Ascii
      }
    }

    Set-Content $processedMarkerFile -Value "$([System.DateTime]::Now.Date)" -Encoding Ascii
  }
}

# Adapted from http://www.west-wind.com/Weblog/posts/197245.aspx
function Get-FileEncoding($Path) {
    $bytes = [byte[]](Get-Content $Path -Encoding byte -ReadCount 4 -TotalCount 4)

    if(!$bytes) { return 'utf8' }

    switch -regex ('{0:x2}{1:x2}{2:x2}{3:x2}' -f $bytes[0],$bytes[1],$bytes[2],$bytes[3]) {
        '^efbbbf'   { return 'utf8' }
        '^2b2f76'   { return 'utf7' }
        '^fffe'     { return 'unicode' }
        '^feff'     { return 'bigendianunicode' }
        '^0000feff' { return 'utf32' }
        default     { return 'ascii' }
    }
}

function Add-ChocolateyProfile {
  Write-Debug "Add-ChocolateyProfile"
  try {
    $profileFile = "$profile"
    if ($profileFile -eq $null -or $profileFile -eq '') {
      Write-Output 'Not setting tab completion: Profile variable ($profile) resulted in an empty string.'
      return
    }

    $profileDirectory = (Split-Path -Parent $profileFile)

    if ($env:ChocolateyNoProfile -ne $null -and $env:ChocolateyNoProfile -ne '') {
      Write-Warning "Not setting tab completion: Environment variable "ChocolateyNoProfile" exists and is set."
      return
    }

    $localSystem = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::LocalSystemSid)
    # get current user
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    if ($currentUser.Name -eq $localSystem) {
      Write-Warning "Not setting tab completion: Current user is SYSTEM user."
      return
    }

    if (!(Test-Path($profileDirectory))) {
      Write-Debug "Creating '$profileDirectory'"
      New-Item "$profileDirectory" -Type Directory -Force -ErrorAction SilentlyContinue | Out-Null
    }

    if (!(Test-Path($profileFile))) {
      Write-Warning "Not setting tab completion: Profile file does not exist at '$profileFile'."
      return

      #Write-Debug "Creating '$profileFile'"
      #"" | Out-File $profileFile -Encoding UTF8
    }

    $signature = Get-AuthenticodeSignature $profile
    if ($signature.Status -ne 'NotSigned') {
      Write-Warning "Not setting tab completion: File is Authenticode signed at '$profile'."
      return
    }

    $profileInstall = @'

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
'@

    $chocoProfileSearch = '$ChocolateyProfile'
    if(Select-String -Path $profileFile -Pattern $chocoProfileSearch -Quiet -SimpleMatch) {
      Write-Debug "Chocolatey profile is already installed."
      return
    }

    Write-Output 'Adding Chocolatey to the profile. This will provide tab completion, refreshenv, etc.'
    $profileInstall | Out-File $profileFile -Append -Encoding (Get-FileEncoding $profileFile)
    Write-ChocolateyWarning 'Chocolatey profile installed. Reload your profile - type . $profile'

    if ($PSVersionTable.PSVersion.Major -lt 3) {
      Write-ChocolateyWarning "Tab completion does not currently work in PowerShell v2. `n Please upgrade to a more recent version of PowerShell to take advantage of tab completion."
      #Write-ChocolateyWarning "To load tab expansion, you need to install PowerTab. `n See https://powertab.codeplex.com/ for details."
    }

  } catch {
    Write-ChocolateyWarning "Unable to add Chocolatey to the profile. You will need to do it manually. Error was '$_'"
@'
This is how add the Chocolatey Profile manually.
Find your $profile. Then add the following lines to it:

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
'@ | Write-Output
  }
}

$netFx4InstallTries = 0

function Install-DotNet4IfMissing {
param(
  $forceFxInstall = $false
)
  # we can't take advantage of any chocolatey module functions, because they
  # haven't been unpacked because they require .NET Framework 4.0

  Write-Debug "Install-DotNet4IfMissing called with `$forceFxInstall=$forceFxInstall"
  $NetFxArch = "Framework"
  if ([IntPtr]::Size -eq 8) {$NetFxArch="Framework64" }

  $NetFx4ClientUrl = 'https://download.microsoft.com/download/5/6/2/562A10F9-C9F4-4313-A044-9C94E0A8FAC8/dotNetFx40_Client_x86_x64.exe'
  $NetFx4FullUrl = 'https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe'
  $NetFx4Url = $NetFx4FullUrl
  $NetFx4Path = "$tempDir"
  $NetFx4InstallerFile = 'dotNetFx40_Full_x86_x64.exe'
  $NetFx4Installer = Join-Path $NetFx4Path $NetFx4InstallerFile

  if ((!(Test-Path "$env:SystemRoot\Microsoft.Net\$NetFxArch\v4.0.30319") -and !(Test-Path "C:\Windows\Microsoft.Net\$NetFxArch\v4.0.30319")) -or $forceFxInstall) {
    Write-Output "'$env:SystemRoot\Microsoft.Net\$NetFxArch\v4.0.30319' was not found or this is forced"
    if (!(Test-Path $NetFx4Path)) {
      Write-Output "Creating folder `'$NetFx4Path`'"
      $null = New-Item -Path "$NetFx4Path" -ItemType Directory
    }

    $netFx4InstallTries += 1

    if (!(Test-Path $NetFx4Installer)) {
      Write-Output "Downloading `'$NetFx4Url`' to `'$NetFx4Installer`' - the installer is 40+ MBs, so this could take a while on a slow connection."
      (New-Object Net.WebClient).DownloadFile("$NetFx4Url","$NetFx4Installer")
    }

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.WorkingDirectory = "$NetFx4Path"
    $psi.FileName = "$NetFx4InstallerFile"
    # https://msdn.microsoft.com/library/ee942965(v=VS.100).aspx#command_line_options
    # http://blogs.msdn.com/b/astebner/archive/2010/05/12/10011664.aspx
    # For the actual setup.exe (if you want to unpack first) - /repair /x86 /x64 /ia64 /parameterfolder Client /q /norestart
    $psi.Arguments = "/q /norestart /repair"

    Write-Output "Installing `'$NetFx4Installer`' - this may take awhile with no output."
    $s = [System.Diagnostics.Process]::Start($psi);
    $s.WaitForExit();
    if ($s.ExitCode -ne 0 -and $s.ExitCode -ne 3010) {
      if ($netFx4InstallTries -ge 2) {
        Write-ChocolateyError ".NET Framework install failed with exit code `'$($s.ExitCode)`'. `n This will cause the rest of the install to fail."
        throw "Error installing .NET Framework 4.0 (exit code $($s.ExitCode)). `n Please install the .NET Framework 4.0 manually and then try to install Chocolatey again. `n Download at `'$NetFx4Url`'"
      } else {
        Write-ChocolateyWarning "Try #$netFx4InstallTries of .NET framework install failed with exit code `'$($s.ExitCode)`'. Trying again."
        Install-DotNet4IfMissing $true
      }
    }
  }
}

Export-ModuleMember -function Initialize-Chocolatey;

# SIG # Begin signature block
# MIIcpwYJKoZIhvcNAQcCoIIcmDCCHJQCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCIKJuMeqFtIfL3
# y/zsubyO1BiiYmafEQbVzVkN9b+8N6CCF7EwggUwMIIEGKADAgECAhAECRgbX9W7
# ZnVTQ7VvlVAIMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNV
# BAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0xMzEwMjIxMjAwMDBa
# Fw0yODEwMjIxMjAwMDBaMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
# dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lD
# ZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQD407Mcfw4Rr2d3B9MLMUkZz9D7RZmxOttE9X/l
# qJ3bMtdx6nadBS63j/qSQ8Cl+YnUNxnXtqrwnIal2CWsDnkoOn7p0WfTxvspJ8fT
# eyOU5JEjlpB3gvmhhCNmElQzUHSxKCa7JGnCwlLyFGeKiUXULaGj6YgsIJWuHEqH
# CN8M9eJNYBi+qsSyrnAxZjNxPqxwoqvOf+l8y5Kh5TsxHM/q8grkV7tKtel05iv+
# bMt+dDk2DZDv5LVOpKnqagqrhPOsZ061xPeM0SAlI+sIZD5SlsHyDxL0xY4PwaLo
# LFH3c7y9hbFig3NBggfkOItqcyDQD2RzPJ6fpjOp/RnfJZPRAgMBAAGjggHNMIIB
# yTASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAK
# BggrBgEFBQcDAzB5BggrBgEFBQcBAQRtMGswJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
# Y3NwLmRpZ2ljZXJ0LmNvbTBDBggrBgEFBQcwAoY3aHR0cDovL2NhY2VydHMuZGln
# aWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNydDCBgQYDVR0fBHow
# eDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJl
# ZElEUm9vdENBLmNybDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0Rp
# Z2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDBPBgNVHSAESDBGMDgGCmCGSAGG/WwA
# AgQwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAK
# BghghkgBhv1sAzAdBgNVHQ4EFgQUWsS5eyoKo6XqcQPAYPkt9mV1DlgwHwYDVR0j
# BBgwFoAUReuir/SSy4IxLVGLp6chnfNtyA8wDQYJKoZIhvcNAQELBQADggEBAD7s
# DVoks/Mi0RXILHwlKXaoHV0cLToaxO8wYdd+C2D9wz0PxK+L/e8q3yBVN7Dh9tGS
# dQ9RtG6ljlriXiSBThCk7j9xjmMOE0ut119EefM2FAaK95xGTlz/kLEbBw6RFfu6
# r7VRwo0kriTGxycqoSkoGjpxKAI8LpGjwCUR4pwUR6F6aGivm6dcIFzZcbEMj7uo
# +MUSaJ/PQMtARKUT8OZkDCUIQjKyNookAv4vcn4c10lFluhZHen6dGRrsutmQ9qz
# sIzV6Q3d9gEgzpkxYz0IGhizgZtPxpMQBvwHgfqL2vmCSfdibqFT+hKUGIUukpHq
# aGxEMrJmoecYpJpkUe8wggU6MIIEIqADAgECAhAGsBFbtfCQ0/DaDmIsYn1YMA0G
# CSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0
# IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcgQ0EwHhcNMTcwMzI4MDAwMDAw
# WhcNMTgwNDAzMTIwMDAwWjB3MQswCQYDVQQGEwJVUzEPMA0GA1UECBMGS2Fuc2Fz
# MQ8wDQYDVQQHEwZUb3Bla2ExIjAgBgNVBAoTGUNob2NvbGF0ZXkgU29mdHdhcmUs
# IEluYy4xIjAgBgNVBAMTGUNob2NvbGF0ZXkgU29mdHdhcmUsIEluYy4wggEiMA0G
# CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLIWIaEiqkPbIMZi6jD6J8F3YIYPxG
# 3Vw2I8AsM5c63WUmV+bYZQGxY5AHHVFphy9mU6spXgAqVpzkcALjo1oArVscUU34
# 8S4mokGbZVvHlO8ny1b1HzfR4ZPHpUL71btSqpcOElYOOL0wUnf5As/39VN+Wxef
# //D5KTDD17AA2DVvIaXMT+utERbo+c+leaPS4fKo/Q0KvpCt0sKr6LItAMNgaqL4
# 9Z+Dg5n1oHjxAz4ZYhJYdHIPZPoqyeLQ8IuYiqCxKS07tkfvkwlgWxksHpliIKqf
# Jpv0YE2vqlZrcx0WYHNhgX3BIhQa21wxn/XAFNCpgrDgI0u0UupZfxAdAgMBAAGj
# ggHFMIIBwTAfBgNVHSMEGDAWgBRaxLl7KgqjpepxA8Bg+S32ZXUOWDAdBgNVHQ4E
# FgQUJqUaP1/S0OF1EG1dxC6UzM6w6T8wDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQM
# MAoGCCsGAQUFBwMDMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jcmwzLmRpZ2lj
# ZXJ0LmNvbS9zaGEyLWFzc3VyZWQtY3MtZzEuY3JsMDWgM6Axhi9odHRwOi8vY3Js
# NC5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDBMBgNVHSAERTBD
# MDcGCWCGSAGG/WwDATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2Vy
# dC5jb20vQ1BTMAgGBmeBDAEEATCBhAYIKwYBBQUHAQEEeDB2MCQGCCsGAQUFBzAB
# hhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wTgYIKwYBBQUHMAKGQmh0dHA6Ly9j
# YWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVkSURDb2RlU2ln
# bmluZ0NBLmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQCLBAE/
# 2x4amEecDEoy9g+WmWMROiB4GnkPqj+IbiwftmwC5/7yL3/592HOFMJr0qOgUt51
# moE8SuuLuOGw63c5+/48LJS4jP2XzbVNByRPIxPWorm4t/OzTJNziTowHQ+wLwwI
# 8U97+8DaHCNL7iLZNEiqbVlpF3j7SMWGgf2BVYADJyxluNzf0ZUO+lXN4gOkM8tl
# VDc7SjZEKvu6ckAaxXf7NPbCXVL/3+LvdmoLbT3vJlfzeXqduO3oieB10ic3ug5T
# XtoYmyEk/P3yR3x/TqUlg1x/xaolBxy5TyMeSLcBlYn42fnQL154bvMGwFiCsHWQ
# wY09I0xpEysOMiy8MIIGajCCBVKgAwIBAgIQAwGaAjr/WLFr1tXq5hfwZjANBgkq
# hkiG9w0BAQUFADBiMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5j
# MRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSEwHwYDVQQDExhEaWdpQ2VydCBB
# c3N1cmVkIElEIENBLTEwHhcNMTQxMDIyMDAwMDAwWhcNMjQxMDIyMDAwMDAwWjBH
# MQswCQYDVQQGEwJVUzERMA8GA1UEChMIRGlnaUNlcnQxJTAjBgNVBAMTHERpZ2lD
# ZXJ0IFRpbWVzdGFtcCBSZXNwb25kZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
# ggEKAoIBAQCjZF38fLPggjXg4PbGKuZJdTvMbuBTqZ8fZFnmfGt/a4ydVfiS457V
# WmNbAklQ2YPOb2bu3cuF6V+l+dSHdIhEOxnJ5fWRn8YUOawk6qhLLJGJzF4o9GS2
# ULf1ErNzlgpno75hn67z/RJ4dQ6mWxT9RSOOhkRVfRiGBYxVh3lIRvfKDo2n3k5f
# 4qi2LVkCYYhhchhoubh87ubnNC8xd4EwH7s2AY3vJ+P3mvBMMWSN4+v6GYeofs/s
# jAw2W3rBerh4x8kGLkYQyI3oBGDbvHN0+k7Y/qpA8bLOcEaD6dpAoVk62RUJV5lW
# MJPzyWHM0AjMa+xiQpGsAsDvpPCJEY93AgMBAAGjggM1MIIDMTAOBgNVHQ8BAf8E
# BAMCB4AwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDCCAb8G
# A1UdIASCAbYwggGyMIIBoQYJYIZIAYb9bAcBMIIBkjAoBggrBgEFBQcCARYcaHR0
# cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzCCAWQGCCsGAQUFBwICMIIBVh6CAVIA
# QQBuAHkAIAB1AHMAZQAgAG8AZgAgAHQAaABpAHMAIABDAGUAcgB0AGkAZgBpAGMA
# YQB0AGUAIABjAG8AbgBzAHQAaQB0AHUAdABlAHMAIABhAGMAYwBlAHAAdABhAG4A
# YwBlACAAbwBmACAAdABoAGUAIABEAGkAZwBpAEMAZQByAHQAIABDAFAALwBDAFAA
# UwAgAGEAbgBkACAAdABoAGUAIABSAGUAbAB5AGkAbgBnACAAUABhAHIAdAB5ACAA
# QQBnAHIAZQBlAG0AZQBuAHQAIAB3AGgAaQBjAGgAIABsAGkAbQBpAHQAIABsAGkA
# YQBiAGkAbABpAHQAeQAgAGEAbgBkACAAYQByAGUAIABpAG4AYwBvAHIAcABvAHIA
# YQB0AGUAZAAgAGgAZQByAGUAaQBuACAAYgB5ACAAcgBlAGYAZQByAGUAbgBjAGUA
# LjALBglghkgBhv1sAxUwHwYDVR0jBBgwFoAUFQASKxOYspkH7R7for5XDStnAs0w
# HQYDVR0OBBYEFGFaTSS2STKdSip5GoNL9B6Jwcp9MH0GA1UdHwR2MHQwOKA2oDSG
# Mmh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRENBLTEu
# Y3JsMDigNqA0hjJodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
# cmVkSURDQS0xLmNybDB3BggrBgEFBQcBAQRrMGkwJAYIKwYBBQUHMAGGGGh0dHA6
# Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBBBggrBgEFBQcwAoY1aHR0cDovL2NhY2VydHMu
# ZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ0EtMS5jcnQwDQYJKoZIhvcN
# AQEFBQADggEBAJ0lfhszTbImgVybhs4jIA+Ah+WI//+x1GosMe06FxlxF82pG7xa
# FjkAneNshORaQPveBgGMN/qbsZ0kfv4gpFetW7easGAm6mlXIV00Lx9xsIOUGQVr
# NZAQoHuXx/Y/5+IRQaa9YtnwJz04HShvOlIJ8OxwYtNiS7Dgc6aSwNOOMdgv420X
# Ewbu5AO2FKvzj0OncZ0h3RTKFV2SQdr5D4HRmXQNJsQOfxu19aDxxncGKBXp2JPl
# VRbwuwqrHNtcSCdmyKOLChzlldquxC5ZoGHd2vNtomHpigtt7BIYvfdVVEADkitr
# wlHCCkivsNRu4PQUCjob4489yq9qjXvc2EQwggbNMIIFtaADAgECAhAG/fkDlgOt
# 6gAK6z8nu7obMA0GCSqGSIb3DQEBBQUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNV
# BAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0wNjExMTAwMDAwMDBa
# Fw0yMTExMTAwMDAwMDBaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
# dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lD
# ZXJ0IEFzc3VyZWQgSUQgQ0EtMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
# ggEBAOiCLZn5ysJClaWAc0Bw0p5WVFypxNJBBo/JM/xNRZFcgZ/tLJz4FlnfnrUk
# FcKYubR3SdyJxArar8tea+2tsHEx6886QAxGTZPsi3o2CAOrDDT+GEmC/sfHMUiA
# fB6iD5IOUMnGh+s2P9gww/+m9/uizW9zI/6sVgWQ8DIhFonGcIj5BZd9o8dD3QLo
# Oz3tsUGj7T++25VIxO4es/K8DCuZ0MZdEkKB4YNugnM/JksUkK5ZZgrEjb7Szgau
# rYRvSISbT0C58Uzyr5j79s5AXVz2qPEvr+yJIvJrGGWxwXOt1/HYzx4KdFxCuGh+
# t9V3CidWfA9ipD8yFGCV/QcEogkCAwEAAaOCA3owggN2MA4GA1UdDwEB/wQEAwIB
# hjA7BgNVHSUENDAyBggrBgEFBQcDAQYIKwYBBQUHAwIGCCsGAQUFBwMDBggrBgEF
# BQcDBAYIKwYBBQUHAwgwggHSBgNVHSAEggHJMIIBxTCCAbQGCmCGSAGG/WwAAQQw
# ggGkMDoGCCsGAQUFBwIBFi5odHRwOi8vd3d3LmRpZ2ljZXJ0LmNvbS9zc2wtY3Bz
# LXJlcG9zaXRvcnkuaHRtMIIBZAYIKwYBBQUHAgIwggFWHoIBUgBBAG4AeQAgAHUA
# cwBlACAAbwBmACAAdABoAGkAcwAgAEMAZQByAHQAaQBmAGkAYwBhAHQAZQAgAGMA
# bwBuAHMAdABpAHQAdQB0AGUAcwAgAGEAYwBjAGUAcAB0AGEAbgBjAGUAIABvAGYA
# IAB0AGgAZQAgAEQAaQBnAGkAQwBlAHIAdAAgAEMAUAAvAEMAUABTACAAYQBuAGQA
# IAB0AGgAZQAgAFIAZQBsAHkAaQBuAGcAIABQAGEAcgB0AHkAIABBAGcAcgBlAGUA
# bQBlAG4AdAAgAHcAaABpAGMAaAAgAGwAaQBtAGkAdAAgAGwAaQBhAGIAaQBsAGkA
# dAB5ACAAYQBuAGQAIABhAHIAZQAgAGkAbgBjAG8AcgBwAG8AcgBhAHQAZQBkACAA
# aABlAHIAZQBpAG4AIABiAHkAIAByAGUAZgBlAHIAZQBuAGMAZQAuMAsGCWCGSAGG
# /WwDFTASBgNVHRMBAf8ECDAGAQH/AgEAMHkGCCsGAQUFBwEBBG0wazAkBggrBgEF
# BQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAChjdodHRw
# Oi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0Eu
# Y3J0MIGBBgNVHR8EejB4MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20v
# RGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMDqgOKA2hjRodHRwOi8vY3JsNC5k
# aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMB0GA1UdDgQW
# BBQVABIrE5iymQftHt+ivlcNK2cCzTAfBgNVHSMEGDAWgBRF66Kv9JLLgjEtUYun
# pyGd823IDzANBgkqhkiG9w0BAQUFAAOCAQEARlA+ybcoJKc4HbZbKa9Sz1LpMUer
# Vlx71Q0LQbPv7HUfdDjyslxhopyVw1Dkgrkj0bo6hnKtOHisdV0XFzRyR4WUVtHr
# uzaEd8wkpfMEGVWp5+Pnq2LN+4stkMLA0rWUvV5PsQXSDj0aqRRbpoYxYqioM+Sb
# OafE9c4deHaUJXPkKqvPnHZL7V/CSxbkS3BMAIke/MV5vEwSV/5f4R68Al2o/vsH
# OE8Nxl2RuQ9nRc3Wg+3nkg2NsWmMT/tZ4CMP0qquAHzunEIOz5HXJ7cW7g/DvXwK
# oO4sCFWFIrjrGBpN/CohrUkxg0eVd3HcsRtLSxwQnHcUwZ1PL1qVCCkQJjGCBEww
# ggRIAgEBMIGGMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMx
# GTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNI
# QTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcgQ0ECEAawEVu18JDT8NoOYixifVgw
# DQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAvBgkqhkiG9w0BCQQxIgQgRuXM0EJMhuuJghV+wWtI4+xyvNkDRZhocOZl
# ru1U+1cwDQYJKoZIhvcNAQEBBQAEggEAj46EVwLKzcST3IQhoV6F9ei0Dds9C84x
# 9MpzFEJwyzNgt/Kgnw3vnwA/DYf9bW1zgbxdCT1A2OZqHPlrDV4o4wcb83W3tgHw
# TkcKPQAXMwqwayjD8s5DVsF323shMDhA7c4TfMGp7CddaIzEbzKt/y35P/Qm6iLH
# rRbGzmywgpjmHjEHK+piIEriZ5AeL5RuQDwI3NEqVeLoR4LRdFFw4c+c1yqnmgWk
# Fu+kMyJ4WubHLHVwDp6PpbGFPFEVV04V4xAGz20ssHyQoQzfabdTYRdu2tzOL9/v
# snZ7BTy+HCLaDbbE4VkhBdQIZUpt9QPIFpJOJqSkJviuvtRH5g2WdqGCAg8wggIL
# BgkqhkiG9w0BCQYxggH8MIIB+AIBATB2MGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IEFzc3VyZWQgSUQgQ0EtMQIQAwGaAjr/WLFr1tXq5hfwZjAJ
# BgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
# CQUxDxcNMTcwMzMwMjIxMjAzWjAjBgkqhkiG9w0BCQQxFgQUao5/Zlv5UjULGaFY
# eWPi80wbKpYwDQYJKoZIhvcNAQEBBQAEggEAUGW9kNIRbOUq8xAhNl7dyhuyIQYg
# mQiUaJchNYwJYCF3xUVYJmi+OCr5JSAMmJtXLjDJSk440Pila6Uf7+CKCYVIn+1M
# cjzxPN2G1jir8ww+WJFZWjlSfzzP+VSbB5ay1d5ZDP5GYdY+vxEUHtZBfWUa3Rc0
# fAdl6MRhRDfOBqrPvpgEJUuHQklqwjMT75W88IJrcRT1yUKEv4iM68vGkTkHy5+/
# bKeYW3r9EW9o0PWUTDGtAtVPhp/5E+4SaFS41cSLivalj87ybIxPe9i6jwr3SMC6
# qgE/D9FlR42FC4PJC69qf8NWkXCH/exvq49+ePBrZ1AGACynoqVK6RNBwg==
# SIG # End signature block
