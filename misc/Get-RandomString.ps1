﻿Function Get-RandomString {
    <#
        .SYNOPSIS
            Generates a random string

        .DESCRIPTION
            Generates a random string using get-random

            Adapted from ed wilson random string solution, 
            this was previously trawling through char array grabbing random characters and joining them.
            Ed's solution was far more efficient and easier to read.

        .INPUTS Int32

        .OUTPUTS String

        .NOTES
            Author : Dylan West
            Version: 1.0.0.0
            OriginalAuthor : Ed Wilson

        .LINK
            https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/05/generate-random-letters-with-powershell/

    #>
    [CmdletBinding()]
    Param(
        [Parameter(Position=0)]
        [Int32]$Length
    )

    if ($length -gt 0 -and $Length -le 62){

        -Join ((65..90) + (97..122) + (48..57) | 
            Get-Random -Count $length |
                ForEach-Object {[Char]$_})
    }
    elseif ($length -gt 62){
        $string = ""
        while ($string.Length -lt $Length){
            $string += -Join ((65..90) + (97..122) + (48..57) | 
                Get-Random -Count $($length - $string.length) |
                    ForEach-Object {[Char]$_})
        }

        return $String
    }
    else {
        return ""
    }
}