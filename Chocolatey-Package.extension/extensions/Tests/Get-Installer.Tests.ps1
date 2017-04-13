<#
$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

Describe "Get-Installer" {
    InModuleScope InstallHelpers {
        function Install-ChocolateyZipPackage {}

        $fakeIso = 'C:\Path\Some.iso'
        $fakeUrl = 'http://some.place.com/file.exe'
        $fakeInstaller = 'C:\Path\Install.exe'
        $expectedFromIso = 'Z:\Install.exe'
        $expectedFromZip = 'C:\Path\Install.exe'

        Context "When the File Exists" {
            Mock Test-FileExists { $true } -Verifiable
            Mock Get-Executable { $fakeInstaller }

            $result = Get-Installer @{ 'file' = $fakeInstaller}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the File" {
                $result | Should Be  $fakeInstaller
            }
        }
        Context "When the File Does Not Exist" {
            Mock Get-FileExtension { } -Verifiable
            Mock Test-FileExists { $false } -Verifiable
            Mock Get-InstallerFromWeb { $fakeInstaller } -Verifiable

            $result = Get-Installer @{}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Downloaded File" {
                $result | Should Be $fakeInstaller
            }
        }
        Context "When the File is a Zip" {
            Mock Get-FileExtension { '.zip' } -Verifiable
            Mock Test-FileExists { $false } -Verifiable
            Mock Get-InstallerFromZip { $expectedFromZip } -Verifiable

            $result = Get-Installer @{ 'file' = $fakeZip; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Zip Installer" {
                $result | Should Be $expectedFromZip
            }
        }
        Context "When the File is a Zip" {
            Mock Get-FileExtension { '.zip' } -Verifiable
            Mock Test-FileExists { $true } -Verifiable
            Mock Get-InstallerFromZip { $expectedFromZip } -Verifiable

            $result = Get-Installer @{ 'file' = $fakeZip; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Zip Installer" {
                $result | Should Be $expectedFromZip
            }
        }
        Context "When the File is an ISO" {
            Mock Get-FileExtension { '.iso' } -Verifiable
            Mock Test-FileExists { $true } -Verifiable
            Mock Get-InstallerFromIso { $expectedFromIso } -Verifiable

            $result = Get-Installer @{'file' = $fakeIso; 'executableRegEx' = $executableRegEx}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to ISO Installer" {
                $result | Should Be $expectedFromIso
            }
        }
        Context "When the File Does Not Exist" {
            Mock Get-FileExtension { } -Verifiable
            Mock Test-FileExists { $false } -Verifiable
            Mock Get-InstallerFromWeb { $fakeInstaller } -Verifiable

            $result = Get-Installer @{ 'packageName' = 'fake';  'url' = $fakeUrl}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Installer" {
                $result | Should Be $fakeInstaller
            }
        }
        Context "When the URL is a Zip File" {
            Mock Test-FileExists { $false } -Verifiable
            Mock Get-FileExtension { '.zip' } -Verifiable
            Mock Get-InstallerFromZip { $expectedFromZip } -Verifiable

            $result = Get-Installer @{ 'packageName' = 'fake'; 'url' = $fakeUrl}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return an Empty Installer" {
                $result | Should Be $fakeInstaller
            }
        }
    }
}
#>