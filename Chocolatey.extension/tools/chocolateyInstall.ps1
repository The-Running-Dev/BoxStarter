$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -EA SilentlyContinue | Out-Null

$licenseType = $env:ChocolateyLicenseType
if ($licenseType -ne $null -and ($licenseType -eq 'Business' -or $licenseType -eq 'BusinessTrial' -or $licenseType -eq 'Architect')) {
  # set up calls to packagebuilder 
  $exeFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty 'HKCR:\.exe' -ErrorAction Stop).'(default)' } catch { 'exefile' })
  $msiFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty 'HKCR:\.msi' -ErrorAction Stop).'(default)' } catch { 'Msi.Package' })
  $mspFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty 'HKCR:\.msp' -ErrorAction Stop).'(default)' } catch { 'Msi.Patch' })
  $msuFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty 'HKCR:\.msu' -ErrorAction Stop).'(default)' } catch { 'Microsoft.System.Update.1' })
  $zipFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty 'HKCR:\.zip' -ErrorAction Stop).'(default)' } catch { 'CompressedFolder' })
  $7zFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty 'HKCR:\.7z' -ErrorAction Stop).'(default)' } catch { 'GenericChocolateyHandler' })

  Write-Host "Adding Package Builder context menu for supported types."
  #todo: HKEY_CLASSES_ROOT\Folder\shell
  
  $exeFileTypeKey, $msiFileTypeKey, $mspFileTypeKey, $msuFileTypeKey, $zipFileTypeKey, $7zFileTypeKey |
  % {
    
    if ( -not (Test-Path $_)) {
      New-Item -Path $_ | Out-Null
    }
    $shellTypeKey = $_ + '\shell'
    if ( -not (Test-Path $shellTypeKey)) {
      New-Item -Path $shellTypeKey | Out-Null
    }
    $chocoTypeKey = $shellTypeKey + '\chocolatey'
    if ( -not (Test-Path $chocoTypeKey)) {
      New-Item -Path $chocoTypeKey | Out-Null
    }
    New-ItemProperty $chocoTypeKey -Name '(Default)' -Value 'Create Chocolatey &Package...' -PropertyType "String" -Force | Out-Null

    $chocoCommandTypeKey = $chocoTypeKey + '\command'
    if ( -not (Test-Path $chocoCommandTypeKey)) {
      New-Item -Path $chocoCommandTypeKey | Out-Null
    }
    New-ItemProperty $chocoCommandTypeKey -Name '(Default)' -Value "`"$($env:ChocolateyInstall)\bin\packagebuilder.exe`" `"%1`"" -PropertyType "String" -Force | Out-Null

    $chocoCliTypeKey = $shellTypeKey + '\chocolatey_cli'
    if ( -not (Test-Path $chocoCliTypeKey)) {
      New-Item -Path $chocoCliTypeKey | Out-Null
    }
    New-ItemProperty $chocoCliTypeKey -Name '(Default)' -Value 'Create &Chocolatey Package w/out GUI...' -PropertyType "String" -Force | Out-Null

    $chocoCommandCliTypeKey = $chocoCliTypeKey + '\command'
    if ( -not (Test-Path $chocoCommandCliTypeKey)) {
      New-Item -Path $chocoCommandCliTypeKey | Out-Null
    }
    New-ItemProperty $chocoCommandCliTypeKey -Name '(Default)' -Value "`"$($env:ChocolateyInstall)\bin\choco.exe`" new --file `"%1`" --build-package" -PropertyType "String" -Force | Out-Null

  }
}

$hkcrNuspec = 'HKCR:\.nuspec'
$nuspecFileTypeKey = 'HKCR:\' + $(try { (Get-ItemProperty $hkcrNuspec -ErrorAction Stop).'(default)' } catch { New-Item -Path $hkcrNuspec | Out-Null;  New-ItemProperty $hkcrNuspec -Name '(Default)' -Value 'ChocolateyPackHandler' -PropertyType "String" -Force | Out-Null;  'ChocolateyPackHandler' })

if ( -not (Test-Path $nuspecFileTypeKey)) {
  New-Item -Path $nuspecFileTypeKey | Out-Null
}
$nuspecIconFileTypeKey = $nuspecFileTypeKey + '\DefaultIcon'
if ( -not (Test-Path $nuspecIconFileTypeKey)) {
  New-Item -Path $nuspecIconFileTypeKey | Out-Null
}
New-ItemProperty $nuspecIconFileTypeKey -Name '(Default)' -Value "$($env:ChocolateyInstall)\bin\choco.exe,0" -PropertyType "String" -Force | Out-Null

$nuspecshellTypeKey = $nuspecFileTypeKey + '\shell'
if ( -not (Test-Path $nuspecshellTypeKey)) {
  New-Item -Path $nuspecshellTypeKey | Out-Null
}
$nuspecChocolateyTypeKey = $nuspecshellTypeKey + '\chocolatey'
if ( -not (Test-Path $nuspecChocolateyTypeKey)) {
  New-Item -Path $nuspecChocolateyTypeKey | Out-Null
}
New-ItemProperty $nuspecChocolateyTypeKey -Name '(Default)' -Value 'Compile Chocolatey &Package...' -PropertyType "String" -Force | Out-Null

# $nuspecOpenTypeKey = $nuspecshellTypeKey + '\Open'
# if ( -not (Test-Path $nuspecOpenTypeKey)) {
  # New-Item -Path $nuspecOpenTypeKey | Out-Null
# }

$nuspecCommandTypeKey = $nuspecChocolateyTypeKey + '\command'
if ( -not (Test-Path $nuspecCommandTypeKey)) {
  New-Item -Path $nuspecCommandTypeKey | Out-Null
}
New-ItemProperty $nuspecCommandTypeKey -Name '(Default)' -Value "`"%SystemRoot%\System32\cmd.exe`" /k choco pack `"%1`"" -PropertyType ExpandString -Force | Out-Null

# SIG # Begin signature block
# MIIcpwYJKoZIhvcNAQcCoIIcmDCCHJQCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDcNgD8QtPCw4DF
# JzTihHVKjjpc+8jNIRD9Q3WepyGlIqCCF7EwggUwMIIEGKADAgECAhAECRgbX9W7
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
# NwIBFTAvBgkqhkiG9w0BCQQxIgQgRNGrTaab/wkC44CuzDFubRB2YJqjBszBAMcs
# vIKqTlkwDQYJKoZIhvcNAQEBBQAEggEAN5cTDrpiezx+ciTOY3AeewQmfVpe03lX
# w5EkYClf0McamuehkKDVz+WxSdoA116d57WrL/kVTYa8rwCcXgztFFLcZvCZBQ55
# Ifegstuma1wgQAQrYdPpb2+hzVPXOqvSaP00GcPVb9CXfvROHrdATU0u+Mzt3fTo
# QOqWI5bwvWww4V4vtRYGhgUnZk+LoZFvjh/4b+5ozIOGU0AoWwmW7Igwsn7VuuWG
# o0gMlISsgqClwiS2b9BtE9kamKKVlRp7M/TfPbzfJCMzfNbGJ02Ck2m8Qttw1Fn7
# s7KEi7E3hGAoZg+3mCnpPc3tOKywQIO6Hi5v2N8NBMQTMBya9X40pKGCAg8wggIL
# BgkqhkiG9w0BCQYxggH8MIIB+AIBATB2MGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IEFzc3VyZWQgSUQgQ0EtMQIQAwGaAjr/WLFr1tXq5hfwZjAJ
# BgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
# CQUxDxcNMTcwNjA5MjE1NTAzWjAjBgkqhkiG9w0BCQQxFgQU16Dw/iT6hA5Psx1s
# Z4QFMYl6dSAwDQYJKoZIhvcNAQEBBQAEggEAUTTgi7wEZq+Fu8v8/aUsJk1Hrqd6
# OcobD1kPs0qCoStvqrNvXkfRNxM+OcKbH98BvhrtBwpLVw6U0yftaDSPq+P0do4r
# g0Ebv35it8sbjnL62xzBigMLsRFFDIoFJY5HKVJX1/wf6i902MQ6mrW2Rpc084LQ
# x5TNoOMSpXR2i8dpqjM5o0hJkAmLgEeQrKFU0bd72ImJFB+yn8zycfVnn14TlI6P
# OSsS3vM5GhB7ILE20lVviJgoNhQ9pdZxLK1YziibAlykGDwMS5u9HXHpmFJOuO8F
# ivAzQ8JsHi/2pI84MhJ60JXd6FswsQRYw30LlkzowOMWyK/EDpcTLM+xgA==
# SIG # End signature block
