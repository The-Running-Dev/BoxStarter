$global:module = Join-Path $PSScriptRoot (Split-Path -Leaf $PSCommandPath).Replace(".Tests.ps1", ".psm1")

Import-Module $global:module

$global:mockedVolume = [pscustomobject] @{
    FileSystemLabel = 'FakeVolume'
    DriveLetter = 'Z'
}

Describe "Get-InstallerFromZip" {
    InModuleScope InstallHelpers {
        $fakeZip = 'C:\Path\Some.zip'
        $executableRegEx = 'Install.exe'
        $fakeUnzipLocation = 'C:\Path'
        $expected = 'C:\Path\Install.exe'

        Mock Find-Executable -mockwith { 'Install.exe' } -Verifiable
        Mock Get-ChocolateyUnzip { $fakeUnzipLocation } -Verifiable
        Mock Test-DirectoryExists { $true } -Verifiable
        Mock Test-FileExists { $true } -Verifiable

        Context "When the Unzip Location Exists" {
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
            Mock Install-ChocolateyZipPackage {}

            $result = Get-InstallerFromZip @{ 'file' = $fakeZip; 'unzipLocation' = $fakeUnzipLocation; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Unzipped File in the Temp Directory" {
                $result | Should Match "Temp\\"
            }
        }
        Context "When the Executable Does Not Exists" {
            Mock Test-FileExists { $false } -Verifiable
            Mock Install-ChocolateyZipPackage {}

            $result = Get-InstallerFromZip @{ 'url' = $fakeUrl; 'unzipLocation' = $fakeUnzipLocation; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should BeNullOrEmpty
            }
        }
    }
}

Describe "Get-InstallerFromIso" {
    InModuleScope InstallHelpers {
        $fakeIso = 'C:\Path\Some.iso'
        $executable = 'Install.exe'

        Mock Find-Executable -mockwith { 'Install.exe' } -Verifiable
        Mock Get-DiskImage -MockWith { [PSCustomObject] @{ DriveLetter = 'Z' } }
        Mock Get-Volume -mockwith { $global:mockedVolume } -Verifiable
        Mock Expand-WindowsImage -MockWith { }
        Mock Mount-DiskImage -MockWith { return [PSCustomObject] @{ ImagePath = $fakeIso } }
        Mock Dismount-DiskImage -MockWith { }

        Mock Test-FileExists { $true } -Verifiable

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
            Mock Test-FileExists { $false } -Verifiable
            $result = Get-InstallerFromIso @{ 'file' = $fakeIso; 'executable' = $executable }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should BeNullOrEmpty
            }
        }
        Context "When the Executable Does Not Exists" {
            Mock Test-FileExists { $false } -Verifiable

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

Describe "Get-Installer" {
    InModuleScope InstallHelpers {
        $fakeIso = 'C:\Path\Some.iso'
        $fakeUrl = 'http://some.place.com/file.zip'
        $fakeInstaller = 'C:\Path\Install.exe'
        $expectedFromIso = 'Z:\Install.exe'
        $expectedFromZip = 'C:\Path\Install.exe'

        Mock Get-FileExtension { 'exe' } -Verifiable
        Mock Test-FileExists { $true } -Verifiable

        Context "When the File Exists" {
            $result = Get-Installer @{ 'file' = $fakeInstaller}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the File" {
                $result | Should Be $fakeInstaller
            }
        }
        Context "When the File Does Not Exist" {
            Mock Test-FileExists { $false } -Verifiable
            $result = Get-Installer @{}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return Nothing" {
                $result | Should BeNullOrEmpty
            }
        }
        Context "When the File is a Zip" {
            Mock Get-FileExtension { '.zip' } -Verifiable
            Mock Get-InstallerFromZip { $expectedFromZip } -Verifiable

            $result = Get-Installer @{ 'file' = $fakeZip; 'executableRegEx' = $executableRegEx }

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to the Zip Installer" {
                $result | Should Be $expectedFromZip
            }
        }
        Context "When the File is a Zip but the Executable is Not EXE or MSI" {
            $fakeInstaller = 'C:\Path\Install.crap'
            $expectedFromZip = 'C:\Path\Install.crap'

            Mock Get-FileExtension { '.zip' } -Verifiable
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
            Mock Get-InstallerFromIso { $expectedFromIso } -Verifiable

            $result = Get-Installer @{'file' = $fakeIso; 'executableRegEx' = $executableRegEx}

            It "Should Call the Mocks" {
                Assert-VerifiableMocks
            }

            It "Should Return the Path to ISO Installer" {
                $result | Should Be $expectedFromIso
            }
        }
        Context "When an URL Exists" {
            Mock Test-FileExists { $false } -Verifiable
            Mock Install-ChocolateyZipPackage {}

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
            Mock Get-ChocolateyWebFile { $fakeInstaller }
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