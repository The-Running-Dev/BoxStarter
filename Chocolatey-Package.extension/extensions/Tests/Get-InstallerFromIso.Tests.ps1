<#
$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

$global:mockedVolume = [pscustomobject] @{
    FileSystemLabel = 'FakeVolume'
    DriveLetter = 'Z'
}

Describe "Get-InstallerFromIso" {
    InModuleScope InstallHelpers {
        Mock Get-Executable { 'Z:\Install.exe' } -Verifiable
        Mock Get-DiskImage { [PSCustomObject] @{ DriveLetter = 'Z' } }

        function Get-Volume {
            Param
            (
                [CmdletBinding()][Parameter(ValueFromPipeline)] $partition,
                [String] $driveLetter
            )
        }

        $fakeIso = 'C:\Path\Some.iso'
        $fakeExecutable = 'Install.exe'
        $fakeInstaller = 'Z:\Install.exe'

        Context "When the File Exists" {
            $result = Get-InstallerFromIso @{ 'file' = $fakeIso; 'executable' = $fakeExecutable }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the File" {
                $result | Should Be $fakeInstaller
            }
        }
        Context "When the File Does Not Exists" {
            Mock Get-Executable { } -Verifiable
            $result = Get-InstallerFromIso @{ 'file' = $fakeIso; 'executable' = $fakeExecutable }

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