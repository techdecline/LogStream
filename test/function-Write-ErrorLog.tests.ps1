$moduleName = "LogStream"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue

Import-Module "$PSScriptRoot\..\$moduleName.psd1"

Describe "Write-ErrorLog Function Test" {

}