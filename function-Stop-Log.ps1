<#
    .SYNOPSIS
    Stops a log file.
    .DESCRIPTION
    Stops a log file and appends a closing statement.
    .EXAMPLE
    PS> Stop-Log -LogFilePath $Env:Temp\ExampleLog.txt

    Ends a log file
#>
function Stop-Log {
    [CmdletBinding()]
    param (
        # Log File Path
        [Parameter(Mandatory)]
        [ValidateScript({Test-Path $_})]
        [string]$LogFilePath
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
                echo $null > $file
            }
        }

        Function Get-LastStart {
            $file = $args[0]
            if (Test-Path $file) {
                $arr = Get-Content $file

                if ($arr) {
                    [array]::Reverse($arr)
                    $lastStart =$arr | Where-Object {$_ -match "^Started processing.*"} | Select-Object -First 1
                    if ($lastStart) {
                        $r = [regex] "\[([^\[]*)\]"
                        $match = $r.match("$lastStart")
                        if ($match) {
                            $date = $match.groups[1].value
                            return ([datetime]::parseexact($date, 'MM/dd/yyyy HH:mm:ss', $null))
                        }
                        else {
                            return $null
                        }
                    }
                }
            }
            else {
                return $null
            }
        }

        try {
            Touch-File $LogFilePath
        }
        catch [System.Management.Automation.SetValueInvocationException] {
            Throw "Write Access denied"
        }

        Add-Content -Path $LogFilePath -Value ""
        Add-Content -Path $LogFilePath -Value "==================================================================================================="
        Add-Content -Path $LogFilePath -Value "Finished processing at [$([DateTime]::Now)]"
        $lastStart = Get-LastStart $LogFilePath
        if ($lastStart) {
            $runTime = New-TimeSpan -Start $lastStart -End $([DateTime]::Now)
            Add-Content -Path $LogFilePath -Value "Runtime in Seconds: $($runTime.TotalSeconds)"
        }
        Add-Content -Path $LogFilePath -Value "==================================================================================================="
        Add-Content -Path $LogFilePath -Value ""

        return $true
    }
}