# Copyright ©  2015 - Present RealDimensions Software, LLC ("RDS")
# 
# Chocolatey Professional, Chocolatey for MSP, and Chocolatey for Business (including Enterprise) are licensed software.
# 
# ===========================================================================
# End-User License Agreement
# Chocolatey Professional, Chocolatey for Business, and Chocolatey Enterprise
# ===========================================================================
# IMPORTANT- READ CAREFULLY: This RealDimensions Software ("RDS") End-User License Agreement ("EULA") 
# is a legal agreement between you("End User") and RDS for all RDS products, controls, source code, demos, 
# intermediate files, media, printed materials, and "online" or electronic documentation 
# ("SOFTWARE PRODUCT(S)") contained with this distribution.
# 
# RDS grants to you as an individual, a personal, nonexclusive license to install and use the SOFTWARE 
# PRODUCT(S) for the sole purpose of using with Chocolatey. By installing, copying, or otherwise using the 
# SOFTWARE PRODUCT(S), you agree to be bound by the terms of this EULA. If you do not agree to any part 
# of the terms of this EULA, DO NOT INSTALL, USE, OR EVALUATE, ANY PART, FILE OR PORTION OF THE 
# SOFTWARE PRODUCT(S).
# 
# ALL SOFTWARE PRODUCT(S) are licensed not sold. If you are an individual, you must acquire an individual 
# license for the SOFTWARE PRODUCT(S) from RDS or its authorized resellers. If you are an entity, you must 
# acquire an individual license for each machine running the SOFTWARE PRODUCT(S) within your 
# organization from RDS or its authorized resellers. Both virtual and physical machines running the SOFTWARE 
# PRODUCT(S) must be counted in the SOFTWARE PRODUCT(S) licenses quantity of the organization.

if ($env:ChocolateyLicenseValid -eq 'true' -and $env:ChocolateyPowerShellHost -eq 'true' ) {
  Set-Alias Get-VirusCheckValid Get-VirusCheckValidCmdlet -Force -Scope Global
  Set-Alias Get-WebHeaders Get-WebHeadersCmdlet -Force -Scope Global
  Set-Alias Get-WebFileName Get-WebFileNameCmdlet -Force -Scope Global
  Set-Alias Get-WebFile Get-WebFileCmdlet -Force -Scope Global
  Set-Alias Install-ChocolateyInstallPackage Install-ChocolateyInstallPackageCmdlet -Force -Scope Global

  $licenseType = $env:ChocolateyLicenseType
  Write-Debug "License type set to $licenseType"
  if ($licenseType -ne $null -and ($licenseType -ne 'Unknown' -and $licenseType -ne 'Foss' -and $licenseType -ne 'Professional' -and $licenseType -ne 'ManagedServiceProvider')) {
    Set-Alias Install-ChocolateyWindowsService Install-ChocolateyWindowsServiceCmdlet -Force -Scope Global
    Set-Alias Uninstall-ChocolateyWindowsService Uninstall-ChocolateyWindowsServiceCmdlet -Force -Scope Global
    Set-Alias Start-ChocolateyWindowsService Start-ChocolateyWindowsServiceCmdlet -Force -Scope Global
    Set-Alias Stop-ChocolateyWindowsService Stop-ChocolateyWindowsServiceCmdlet -Force -Scope Global
  }

  Export-ModuleMember -Alias *
} elseif ($env:ChocolateyLicenseValid -eq 'true' -and $env:ChocolateyPowerShellHost -ne 'true' ) {
  Write-Warning "Chocolatey License PowerShell Modules currently only work with the built-in PowerShell Host. Please enable the powershellHost feature."
}

# SIG # Begin signature block
# MIIcrQYJKoZIhvcNAQcCoIIcnjCCHJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCPwJGEr5facC/i
# NsF4ywJzinnmyYE+HREf6naZOTRSiKCCF7cwggUwMIIEGKADAgECAhAECRgbX9W7
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
# aGxEMrJmoecYpJpkUe8wggVAMIIEKKADAgECAhAHdGbtomdvOuySF9IwU3EQMA0G
# CSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0
# IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcgQ0EwHhcNMTYwMzI0MDAwMDAw
# WhcNMTcwMzI4MTIwMDAwWjB9MQswCQYDVQQGEwJVUzEPMA0GA1UECBMGS2Fuc2Fz
# MQ8wDQYDVQQHEwZUb3Bla2ExJTAjBgNVBAoTHFJlYWxEaW1lbnNpb25zIFNvZnR3
# YXJlLCBMTEMxJTAjBgNVBAMTHFJlYWxEaW1lbnNpb25zIFNvZnR3YXJlLCBMTEMw
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC52YS2WKUpBtdkDyJ3G0Qm
# 42v+W+yqr7DediVzIeCjHpKNkmmxO8+lS+nniFDjoFGO1JG/G3ZywVRFlM1LKHeP
# M1eON6wT0H1gvhxpMzyuC/SRW9wvMtTlvHnjdTLW06Oe9tvGkQkTM8rbzwRDIZ9o
# ddT8BxHSOmGelrAN9CwKf60ziw8jKLZnuAuZwSgkX5K7wvOs8viqydlnt7z3Wyim
# L+wjue85Mpa7jyjIfnUqssN1qz4nce+e89CxTD2AbWjGwnfTcTgmj3EUSJRQgDRk
# J+O/sVzS/V76xajLoPvI4ZlAsMpeK3ptLYqviU3ZaNUzLQWFjuWqc3fhjbWDFF51
# AgMBAAGjggHFMIIBwTAfBgNVHSMEGDAWgBRaxLl7KgqjpepxA8Bg+S32ZXUOWDAd
# BgNVHQ4EFgQUT0GgvxvwrOqMjXQ8yw7QDagIVJ4wDgYDVR0PAQH/BAQDAgeAMBMG
# A1UdJQQMMAoGCCsGAQUFBwMDMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jcmwz
# LmRpZ2ljZXJ0LmNvbS9zaGEyLWFzc3VyZWQtY3MtZzEuY3JsMDWgM6Axhi9odHRw
# Oi8vY3JsNC5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDBMBgNV
# HSAERTBDMDcGCWCGSAGG/WwDATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5k
# aWdpY2VydC5jb20vQ1BTMAgGBmeBDAEEATCBhAYIKwYBBQUHAQEEeDB2MCQGCCsG
# AQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wTgYIKwYBBQUHMAKGQmh0
# dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVkSURD
# b2RlU2lnbmluZ0NBLmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4IB
# AQAD6K2ldfDx7hOZxW6smYkiV4lxXY4bewxGv/gh2hjWgLiQ/sornz2fHDni/kOf
# qhn8/3KvYd4V33QqMqjm/qsRpwjj9NC/Q2BGuTg0ax3e/Z9ZIvcYB4xx8CRbGKse
# R9lixgMAJZMCWyGzAC/E3XX+BX3B6y8N5zBIKRY1M7xub+LM7zW9LGMhX3e56J7G
# UF7zIzQ7ZkaJzfxFbVvEz2/KNoNGiCmA7Y0biMXpX9730Dbg4Z+B4SUe4k4WPLS/
# 3goAq8lVMFtoqShvyvrmYtj2gFjQmH3BzSCSRZrAFbWYDCga57Fq7A4xrF2i67kG
# oljzeP+/35wuoOlrggn2EuJ1MIIGajCCBVKgAwIBAgIQAwGaAjr/WLFr1tXq5hfw
# ZjANBgkqhkiG9w0BAQUFADBiMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNl
# cnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSEwHwYDVQQDExhEaWdp
# Q2VydCBBc3N1cmVkIElEIENBLTEwHhcNMTQxMDIyMDAwMDAwWhcNMjQxMDIyMDAw
# MDAwWjBHMQswCQYDVQQGEwJVUzERMA8GA1UEChMIRGlnaUNlcnQxJTAjBgNVBAMT
# HERpZ2lDZXJ0IFRpbWVzdGFtcCBSZXNwb25kZXIwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQCjZF38fLPggjXg4PbGKuZJdTvMbuBTqZ8fZFnmfGt/a4yd
# VfiS457VWmNbAklQ2YPOb2bu3cuF6V+l+dSHdIhEOxnJ5fWRn8YUOawk6qhLLJGJ
# zF4o9GS2ULf1ErNzlgpno75hn67z/RJ4dQ6mWxT9RSOOhkRVfRiGBYxVh3lIRvfK
# Do2n3k5f4qi2LVkCYYhhchhoubh87ubnNC8xd4EwH7s2AY3vJ+P3mvBMMWSN4+v6
# GYeofs/sjAw2W3rBerh4x8kGLkYQyI3oBGDbvHN0+k7Y/qpA8bLOcEaD6dpAoVk6
# 2RUJV5lWMJPzyWHM0AjMa+xiQpGsAsDvpPCJEY93AgMBAAGjggM1MIIDMTAOBgNV
# HQ8BAf8EBAMCB4AwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDCCAb8GA1UdIASCAbYwggGyMIIBoQYJYIZIAYb9bAcBMIIBkjAoBggrBgEFBQcC
# ARYcaHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzCCAWQGCCsGAQUFBwICMIIB
# Vh6CAVIAQQBuAHkAIAB1AHMAZQAgAG8AZgAgAHQAaABpAHMAIABDAGUAcgB0AGkA
# ZgBpAGMAYQB0AGUAIABjAG8AbgBzAHQAaQB0AHUAdABlAHMAIABhAGMAYwBlAHAA
# dABhAG4AYwBlACAAbwBmACAAdABoAGUAIABEAGkAZwBpAEMAZQByAHQAIABDAFAA
# LwBDAFAAUwAgAGEAbgBkACAAdABoAGUAIABSAGUAbAB5AGkAbgBnACAAUABhAHIA
# dAB5ACAAQQBnAHIAZQBlAG0AZQBuAHQAIAB3AGgAaQBjAGgAIABsAGkAbQBpAHQA
# IABsAGkAYQBiAGkAbABpAHQAeQAgAGEAbgBkACAAYQByAGUAIABpAG4AYwBvAHIA
# cABvAHIAYQB0AGUAZAAgAGgAZQByAGUAaQBuACAAYgB5ACAAcgBlAGYAZQByAGUA
# bgBjAGUALjALBglghkgBhv1sAxUwHwYDVR0jBBgwFoAUFQASKxOYspkH7R7for5X
# DStnAs0wHQYDVR0OBBYEFGFaTSS2STKdSip5GoNL9B6Jwcp9MH0GA1UdHwR2MHQw
# OKA2oDSGMmh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJ
# RENBLTEuY3JsMDigNqA0hjJodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNl
# cnRBc3N1cmVkSURDQS0xLmNybDB3BggrBgEFBQcBAQRrMGkwJAYIKwYBBQUHMAGG
# GGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBBBggrBgEFBQcwAoY1aHR0cDovL2Nh
# Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ0EtMS5jcnQwDQYJ
# KoZIhvcNAQEFBQADggEBAJ0lfhszTbImgVybhs4jIA+Ah+WI//+x1GosMe06Fxlx
# F82pG7xaFjkAneNshORaQPveBgGMN/qbsZ0kfv4gpFetW7easGAm6mlXIV00Lx9x
# sIOUGQVrNZAQoHuXx/Y/5+IRQaa9YtnwJz04HShvOlIJ8OxwYtNiS7Dgc6aSwNOO
# Mdgv420XEwbu5AO2FKvzj0OncZ0h3RTKFV2SQdr5D4HRmXQNJsQOfxu19aDxxncG
# KBXp2JPlVRbwuwqrHNtcSCdmyKOLChzlldquxC5ZoGHd2vNtomHpigtt7BIYvfdV
# VEADkitrwlHCCkivsNRu4PQUCjob4489yq9qjXvc2EQwggbNMIIFtaADAgECAhAG
# /fkDlgOt6gAK6z8nu7obMA0GCSqGSIb3DQEBBQUAMGUxCzAJBgNVBAYTAlVTMRUw
# EwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x
# JDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0wNjExMTAw
# MDAwMDBaFw0yMTExMTAwMDAwMDBaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
# aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMT
# GERpZ2lDZXJ0IEFzc3VyZWQgSUQgQ0EtMTCCASIwDQYJKoZIhvcNAQEBBQADggEP
# ADCCAQoCggEBAOiCLZn5ysJClaWAc0Bw0p5WVFypxNJBBo/JM/xNRZFcgZ/tLJz4
# FlnfnrUkFcKYubR3SdyJxArar8tea+2tsHEx6886QAxGTZPsi3o2CAOrDDT+GEmC
# /sfHMUiAfB6iD5IOUMnGh+s2P9gww/+m9/uizW9zI/6sVgWQ8DIhFonGcIj5BZd9
# o8dD3QLoOz3tsUGj7T++25VIxO4es/K8DCuZ0MZdEkKB4YNugnM/JksUkK5ZZgrE
# jb7SzgaurYRvSISbT0C58Uzyr5j79s5AXVz2qPEvr+yJIvJrGGWxwXOt1/HYzx4K
# dFxCuGh+t9V3CidWfA9ipD8yFGCV/QcEogkCAwEAAaOCA3owggN2MA4GA1UdDwEB
# /wQEAwIBhjA7BgNVHSUENDAyBggrBgEFBQcDAQYIKwYBBQUHAwIGCCsGAQUFBwMD
# BggrBgEFBQcDBAYIKwYBBQUHAwgwggHSBgNVHSAEggHJMIIBxTCCAbQGCmCGSAGG
# /WwAAQQwggGkMDoGCCsGAQUFBwIBFi5odHRwOi8vd3d3LmRpZ2ljZXJ0LmNvbS9z
# c2wtY3BzLXJlcG9zaXRvcnkuaHRtMIIBZAYIKwYBBQUHAgIwggFWHoIBUgBBAG4A
# eQAgAHUAcwBlACAAbwBmACAAdABoAGkAcwAgAEMAZQByAHQAaQBmAGkAYwBhAHQA
# ZQAgAGMAbwBuAHMAdABpAHQAdQB0AGUAcwAgAGEAYwBjAGUAcAB0AGEAbgBjAGUA
# IABvAGYAIAB0AGgAZQAgAEQAaQBnAGkAQwBlAHIAdAAgAEMAUAAvAEMAUABTACAA
# YQBuAGQAIAB0AGgAZQAgAFIAZQBsAHkAaQBuAGcAIABQAGEAcgB0AHkAIABBAGcA
# cgBlAGUAbQBlAG4AdAAgAHcAaABpAGMAaAAgAGwAaQBtAGkAdAAgAGwAaQBhAGIA
# aQBsAGkAdAB5ACAAYQBuAGQAIABhAHIAZQAgAGkAbgBjAG8AcgBwAG8AcgBhAHQA
# ZQBkACAAaABlAHIAZQBpAG4AIABiAHkAIAByAGUAZgBlAHIAZQBuAGMAZQAuMAsG
# CWCGSAGG/WwDFTASBgNVHRMBAf8ECDAGAQH/AgEAMHkGCCsGAQUFBwEBBG0wazAk
# BggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAC
# hjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
# b290Q0EuY3J0MIGBBgNVHR8EejB4MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdpY2Vy
# dC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMDqgOKA2hjRodHRwOi8v
# Y3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMB0G
# A1UdDgQWBBQVABIrE5iymQftHt+ivlcNK2cCzTAfBgNVHSMEGDAWgBRF66Kv9JLL
# gjEtUYunpyGd823IDzANBgkqhkiG9w0BAQUFAAOCAQEARlA+ybcoJKc4HbZbKa9S
# z1LpMUerVlx71Q0LQbPv7HUfdDjyslxhopyVw1Dkgrkj0bo6hnKtOHisdV0XFzRy
# R4WUVtHruzaEd8wkpfMEGVWp5+Pnq2LN+4stkMLA0rWUvV5PsQXSDj0aqRRbpoYx
# YqioM+SbOafE9c4deHaUJXPkKqvPnHZL7V/CSxbkS3BMAIke/MV5vEwSV/5f4R68
# Al2o/vsHOE8Nxl2RuQ9nRc3Wg+3nkg2NsWmMT/tZ4CMP0qquAHzunEIOz5HXJ7cW
# 7g/DvXwKoO4sCFWFIrjrGBpN/CohrUkxg0eVd3HcsRtLSxwQnHcUwZ1PL1qVCCkQ
# JjGCBEwwggRIAgEBMIGGMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
# dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lD
# ZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25pbmcgQ0ECEAd0Zu2iZ2867JIX
# 0jBTcRAwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKA
# ADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYK
# KwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQg98+hHg/bStvQbvZsKbLWUcsF/SQq
# vu+K/uK4k2YzWqEwDQYJKoZIhvcNAQEBBQAEggEAAO9w1XpmGWDpjl8l3xTGVAnX
# ynKa+45VhJgXzQUnSVsu8tPB8U6cxpIeK1ts6pXX4GG1HJCrC8cWmJqLmzqQDbzi
# kM07wjx4YgkqfIbl5fCD+KNLbWVK7HHk44s8Zs5V/DXH+1922HBpXLoT/sKwMgDY
# 0c4pNn3ArGnBrMDew7leMFZMOc/4pBmwAr50/aOqOwee7qr4cG/X5key+Jzy5gAt
# cjjF3j0wIQDbHRX5whEQ/pcV/WtXdPhv6ecIAmyxihKJj8d7AHIDqnG0thVmvfk/
# SRyzDDj0CSxR837SyNMVFg6NGbfg+SGaW4bEC+7SmgUjk+jQqn8FAP45RSWOPaGC
# Ag8wggILBgkqhkiG9w0BCQYxggH8MIIB+AIBATB2MGIxCzAJBgNVBAYTAlVTMRUw
# EwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x
# ITAfBgNVBAMTGERpZ2lDZXJ0IEFzc3VyZWQgSUQgQ0EtMQIQAwGaAjr/WLFr1tXq
# 5hfwZjAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
# hkiG9w0BCQUxDxcNMTcwMzI1MTg1MzM2WjAjBgkqhkiG9w0BCQQxFgQUko/n80Ga
# xFARHi3+00z0r8uvhuQwDQYJKoZIhvcNAQEBBQAEggEASo5lsNp0RqPPLlUtgo/J
# EDtk690tNSPHPmjNT28Ot2nulGRdyL9wesDyzUa8gURaNH9hdY5S9WxWD3fYOWXW
# gyKs9S/KdgxAbYHN3nnYVEmER8wEByvRla0s+jrCqsdo5ieixvXDfVQ0I0GO3fW+
# BTMOy5SK5syiLTkkYpzn1ubW8S50VxPbQKXyhaX2Hqw0bFu0g6b1KHpBLYg4pbij
# A+azVVoZJXuNQ9WcdOWlNWIevf1VYYTthxz9xrhLfSiMoiQWgLh4xchJJoKRlgl+
# iJ1VhpkGPHXgWjBso3AVHmb+D2N3QUj4cv6qjilrbmz1sggWxER/n7rjcYziWSi8
# ig==
# SIG # End signature block
