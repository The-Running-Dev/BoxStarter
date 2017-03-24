$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

Describe "Find-Executable" {
    InModuleScope InstallHelpers {
        $env:ChocolateyPackageFolder = ''

        Context "When No RegEx or File is Provided" {
            It "Should Throw an Exception" {
                { Find-Executable } | Should throw
            }
        }
        Context "When the ChocolateyPackageFolder is Set" {
            $env:ChocolateyPackageFolder = Split-Path -Parent $global:module
            $fileName = 'InstallHelpers.psm1'
            $result = Find-Executable $fileName

            It "Should Find the File" {
                $result | Should Be $global:module
            }
        }
        Context "When the ChocolateyPackageFolder is Not Set" {
            $env:ChocolateyPackageFolder = ''
            $fileName = 'InstallHelpers.psm1'
            $result = Find-Executable $fileName

            It "Should Find the File" {
                $result | Should Be $global:module
            }
        }
        Context "When Single Filename is Provided" {
            $result = Find-Executable 'InstallHelpers.psm1'

            It "Should Find the File" {
                $result | Should Be $global:module
            }
        }
        Context "When a RegEx is Provided" {
            $result = Find-Executable -RegEx 'InstallHelpers\.psm1'

            It "Should Find the File" {
                $result | Should Be $global:module
            }
        }
        Context "When a RegEx is Provided and the ChocolateyPackageFolder is Set" {
            $env:ChocolateyPackageFolder = Split-Path -Parent $global:module
            $regEx = 'InstallHelpers\.ps'
            $result = Find-Executable $regEx

            It "Should Find the File" {
                $result | Should Be $global:module
            }
        }
        Context "When Multiple Files are Found" {
            $executableRegEx = 'Get'

            It "Should Throw an Exceptions" {
                { Find-Executable $executableRegEx } | Should throw
            }
        }
        Context "When No Files are Found" {
            It "Should Throw an Exception" {
                { Find-Executable '.obscure' } | Should throw
            }
        }
    }
}