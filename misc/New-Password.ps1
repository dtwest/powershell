function New-Password {
    <#
        .SYNOPSIS
            Used to generate a new password using System.Web.Security.Membership.GeneratePassword(length,numberOfNonAlphaCharacters)

        .DESCRIPTION
            Used to generate a new password using System.Web.Security.Membership.GeneratePassword(length,numberOfNonAlphaCharacters)

            Number of non alpha does not mean the max ammount, please see MSDN on the GeneratePassword Method.

        .INPUTS 
            Byte Length
            Byte NumberOfNonAlpha

        .OUTPUTS
            SecureString Password.

        .NOTES
            Author : Dylan West
            Version: 1.0.0.0
    #>
    [CmdletBinding()]
    Param(
        [Parameter(position=0)]
        [ValidateRange(1,128)]
        [byte]$Length = 16,

        [Parameter(position=1)]
        [ValidateRange(1,128)]
        [byte]$NumberOfNonAlpha = 4
    )

    if ($NumberOfNonAlpha -gt $length)
    {
        throw [System.ArgumentOutOfRangeException]::new("Number of non alpha ($NumberOfNonAlpha) is greater than Password length ($length)");
    }

    ConvertTo-SecureString -String $([System.Web.Security.Membership]::GeneratePassword($length,$NumberOfNonAlpha)) -AsPlainText -Force;

}