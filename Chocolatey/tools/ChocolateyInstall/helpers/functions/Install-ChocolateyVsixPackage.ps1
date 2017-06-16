# Copyright © 2017 Chocolatey Software, Inc.
# Copyright © 2015 - 2017 RealDimensions Software, LLC
# Copyright © 2011 - 2015 RealDimensions Software, LLC & original authors/contributors from https://github.com/chocolatey/chocolatey
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function Install-ChocolateyVsixPackage {
<#
.SYNOPSIS
Downloads and installs a VSIX package for Visual Studio

.DESCRIPTION
VSIX packages are Extensions for the Visual Studio IDE. The Visual
Studio Gallery at  http://visualstudiogallery.msdn.microsoft.com/ is the
public extension feed and hosts thousands of extensions. You can locate
a VSIX Url by finding the download link of Visual Studio extensions on
the Visual Studio Gallery.

.NOTES
Chocolatey works best when the packages contain the software it is
managing and doesn't require downloads. However most software in the
Windows world requires redistribution rights and when sharing packages
publicly (like on the community feed), maintainers may not have those
aforementioned rights. Chocolatey understands how to work with that,
hence this function. You are not subject to this limitation with
internal packages.

.INPUTS
None

.OUTPUTS
None

.PARAMETER PackageName
The name of the package - while this is an arbitrary value, it's
recommended that it matches the package id.

In 0.10.4+, `Name` is an alias for PackageName.

.PARAMETER VsixUrl
The URL of the package to be installed.

Prefer HTTPS when available. Can be HTTP, FTP, or File URIs.

In 0.10.4+, `Url` is an alias for VsixUrl.

.PARAMETER VsVersion
The major version number of Visual Studio where the
package should be installed. This is optional. If not
specified, the most recent Visual Studio installation
will be targetted.

NOTE: For Visual Studio 2015, the VsVersion is 14. It can be determined
by looking at the folders under Program Files / Program Files (x86).

In 0.10.4+, `VisualStudioVersion` is an alias for VsVersion.

.PARAMETER Checksum
The checksum hash value of the Url resource. This allows a checksum to 
be validated for files that are not local. The checksum type is covered
by ChecksumType. 

**NOTE:** Checksums in packages are meant as a measure to validate the 
originally intended file that was used in the creation of a package is
the same file that is received at a future date. Since this is used for
other steps in the process related to the community repository, it 
ensures that the file a user receives is the same file a maintainer
and a moderator (if applicable), plus any moderation review has 
intended for you to receive with this package. If you are looking at a 
remote source that uses the same url for updates, you will need to 
ensure the package also stays updated in line with those remote 
resource updates. You should look into [automatic packaging](https://chocolatey.org/docs/automatic-packages) 
to help provide that functionality.

**NOTE:** To determine checksums, you can get that from the original 
site if provided. You can also use the [checksum tool available on 
the community feed](https://chocolatey.org/packages/checksum) (`choco install checksum`) 
and use it e.g. `checksum -t sha256 -f path\to\file`. Ensure you 
provide checksums for all remote resources used.

.PARAMETER ChecksumType
The type of checkum that the file is validated with - valid
values are 'md5', 'sha1', 'sha256' or 'sha512' - defaults to 'md5'.

MD5 is not recommended as certain organizations need to use FIPS
compliant algorithms for hashing - see
https://support.microsoft.com/en-us/kb/811833 for more details.

The recommendation is to use at least SHA256.

.PARAMETER Options
OPTIONAL - Specify custom headers. Available in 0.9.10+.

.PARAMETER File
Will be used for VsixUrl if VsixUrl is empty. Available in 0.10.7+.

This parameter provides compatibility, but should not be used directly
and not with the community package repository until January 2018.

.PARAMETER IgnoredArguments
Allows splatting with arguments that do not apply. Do not use directly.

.EXAMPLE
>
# This downloads the AutoWrockTestable VSIX from the Visual Studio
# Gallery and installs it to the latest version of VS.

Install-ChocolateyVsixPackage -PackageName "MyPackage" `
  -VsixUrl http://visualstudiogallery.msdn.microsoft.com/ea3a37c9-1c76-4628-803e-b10a109e7943/file/73131/1/AutoWrockTestable.vsix

.EXAMPLE
>
# This downloads the AutoWrockTestable VSIX from the Visual Studio
# Gallery and installs it to Visual Studio 2012 (v11.0).

Install-ChocolateyVsixPackage -PackageName "MyPackage" `
  -VsixUrl http://visualstudiogallery.msdn.microsoft.com/ea3a37c9-1c76-4628-803e-b10a109e7943/file/73131/1/AutoWrockTestable.vsix `
  -VsVersion 11

.LINK
Install-ChocolateyPackage

.LINK
Install-ChocolateyInstallPackage

.LINK
Install-ChocolateyZipPackage
#>
param(
  [alias("name")][parameter(Mandatory=$true, Position=0)][string] $packageName,
  [alias("url")][parameter(Mandatory=$false, Position=1)][string] $vsixUrl,
  [alias("visualStudioVersion")][parameter(Mandatory=$false, Position=2)][int] $vsVersion = 0,
  [parameter(Mandatory=$false)][string] $checksum = '',
  [parameter(Mandatory=$false)][string] $checksumType = '',
  [parameter(Mandatory=$false)][hashtable] $options = @{Headers=@{}},
  [alias("fileFullPath")][parameter(Mandatory=$false)][string] $file = '',
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

    Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

    if ($vsixUrl -eq '' -or $vsixUrl -eq $null) {
        $vsixUrl = $file
    }

    if($vsVersion -eq 0) {
        if ([System.IntPtr]::Size -eq 4)
        {
            <# 32bits system case #>
            $versions=(get-ChildItem HKLM:SOFTWARE\Microsoft\VisualStudio -ErrorAction SilentlyContinue | ? { ($_.PSChildName -match "^[0-9\.]+$") } | ? {$_.property -contains "InstallDir"} | sort {[int]($_.PSChildName)} -descending)
        }
        else
        {
            $versions=(get-ChildItem HKLM:SOFTWARE\Wow6432Node\Microsoft\VisualStudio -ErrorAction SilentlyContinue | ? { ($_.PSChildName -match "^[0-9\.]+$") } | ? {$_.property -contains "InstallDir"} | sort {[int]($_.PSChildName)} -descending)
        }
        if($versions -and $versions.Length){
            $version = $versions[0]
        }elseif($versions){
            $version = $versions
        }
    }
    else {
        if ([System.IntPtr]::Size -eq 4)
        {
            <# 32bits system case #>
            $versions=(get-ChildItem HKLM:SOFTWARE\Microsoft\VisualStudio -ErrorAction SilentlyContinue | ? { ($_.PSChildName.EndsWith("$vsVersion.0")) } | ? {$_.property -contains "InstallDir"})
        }
        else
        {
            $version=(get-ChildItem HKLM:SOFTWARE\Wow6432Node\Microsoft\VisualStudio -ErrorAction SilentlyContinue | ? { ($_.PSChildName.EndsWith("$vsVersion.0")) } | ? {$_.property -contains "InstallDir"})
        }
    }

    if ($version) {
        $vnum=$version.PSPath.Substring($version.PSPath.LastIndexOf('\')+1)
        if($vnum -as [int] -lt 10) {
            throw "This installed VS version, $vnum, does not support installing VSIX packages. Version 10 is the minimum acceptable version."
        }
        $dir=(get-itemProperty $version.PSPath "InstallDir").InstallDir
        $installer = Join-Path $dir "VsixInstaller.exe"
    }

    if ($installer) {
        $download="$env:TEMP\$($packageName.Replace(' ','')).vsix"
        try{
            Get-ChocolateyWebFile $packageName $download $vsixUrl -checksum $checksum -checksumType $checksumType -Options $options
        }
        catch {
            throw "There were errors attempting to retrieve the vsix from $vsixUrl. The error message was '$_'."
        }

        Write-Debug "Installing VSIX using $installer"
        $exitCode = Install-Vsix "$installer" "$download"
        if($exitCode -gt 0 -and $exitCode -ne 1001) { #1001: Already installed
           throw "There was an error installing '$packageName'. The exit code returned was $exitCode."
        }
    }
    else {
        throw "Visual Studio is not installed or the specified version is not present."
    }
}

# SIG # Begin signature block
# MIIcpwYJKoZIhvcNAQcCoIIcmDCCHJQCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAwvbwbcXwGHARv
# s0aL6zHGEwZUxYCbjjh5ZcXDMGFCc6CCF7EwggUwMIIEGKADAgECAhAECRgbX9W7
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
# NwIBFTAvBgkqhkiG9w0BCQQxIgQgY21LEp9apuTMLqguzypSjDhrQ2TRe8edZGc6
# /Wjr8LIwDQYJKoZIhvcNAQEBBQAEggEAPxJVN6cWJJcXV7afUfephqn4giKtyoAr
# 8XdVnoGO/3gkGsmbphCXi9qKCWrJFKtcVBE7YY6ya9VOeXUvFSZOUBHoVLbZ/e2I
# ZV770km1RPzkYKC7GkXJfb7+reaZ2OSmFlmGdwXNxGDbet5Qa/ckyZZJDMSW9BeA
# 7SK7ncNpx+sK67+gi3621+q/SRSJYxpedJs5oNWQ7TFDXvnEiUuZg6pCxkIlOXNf
# HOi0bWprnXhd6gannbR1P41ljjOwqFCr5rshu68DthyaAlO7Yb6Ua6IEbUQx3aey
# +fKkTimFgWOoq9Qy0DDMP5Fu/ngdAu6eRqDe0k53YcrtJRdTT+bt4qGCAg8wggIL
# BgkqhkiG9w0BCQYxggH8MIIB+AIBATB2MGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IEFzc3VyZWQgSUQgQ0EtMQIQAwGaAjr/WLFr1tXq5hfwZjAJ
# BgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
# CQUxDxcNMTcwNjA4MjAzMjEwWjAjBgkqhkiG9w0BCQQxFgQULUa8TQADTUUFaSVp
# GlNibL23ec8wDQYJKoZIhvcNAQEBBQAEggEAO+abc+0Ln+7g+R4PSD7sAWmT5gsC
# 6cAecUpFEpHChDwSLNlQMv9Fqcr0zzpAAeLrhYTyEtx7h0Tf6E4Biihdzrbm1Ahv
# RwPnGTXFmN7pgufrxVOg519KLxi9GatPN6PSfbYjOkOjSA9610pDjABSD3OGL07i
# r1bS0giTRVjsxut0uulItKtIr5kQfGFwDnznC+V6BxOieZyBkLalfXKDEqvw9pmY
# 4+74MjQqIRVWME93thK5ZBB+Hbx65/IiX0k9R+u4YgcWOEn7JrQQpHbLawy3cKUi
# d2r6XgZOJT0WdvHSh3YyRXxwDLAwJSL5e/9nO2YmRcXSUw12ELKzgUXOnA==
# SIG # End signature block
