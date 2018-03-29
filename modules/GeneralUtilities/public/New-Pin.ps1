Function New-Pin {

    <#
    .SYNOPSIS
        Used to generate a Pin of X length from number range 0 - 9

    .DESCRIPTION
        Used to generate a pin of X Length from number range 0 - 9

        Takes the Pin Length Variable desclared as a parameter and then generates a pin from 4 - 2048 digits in length

    .INPUTS Int32

    .OUTPUTS Int32

    .PARAMETER Length
        The desired length of the pin. defaults to 4.

    .NOTES
        Author : Dylan West
        Version: 1.0.0.0

    
    #>

    [cmdletbinding()]
    param(
    
        [Parameter(ValueFromPipeline)]
        [ValidateRange(4,2048)]
        [Int]$Length = 4
    
    )

    Begin{
    
    
        $NumberRange = 0..9
    
    
    }

    Process {
    
        $Pin = ""

        For ($i = 0; $i -lt $Length; $i++){
        
            $Pin = $Pin + $(Get-Random $NumberRange)
        
        }

        $Pin
        $Pin = $null
    
    }
}