$moduleName = "LogStream"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue

Import-Module "$PSScriptRoot\..\$moduleName.psd1"

InModuleScope -ModuleName $moduleName {
    Describe "Write-VerboseLog Parameter Validation" {
        # Mock
        Mock Test-Path -ParameterFilter {$Path -eq "C:\Notthere.txt"} -MockWith {return $false}

        # Test
        It "Should require an existing log file" {
            {Write-ErrorLog -LogFilePath "C:\Notthere.txt" -Message foobar} | should throw
            Assert-MockCalled -CommandName Test-Path -Times 1
        }
    }

    Describe "Write-VerboseLog Logic Validation" {
        # Mock
        $logArr = [System.Collections.ArrayList]@()
        Mock Add-Content -ParameterFilter {$Path -eq "C:\VerboseTest.txt"} -MockWith {$logArr.Add("VerboseTest")}
        Mock Get-Content -ParameterFilter {$Path -eq "C:\VerboseTest.txt"} -MockWith {$logArr}
        Mock -CommandName Test-Path -ParameterFilter {$Path -eq "C:\VerboseTest.txt"} -MockWith {return $true}

        It "Should write a verbose message into a file" {
            Write-ErrorLog -LogFilePath C:\verboseTest.txt -Message verboseTest
            Get-Content -Path "C:\VerboseTest.txt" | Where-Object {$_ -match "Verbose"} | should not be $null
            Assert-MockCalled -CommandName Add-Content -Times 1
            Assert-MockCalled -CommandName Get-Content -Times 1
        }
    }
}