Function Get-RandomString {
    <#
        .SYNOPSIS
            Generates a random string

        .DESCRIPTION
            Generates a random string using get-random

            Adapted from ed wilson random string solution, 
            this was previously trawling through char array grabbing random characters and joining them.
            Ed's solution was far more efficient and easier to read.

            PLEASE NOTE: 
                This is not Cryptographically Secure, this function is purely used by myself to:
                1. Test
                2. Troubleshoot
                3. Generate text files on the fly specifying how many non alpha characters there are for testing purposes.
            

        .INPUTS Int32

        .OUTPUTS String

        .PARAMETER Length
            Is the length that you want the random string to be.

        .PARAMETER MinNonAlpha
            Is the minimum number of non alpha numeric characters that you want to be present in your string.

        .PARAMETER MaxNonAlpha
            Is the maximum number of non alpha numeric characters that you want to be present in your string.

        .NOTES
            Author : Dylan West
            Version: 1.2.0.0
            OriginalAuthor : Ed Wilson
            History:
                1.0.0.0 - initial release
                1.1.0.0 - Modified to not violate the DRY principle
                1.2.0.0 - Added abbility to specify the min-max number of non alpha characters.

        .LINK
            https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/05/generate-random-letters-with-powershell/

    #>
    [CmdletBinding()]
    Param(
        [Parameter(Position=0)]
        [Int]$Length,

        [Parameter(Position = 1)]
        [Int]$MinNonAlpha,

        [Parameter(Position = 3)]
        [Int]$MaxNonAlpha
    )

    if ($MinNonAlpha -gt $Length){
        throw [System.ArgumentOutOfRangeException]::new("Number of non alpha ($($PSBoundParameters['MinNonAlpha'])) is greater than length ($($PSBoundParameters['length'])))");
    } 
    elseif ($PSBoundParameters['MinNonAlpha'] -gt $PSBoundParameters['MaxNonAlpha'] -and $PSBoundParameters['MaxNonAlpha']) {
        throw [System.ArgumentOutOfRangeException]::new("NonAlpha min ($($PSBoundParameters['MinNonAlpha'])) is greater than max ($($PSBoundParameters['MaxNonAlpha']))");        
    }

    if ($PSBoundParameters['length'] -gt 0){

        #Get Character Set Ranges (entire is 32..126 or nonA + A)
        [Int[]]$AlphaCharacterSet = (65..90) + (97..122) + (48..57);
        [Int[]]$NonAlphaCharacterSet = (32..47) + (58..64) + (91..96) + (123..126);

        $string = @(); #creating as an array, we'll join the array at the end.

        # If min non A set, get that number and put into the array string @()
        if ($PSBoundParameters['MinNonAlpha'] -gt 0){
            While ($string.Length -lt $PSBoundParameters['MinNonAlpha']){
                $string += $NonAlphaCharacterSet | 
                    Get-Random -Count $($PSBoundParameters['MinNonAlpha'] - $String.Length) |
                        ForEach-Object {[Char]$_}
            }
        } 

        #if Max non A set, fill up the array string with nonalpha characters until that number is met, then fill it with alphanumeric characters until it is of length $length
        # else just fill the array to length with alpha and non alpha characters
        if ($PSBoundParameters['MaxNonAlpha'] -ge 0){
            While ($string.length -gt $PSBoundParameters['MaxNonAlpha']){
                $string += $NonAlphaCharacterSet |
                    Get-Random -Count $($PSBoundParameters['MaxNonAlpha'] - $string.length) |
                        ForEach-Object {[Char]$_}
            }
            while ($string.Length -lt $PSBoundParameters['length']){
                $string += $AlphaCharacterSet | 
                    Get-Random -Count $($PSBoundParameters['length'] - $string.length) |
                        ForEach-Object {[Char]$_}
            }
        }
        else {
            while ($string.Length -lt $PSBoundParameters['length']){
                $string += $AlphaCharacterSet + $NonAlphaCharacterSet | 
                    Get-Random -Count $($PSBoundParameters['length'] - $string.length) |
                        ForEach-Object {[Char]$_}
            }
        }

        # We do this as if you specified a min number of non alpha we will need to randomise the set 
        # (non alpha will all be at the front otherwise) again and join the characters.
        return -join (Get-Random $string -Count $string.length);
    }
    else {
        return ""
    }
}