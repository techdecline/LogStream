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