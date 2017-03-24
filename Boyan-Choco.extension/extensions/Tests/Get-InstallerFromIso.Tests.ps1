$global:module = Join-Path $PSScriptRoot (Split-Path -Leaf $PSCommandPath).Replace(".Tests.ps1", ".psm1")

Import-Module $global:module

$global:mockedVolume = [pscustomobject] @{
    FileSystemLabel = 'FakeVolume'
    DriveLetter = 'Z'
}

Describe "Get-InstallerFromIso" {
    InModuleScope InstallHelpers {
        $fakeIso = 'C:\Path\Some.iso'
        $executable = 'Install.exe'

        Mock Find-Executable { 'Z:\Install.exe' } -Verifiable
        Mock Get-DiskImage { [PSCustomObject] @{ DriveLetter = 'Z' } }
        Mock Get-Volume { $global:mockedVolume } -Verifiable
        Mock Expand-WindowsImage {}
        Mock Mount-DiskImage { return [PSCustomObject] @{ ImagePath = $fakeIso } }
        Mock Dismount-DiskImage { }

        Context "When the File Exists" {
            $exepected = 'Z:\Install.exe'
            $result = Get-InstallerFromIso @{ 'file' = $fakeIso; 'executable' = $executable }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the File" {
                $result | Should Be $exepected
            }
        }
        Context "When the File Does Not Exists" {
            $result = Get-InstallerFromIso @{ 'file' = $fakeIso; 'executable' = $executable }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should BeNullOrEmpty
            }
        }
        Context "When the Executable Does Not Exists" {

            $result = Get-InstallerFromIso @{ 'file' = $fakeIso; 'executable' = $executable }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should BeNullOrEmpty
            }
        }
    }
}