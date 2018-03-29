# General Utilities

This module contains functions I use for day to day administration.

More functions will be added as I have time to remove company specific Functions and code. 

## Getting Started

You will need to ensure that you have Powershell and .NET Core 2 installed if you intend to run these on a non windows device, else make sure that you have the latest version of powershell installed on your system.

To run the Tests, you need to install pester (default installed with on powershell 5), and can run them by setting your location to the root directory of this module and executing:

```PowerShell
. ./Start-Tests.ps1
```

## Powershell Version Support

All of these functions are built to run on both Powershell 5 + targeting the full .net core and Powershell 6 + targeting .Net CORE 2.0 +
