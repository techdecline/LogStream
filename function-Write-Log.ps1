Function Write-Log
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [String]$LogFile,

        [Parameter(Mandatory=$False)]
        [switch]$HiddenLogFile,

        [Parameter(Mandatory=$False)]
        [switch]$HiddenLogPath,

        [Parameter(Mandatory=$False)]
        [switch]$ClearLog,

        [Parameter(Mandatory=$False)]
        [ValidateRange(0,2)]
        [Int]$CritLevel,

        [Parameter(Mandatory=$False)]
        [switch]$Start,

        [Parameter(Mandatory=$False)]
        [switch]$Stop,

        [Parameter(Mandatory=$False)]
        [switch]$NewLine,

        [Parameter(Mandatory=$False)]
        [String]$LogMessage

    )

    $LogPath = Split-Path -Path $LogFile

    #Ordner ueberpruefen und ggf. anlegen
    if (!(Test-Path $LogPath))
    {
        if ($HiddenLogPath -eq $True)
        {
            New-Item $LogPath -type directory | ForEach-Object {$_.Attributes = "hidden"}
        }
        else
        {
            New-Item $LogPath -type directory | Out-Null
        }
    }

    #Logfile ueberpruefen und ggf. anlegen
    if (!(Test-Path $LogFile))
    {
        if ($HiddenLogFile -eq $True)
        {
            New-Item -Path $LogPath -Name (Split-Path -Path $LogFile -Leaf) -ItemType File | ForEach-Object {$_.Attributes = "hidden"}
        }
        else
        {
            New-Item -Path $LogPath -Name (Split-Path -Path $LogFile -Leaf) -ItemType File | Out-Null
        }
    }

    #Start Log
    If ($Start -eq $True)
    {
        If ($ClearLog -eq $True)
        {
            Clear-Content -Path $LogFile
        }
        Add-Content -Path $LogFile -Value "==================================================================================================="
        Add-Content -Path $LogFile -Value "Started processing at [$([DateTime]::Now)]"
        Add-Content -Path $LogFile -Value "==================================================================================================="
        Add-Content -Path $LogFile -Value ""
    }

    # Set critlevel prefix
    switch ($CritLevel)
    {
        0 {$Prefix = "[$([DateTime]::Now)] Info: "}
        1 {$Prefix = "[$([DateTime]::Now)] Warning: "}
        2 {$Prefix = "[$([DateTime]::Now)] Error: "}
        default {$Prefix = "[$([DateTime]::Now)] Info: "}
    }

    #LogMessage
    If ($LogMessage -ne "")
    {
        switch ($CritLevel) {
            0 { Write-Verbose $LogMessage }
            1 { Write-Warning $LogMessage }
            2 { Write-Error $LogMessage -ErrorAction Continue}
            Default {}
        }
        If ($env:USERNAME -eq "rollem") {Write-Host ($Prefix + $LogMessage)}
        Add-Content -Path $LogFile -Value ($Prefix + $LogMessage)
    }

    #NewLine
    If ($NewLine -eq $True)
    {
        If ($env:USERNAME -eq "rollem") {Write-Host ""}
        Add-Content -Path $LogFile -Value ""
    }

    #Stop Log
    If ($Stop -eq $True)
    {
        Add-Content -Path $LogFile -Value ""
        Add-Content -Path $LogFile -Value "==================================================================================================="
        Add-Content -Path $LogFile -Value "Finished processing at [$([DateTime]::Now)]"
        Add-Content -Path $LogFile -Value "==================================================================================================="
        Add-Content -Path $LogFile -Value ""
    }
}