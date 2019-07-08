<#
    .SYNOPSIS
    Writes a message into Warning stream and an error into a given log file.
    .DESCRIPTION
    Writes a message into Warning stream and an error into a given log file. This CMDlet should be used to document errors in a log, but not to suspend or stop script activity.
    .EXAMPLE
    PS> Write-ErrorLog -LogFilePath -Message "This is an error message"
#>
function Write-ErrorLog {
    [cmdletbinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [ValidateScript({
            if (-not (Test-Path $_)) {
                throw "You need to create a log file first using Start-Log"
            }
            else {
                return $true
            }
        })]
        [string]
        $LogFilePath,

        # Parameter help description
        [Parameter(Mandatory)]
        [string]
        $Message
    )

    $Prefix = "[$([DateTime]::Now)] Error: "
    Add-Content -Path $LogFilePath -Value ($Prefix + $Message)
    Write-Warning $Message -ErrorAction Continue
}