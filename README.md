# LogStream
PowerShell Module to combine File-based and Command Line-based logging

## Description
This module is meant to be used as way to standardize Log File creation from PowerShell scripts as well as provide 
reasonable logging to the command line. By writing both to the output stream and to file with added datetime information,
logging is consistent.

## How to use this module
After importing the module you can use five commands:

Command | Description
--------|------------
Start-Log | Initialize Logging providing a file path. Use -Append to append existing log files.
Stop-Log | Finialize Logging providing a file path.
Write-VerboseLog | Add an information kind of message to a given log file and show the message to the output stream.
Write-WarningLog | Add a warning mesage to a given log file and show the warning to the output stream. 
Write-ErrorLog | Add an error message to a given log file and throw a non-terminating error on the output stream.

## How to get the module
You can either download the files on your own from this repository or take a look in the [PowerShell Gallery](https://www.powershellgallery.com/packages/LogStream).

## How to contribute
You can both open issues or fork this repository in order to make changes to the project.
