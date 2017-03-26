$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

Describe "Get-Executable" {
    BeforeEach {
        $env:ChocolateyPackageFolder = ''
    }

    InModuleScope InstallHelpers {
        $baseDir = Split-Path -Parent $env:ModuleUnderTest

        Context "When No RegEx or File is Provided" {
            It "The File Should Be Empty" {
                Get-Executable | Should BeNullOrEmpty
            }
        }
        Context "When the Base Directory Exists" {
            Mock Test-DirectoryExists { $true } -Verifiable

            $result = Get-Executable $baseDir $env:moduleName

            It "Should Find the Executable in the Base Directory" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When the ChocolateyPackageFolder is Not Set" {
            Mock Test-DirectoryExists { $false } -Verifiable

            $result = Get-Executable -File $env:moduleName

            It "Should Find the Executable in the Current Directory" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When the ChocolateyPackageFolder is Set" {
            Mock Test-DirectoryExists { $false } -Verifiable

            $env:ChocolateyPackageFolder = Split-Path -Parent $env:ModuleUnderTest
            $result = Get-Executable -File $env:moduleName

            It "Should Find the Executable in the ChocolateyPackageFolder Directory" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When the packagesInstallers is Set" {
            Mock Test-DirectoryExists { $false } -Verifiable

            $env:packagesInstallers = Split-Path -Parent $env:ModuleUnderTest
            $result = Get-Executable -File $env:moduleName

            It "Should Find the Executable in the packagesInstallers Directory" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When Single Filename is Provided" {
            $result = Get-Executable $baseDir $env:moduleName

            It "Should Find the Executable in the Base Directory" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When a RegEx is Provided" {
            $result = Get-Executable -BaseDir $baseDir -RegEx 'InstallHelpers\.psm1'

            It "Should Find the Executable in the Base Directory" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When a RegEx is Provided and the ChocolateyPackageFolder is Set" {
            Mock Test-DirectoryExists { $false } -Verifiable

            $env:ChocolateyPackageFolder = Split-Path -Parent $env:ModuleUnderTest
            $regEx = 'InstallHelpers\.ps'
            $result = Get-Executable -RegEx $regEx

            It "Should Find the File" {
                $result | Should Be $env:ModuleUnderTest
            }
        }
        Context "When Multiple Files are Found" {
            $executableRegEx = 'Get'
            $result = Get-Executable -BaseDir $baseDir -RegEx $executableRegEx

            It "The Executable Should Be Empty" {
                $result | Should BeNullOrEmpty
            }
        }
        Context "When No Files are Found" {
            $executableRegEx = '.obscure'
            $result = Get-Executable -BaseDir $baseDir -RegEx $executableRegEx

            It "The File Should Be Empty" {
                $result | Should BeNullOrEmpty
            }
        }
    }
}