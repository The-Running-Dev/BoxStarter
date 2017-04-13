<#
$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

Describe "Get-InstallerFromZip" {
    InModuleScope InstallHelpers {
        $fakeZip = 'C:\Path\Some.zip'
        $executableRegEx = 'Install.exe'
        $fakeUnzipLocation = 'C:\Path'
        $expected = 'C:\Path\Install.exe'

        Mock Get-Executable { 'C:\Path\Install.exe' } -Verifiable
        Mock Test-DirectoryExists { $true } -Verifiable

        function Get-ChocolateyUnzip { }
        function Install-ChocolateyZipPackage { }

        Context "When the Unzip Location Exists" {
            Mock Test-FileExists { $true } -Verifiable

            $result = Get-InstallerFromZip @{ 'file' = $fakeZip; 'unzipLocation' = $fakeUnzipLocation; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Unzipped File" {
                $result | Should Be $expected
            }
        }
        Context "When the Unzip Location Does Not Exists" {
            Mock Test-DirectoryExists { $false } -Verifiable
            Mock Get-Executable { 'C:\Users\Boyan\AppData\Local\Temp' } -Verifiable

            $result = Get-InstallerFromZip @{ 'file' = $fakeZip; 'unzipLocation' = $fakeUnzipLocation; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Unzipped File in the Temp Directory" {
                $result | Should Match "Temp"
            }
        }
        Context "When the URL is Provided" {
            Mock Test-FileExists { $false } -Verifiable

            $result = Get-InstallerFromZip @{ 'url' = $fakeUrl; 'unzipLocation' = $fakeUnzipLocation; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should Be $expected
            }
        }
        Context "When No Executable and No URL Exist" {
            Mock Test-DirectoryExists { $false } -Verifiable
            Mock Test-FileExists { $false } -Verifiable
            Mock Get-Executable { } -Verifiable

            $result = Get-InstallerFromZip @{ }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should BeNullOrEmpty
            }
        }
    }
}
#>