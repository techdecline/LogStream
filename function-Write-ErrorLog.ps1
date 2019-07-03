<#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
#>
function Write-ErrorLog {
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
        Write-Log -LogFile $LogFilePath -CritLevel 2 -LogMessage $Message
    }
    else {
        Write-Error -Message $Message
    }
}