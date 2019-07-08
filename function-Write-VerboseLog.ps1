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
        [Parameter(Mandatory=$false)]
        [string]
        $LogFilePath = $null,

        # Parameter help description
        [Parameter(Mandatory)]
        [string]
        $Message
    )

    if ($LogFilePath) {
        Write-Log -LogFile $LogFilePath -CritLevel 0 -LogMessage $Message
    }
    else {
        Write-Verbose -Message $Message
    }
}