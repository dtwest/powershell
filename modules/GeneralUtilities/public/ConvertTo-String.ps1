Function ConvertTo-String {

	<#
	.SYNOPSIS
		Used to decrypt secure strings
	
	.DESCRIPTION
		Converts Secure String to BTSR then uses method ptrToStringAuto supplying the BSTR string, 
		this outputs the plaintext version of the secure string. 

    .INPUTS SecureString

    .OUTPUTS String

    .PARAMETER SecureString
        Is a SecureString, eg the output from the command New-Password is a secure string.

	.NOTES
		Author : Dylan West
		version: 1.0.0.0

    .EXAMPLE
        PS C:\Users\dywest>
        >>
        >> $b = @()
        >>
        >> foreach ($i in 1..10){
        >>     $b += new-password
        >> }
        >>
        >> $b
        >> $b | ConvertTo-String
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        System.Security.SecureString
        =#;A&v3J)4LRN[^^
        4%&Q-}6WvyV6;-;W
        /gy>er_]GwVD+4|V
        >DK)3aymp=-uwPXH
        9HZ]Lj=o_rrCx5J{
        ]vh..A(99/wZJWFa
        |67Qnw)>IgMn{Y0#
        D:xJPP$Wh9((R?eZ
        |:tXTL:wP93JE@$J
        r66k]J{H&ikb$JaF
	#>

	param (
	
		[Parameter(ValueFromPipeline,Mandatory)]
		[SecureString]$SecureString
	)

    process {

	    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString);
	    [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR);
    }
}