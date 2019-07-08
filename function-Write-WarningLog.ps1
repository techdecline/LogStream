<#
    .SYNOPSIS
    Writes a message into Warning stream and into a given log file.
    .DESCRIPTION
    Writes a message into Warning stream and into a given log file.
    .EXAMPLE
    PS> Write-WarningLog -LogFilePath -Message "This is a warning"
#>
function Write-WarningLog {
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

    $Prefix = "[$([DateTime]::Now)] Warning: "
    Add-Content -Path $LogFilePath -Value ($Prefix + $Message)
    Write-Warning $Message -ErrorAction Continue
}