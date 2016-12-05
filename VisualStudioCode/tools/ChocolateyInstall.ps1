$ErrorActionPreference = 'Stop';

# Default values
$createDesktopIcon = $true
$createQuickLaunchIcon = $true
$addContextMenuFiles = $true
$addContextMenuFolders = $true
$addToPath = $true

$arguments = ParseParameters $env:chocolateyPackageParameters
if ($arguments.ContainsKey("nodesktopicon"))
{
    $createDesktopIcon = $false
}

if ($arguments.ContainsKey("noquicklaunchicon"))
{
    $createQuickLaunchIcon = $false
}

if ($arguments.ContainsKey("nocontextmenufiles"))
{
    $addContextMenuFiles = $false
}

if ($arguments.ContainsKey("nocontextmenufolders"))
{
    $addContextMenuFolders = $false
}

if ($arguments.ContainsKey("dontaddtopath"))
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
$packageName      = 'VisualStudioCode'
$installer        = Join-Path (GetParentDirectory $script) 'VSCodeSetup-1.7.2.exe'
$url              = 'https://go.microsoft.com/fwlink/?LinkID=623230'
$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = $installer
  url             = $url
  softwareName    = 'VisualStudioCode*'
  checksum        = 'CE706A90880DFC94F1C6B3911FFD66BE0EC4EC4C0FCB70EEC78B20357BDCEE23'
  checksumType    = 'sha256'
  silentArgs      = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs