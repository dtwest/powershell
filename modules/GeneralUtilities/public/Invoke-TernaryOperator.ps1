Set-Alias -Name "??" -Value "Invoke-TernaryOperator"
Function Invoke-TernaryOperator {
    <#
    .SYNOPSIS
        Adds a ternary operator to powershell

    .DESCRIPTION
        Adds a ternary operator to powershell, the alias ?? ( | This-function) is set by my general utilities module 

    .EXAMPLE
    Invoke-TernaryOperator (condition) {if true this script block} {else this script block}

    .EXAMPLE
    ?? ($predicate) {"true"} {"false"}

    .EXAMPLE
    PS C:\Users\Dtwest> $processes = ?? $true {get-process} {}
    PS C:\Users\Dtwest> $processes | select -first 5

    Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
    -------  ------    -----      -----     ------     --  -- -----------
        150      11     2892       8120              4404   0 aaHMSvc
        157      12     2340       7720       0.05  10472   1 adb
        521      27     5776       2504       1.41   9984   1 AdobeARM
        227      20     3520      13316              4432   0 AppleMobileDeviceService
        352      27     4824      17088       0.11  13948   1 APSDaemon


    PS C:\Users\Dtwest>

    .EXAMPLE
    PS C:\Users\Dtwest> $iterations = 15
    PS C:\Users\Dtwest> 1 ..$iterations | 
    % {
        ?? ($_ % 3 -eq 0 -and $_ % 5 -eq 0) {"FizzBuzz"} {
            ?? ($_ % 3 -eq 0) {"Fizz"} {
                ?? ($_ % 5 -eq 0) {"Buzz"} {$_}
            }
        }
    }
    
    1
    2
    Fizz
    4
    Buzz
    Fizz
    7
    8
    Fizz
    Buzz
    11
    Fizz
    13
    14
    FizzBuzz

    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    Original Author : NightRoman

    .LINK
        https://github.com/nightroman/PowerShellTraps/blob/master/Basic/Missing-ternary-operator/Test-3-part-of-expression.ps1
    #>

    [cmdletbinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [bool]
        $Condition = $true,

        [Parameter()]
        [scriptblock]
        $IfTrue = {return $True},

        [Parameter()]
        [scriptblock]
        $IfFalse = {return $False}
    )

    ( (& $IfFalse), (& $IfTrue))[$Condition];
}