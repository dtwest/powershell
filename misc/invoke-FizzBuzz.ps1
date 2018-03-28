function Invoke-FizzBuzz {
    <#
    .SYNOPSIS
        Fizz Buzz

    .DESCRIPTION
        function to play Fizz Buzz for n iterations

    .EXAMPLE
        Invoke-FizzBuzz

    .NOTES
        Author : Dylan West
        Version: 1.0.0.0
    #>
    [cmdletbinding()]
    param(
        [Parameter(position=0,ValueFromPipeline)]
        [Int]$Iterations = 100
    )

    for ($i = 1; $i -le $Iterations; $i++){
        if (($i % 3 -eq 0) -and ($i % 5 -eq 0)){
            Write-Output "FizzBuzz";
        }
        elseif ($i % 3 -eq 0){
            Write-Output "Fizz";
        }
        elseif ($i % 5 -eq 0) {
            Write-Output "Buzz";
        }
        else {
            $i
        }
    }
}