<#
    .SYNOPSIS
    Writes a message into Verbose stream and into a given log file.
    .DESCRIPTION
    Writes a message into Verbose stream and into a given log file.
    .EXAMPLE
    PS> Write-VerboseLog -LogFilePath -Message "This is a verbose message"
#>
function Write-VerboseLog {
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

    $VerbosePreference = "Continue"
    $Prefix = "[$([DateTime]::Now)] Info: "
    Add-Content -Path $LogFilePath -Value ($Prefix + $Message)
    Write-Verbose $Message -ErrorAction Continue
}