$ErrorActionPreference = 'Stop';

# Default values
$createDesktopIcon = $false
$createQuickLaunchIcon = $true
$addContextMenuFiles = $true
$addContextMenuFolders = $true
$addToPath = $true

$parameters = ParseParameters $env:chocolateyPackageParameters

if ($parameters.ContainsKey("nodesktopicon"))
{
    $createDesktopIcon = $false
}

if ($parameters.ContainsKey("noquicklaunchicon"))
{
    $createQuickLaunchIcon = $false
}

if ($parameters.ContainsKey("nocontextmenufiles"))
{
    $addContextMenuFiles = $false
}

if ($parameters.ContainsKey("nocontextmenufolders"))
{
    $addContextMenuFolders = $false
}

if ($parameters.ContainsKey("dontaddtopath"))
{
    $addToPath = $false
}

$mergeTasks = "!runCode"

if ($createDesktopIcon)
{
    $mergeTasks = $mergeTasks + ",desktopicon"
}

if ($createQuickLaunchIcon)
{
    $mergeTasks = $mergeTasks + ",quicklaunchicon"
}

if ($addContextMenuFiles)
{
    $mergeTasks = $mergeTasks + ",addcontextmenufiles"
}

if ($addContextMenuFolders)
{
    $mergeTasks = $mergeTasks + ",addcontextmenufolders"
}

if ($addToPath)
{
    $mergeTasks = $mergeTasks + ",addtopath"
}

$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'VSCodeSetup-1.7.2.exe'
  url             = 'https://go.microsoft.com/fwlink/?LinkID=623230'
  softwareName    = 'VisualStudioCode*'
  checksum        = 'CE706A90880DFC94F1C6B3911FFD66BE0EC4EC4C0FCB70EEC78B20357BDCEE23'
  checksumType    = 'sha256'
  silentArgs      = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs