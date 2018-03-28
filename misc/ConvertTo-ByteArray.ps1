Function ConvertTo-ByteArray{
    <#
        .SYNOPSIS
            Converts a string to a ByteArray

        .DESCRIPTION
            Converts a String to a ByteArray

        .INPUTS String

        .OUTPUTS Byte[]

        .NOTES
            Author : Dylan West
            Version: 1.0.0.0
            OriginalAuthor : Andy0708

        .LINKS
            https://stackoverflow.com/a/11654825
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position=0,ValueFromPipeline)]
        [string]$String
    )
    
    Process {
        if (![String]::IsNullOrWhiteSpace($String))
        {
            [System.Text.Encoding]::UTF8.GetBytes($String);
        }
        else {
            [Byte[]]::new(0) # return empty byte array
        }
    }
}
