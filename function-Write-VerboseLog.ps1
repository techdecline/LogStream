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