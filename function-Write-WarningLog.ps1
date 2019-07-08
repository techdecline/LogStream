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
        [Parameter(Mandatory=$false)]
        [string]
        $LogFilePath = $null,

        # Parameter help description
        [Parameter(Mandatory)]
        [string]
        $Message
    )

    if ($LogFilePath) {
        Write-Log -LogFile $LogFilePath -CritLevel 1 -LogMessage $Message
    }
    else {
        Write-Warning -Message $Message
    }
}