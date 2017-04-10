$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

$global:mockedVolume = [pscustomobject] @{
    FileSystemLabel = 'FakeVolume'
    DriveLetter = 'Z'
}

Describe "Install-CustomPackage" {
    InModuleScope InstallHelpers {
        function Install-ChocolateyInstallPackage { }

        $fakeInstaller = 'C:\Path\Install.exe'
        $expected = 'C:\Path\Install.exe'

        Mock Get-Installer { $fakeInstaller }
        Mock Test-FileExists { $true }
        Mock Cleanup {}

        Context "When the File Exists" {
            $r = Install-CustomPackage @{'file' = $fakeInstaller; 'packageName' = 'fake' }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Not Throw an Exception" {
                { $r } | Should Not Throw
            }
        }
        Context "When the File Does Not Exists" {
            Mock Test-FileExists { $false }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Throw an Exception" {
                { Install-CustomPackage } | Should Throw
            }
        }
    }
}