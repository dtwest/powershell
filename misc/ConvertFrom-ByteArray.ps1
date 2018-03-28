
    <#
        .SYNOPSIS
            Converts from a ByteArray to a string

        .DESCRIPTION
            Converts From a ByteArray to a string

        .INPUTS Byte[]

        .OUTPUTS String

        .NOTES
            Author : Dylan West
            Version: 1.0.0.0
            OriginalAuthor : Andy0708

        .LINKS
            https://stackoverflow.com/a/11654825
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [byte[]]$ByteArray
    )

    if ($ByteArray.Length -gt 0){
        [System.Text.Encoding]::UTF8.GetString($ByteArray, 0, $ByteArray.length);
    }

