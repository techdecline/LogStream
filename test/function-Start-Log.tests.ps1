$moduleName = "LogStream"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue

Import-Module "$PSScriptRoot\..\$moduleName.psd1"

# Mock functions
function TestFile ([String]$Path) {
    $file = 1 | Select-Object -Property @{Name = "LastWriteTime";Expression = {[datetime]::Now}},
                                        @{Name = "FullName";Expression = {$Path}}
    return $file
}

Describe "Start-Log Function Test" {
    Mock -CommandName New-Item -MockWith {
        TestFile -Path "C:\Temp\new.txt"
    }

    it "Start-Log should stop when Access denied" {

    }
    it "Should create new file when File does not exist" {
        $logFileObj = Start-Log -LogFilePath "C:\Temp\new.txt"
        $logFileObj.FullName | Should Be "C:\Temp\new.txt"
        Assert-MockCalled -CommandName New-Item -Scope It -Times 1
    }
}