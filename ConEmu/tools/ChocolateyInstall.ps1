$script           = $MyInvocation.MyCommand.Definition
$os               = if ($IsSystem32Bit) { "x86" } else { "x64" }
$packageArgs      = @{
  packageName     = 'ConEmu'
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (GetParentDirectory $script) 'ConEmuSetup.161203.exe'
  url             = 'https://github.com/Maximus5/ConEmu/releases/download/v16.12.03/ConEmuSetup.161203.exe'
  softwareName    = 'ConEmu*'
  checksum        = '08EF60D4A6DBB09EF382994BFC8D7E4DA363F8DCB4EF9B351B28686B5C757C88'
  checksumType    = 'sha256'
  silentArgs      = "/p:$os /quiet /norestart"
  validExitCodes  = @(0, 3010, 1641)
}

Install $packageArgs