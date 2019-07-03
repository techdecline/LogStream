<#
    .SYNOPSIS
    Initializes a Log File.
    .DESCRIPTION
    Initializes a Log File. If already existing, switch allows to clear log or append.
    .EXAMPLE
    PS> Start-Log -LogFilePath $Env:Temp\ExampleLog.txt

    (Re-)Creates a Log File at $Env:Temp\ExampleLog.txt

    .EXAMPLE
    PS> Start-Log -LogFilePath $Env:Temp\ExampleLog.txt -Append

    Appends a Log File at $Env:Temp\ExampleLog.txt
#>
function Start-Log {
    [CmdletBinding()]
    param (
        # Log File Path
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$LogFilePath,

        # Append Switch
        [Parameter(Mandatory=$false)]
        [switch]$Append
    )
    process {
        Function Touch-File {
            $file = $args[0]
            if($file -eq $null) {
                throw "No filename supplied"
            }

            if(Test-Path $file)
            {
                (Get-ChildItem $file).LastWriteTime = Get-Date
            }
            else
            {
                try {
                    New-Item $file -Force
                }
                catch [System.Management.Automation.SetValueInvocationException] {
                    Throw "Write Access denied"
                }
            }
        }

        try {
            Touch-File $LogFilePath
        }
        catch [System.Management.Automation.SetValueInvocationException] {
            Throw "Write Access denied"
        }

        if (-not ($Append) -and (Get-Content $LogFilePath) -ne $null) {
            Clear-Content -Path $LogFilePath
        }

        Add-Content -Path $LogFilePath -Value "==================================================================================================="
        Add-Content -Path $LogFilePath -Value "Started processing at [$([DateTime]::Now)]"
        Add-Content -Path $LogFilePath -Value "==================================================================================================="
        Add-Content -Path $LogFilePath -Value ""

        return (Get-Item -Path $LogFilePath)
    }
}