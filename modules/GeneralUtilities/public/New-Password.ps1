function New-Password {
    <#
        .SYNOPSIS
            Used to generate a new password using System.Web.Security.Membership.GeneratePassword(length,numberOfNonAlphaCharacters)

        .DESCRIPTION
            Used to generate a new password using System.Web.Security.Membership.GeneratePassword(length,numberOfNonAlphaCharacters)

            Number of non alpha does not mean the max ammount, please see MSDN on the GeneratePassword Method.

        .PARAMETER Length
            The length of the password, a byte value between 1 and 128.

        .PARAMETER NumberOfNonAlpha
            The minimum number of NonAlpha characters in the password.

        .INPUTS 
            Int Length
            Int NumberOfNonAlpha

        .OUTPUTS
            SecureString Password.

        .NOTES
            Author : Dylan West
            Version: 1.1.0.0
            History: 
                Version 1.0.0.0 - Initial Commit
                Version 1.1.0.0 - Support for .Net Core;
    #>
    [CmdletBinding()]
    Param(
        [Parameter(position=0)]
        [ValidateRange(1,128)]
        [Int]$Length = 16,

        [Parameter(position=1)]
        [ValidateRange(1,128)]
        [Int]$NumberOfNonAlpha = 4
    )

    begin {
        $OldErrorActionPreference = $ErrorActionPreference;

        Try{

            Add-Type -AssemblyName System.Web;
        } 
        Catch {
            Write-Verbose "Unable to add System.Web, will Generate Password using fallback method.";
        }
    }

    process {

        if ($NumberOfNonAlpha -gt $length){
            throw [System.ArgumentOutOfRangeException]::new("Number of non alpha ($NumberOfNonAlpha) is greater than Password length ($length)");
        }
        
        try {
            ConvertTo-SecureString -String $([System.Web.Security.Membership]::GeneratePassword($length,$NumberOfNonAlpha)) -AsPlainText -Force;
        }
        Catch {

            Write-Verbose "Unable to generate the password using System.Web.Security.Membership.GeneratePassword(length,minNonAlpha), reverting to RNG";
            Write-Warning "Fell back to use RNG, disregardng minNonAlpha and using Get-CryptoRandomString -length $Length"

            Try {


                ConvertTo-SecureString -String $(Get-CryptoRandomString -length $Length) -AsPlainText -Force;
            }
            Catch {
                Throw $_
            }
        }
        Finally {
            $ErrorActionPreference = $OldErrorActionPreference;
        }
    }
}