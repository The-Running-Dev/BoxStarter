$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'KDiff3'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'KDiff3-64bit-Setup_0.9.98-2.exe'
  url             = 'http://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.98/KDiff3-32bit-Setup_0.9.98-3.exe'
  url64           = 'http://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.98/KDiff3-64bit-Setup_0.9.98-2.exe'
  softwareName    = 'KDiff3*'
  checksum        = '3DCDE7057D2D527A567EA674F6693E250D0C273F981A3CFB513FBDCFF9E6614B'
  checksum64      = 'D630AB0FDCA3B4F1A85AB7E453F669FDC901CB81BB57F7E20DE64C02AC9A1EEB'
  checksumType    = 'sha256'
  checksumType64  = 'sha256'
  silentArgs      = '/S'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs