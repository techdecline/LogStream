$moduleName = "LogStream"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue

Import-Module "$PSScriptRoot\..\$moduleName.psd1"

Describe "Stop-Log Function Test" {

}