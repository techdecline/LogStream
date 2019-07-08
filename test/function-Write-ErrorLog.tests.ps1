$moduleName = "LogStream"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue

Import-Module "$PSScriptRoot\..\$moduleName.psd1"

InModuleScope -ModuleName $moduleName {
    Describe "Write-ErrorLog Parameter Validation" {
        # Mock
        Mock Test-Path -ParameterFilter {$Path -eq "C:\Notthere.txt"} -MockWith {return $false}

        # Test
        It "Should require an existing log file" {
            {Write-ErrorLog -LogFilePath "C:\Notthere.txt" -Message foobar} | should throw
            Assert-MockCalled -CommandName Test-Path -Times 1
        }
    }

    Describe "Write-ErrorLog Logic Validation" {
        # Mock
        $logArr = [System.Collections.ArrayList]@()
        Mock Add-Content -ParameterFilter {$Path -eq "C:\errorTest.txt"} -MockWith {$logArr.Add("errorTest")}
        Mock Get-Content -ParameterFilter {$Path -eq "C:\errorTest.txt"} -MockWith {$logArr}
        Mock -CommandName Test-Path -ParameterFilter {$Path -eq "C:\errorTest.txt"} -MockWith {return $true}

        It "Should write an error message into a file" {
            Write-ErrorLog -LogFilePath C:\errorTest.txt -Message errorTest
            Get-Content -Path "C:\errorTest.txt" | Where-Object {$_ -match "Error"} | should not be $null
            Assert-MockCalled -CommandName Add-Content -Times 1
            Assert-MockCalled -CommandName Get-Content -Times 1
        }
    }
}