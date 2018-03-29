Function Get-CryptoRandomString {
    <#
        .SYNOPSIS
            Generates a random string

        .DESCRIPTION
            Generates a random string using [System.Security.Cryptography.RandomNumberGenerator]

            PLEASE NOTE: 
                This creates a cryptographically secure pseudo random string and is used as a fallback for 
                System.Web.Security.GeneratePassword(length, minNonAlpha) on .NET CORE.
            

        .INPUTS Int32

        .OUTPUTS String

        .PARAMETER Length
            Is the length that you want the random string to be.

        .PARAMETER Characters
            A string with all the accepted characters you want in your string.

        .NOTES
            Author : Dylan West
            Version: 1.0.0.0
            History:
                1.0.0.0 - initial release

    #>
    [CmdletBinding()]
    Param(
        [Parameter(Position=0)]
        [Int]$Length,

        [Parameter(Position = 1)]
        [string]$Characters = " !`"#$%&'()*+,-./:;<=>?@[\]^_``{|}~ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"     
    )

    try {
        if ($PSBoundParameters['length'] -gt 0){

            $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create();
            $bytes = [Byte[]]::new($Length);
            $rng.GetBytes($bytes);
            [Char[]]$charArray = @();

            for ($i = 0; $i -lt $Length; $i++){
                $charArray += $Characters[[Int]$bytes[$i] % $Characters.Length];
            }

            return [String]::new($charArray);
        }
        else {
            return ""
        }
    }
    Finally{
        $rng.Dispose();
    }
}