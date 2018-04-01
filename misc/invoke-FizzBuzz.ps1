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
        [Int]$Iterations = 15
    )

    1..$iterations | 
    Foreach-Object {
        if (($_ % 3 -eq 0) -and ($_ % 5 -eq 0)){
            Write-Output "FizzBuzz";
        }
        elseif ($_ % 3 -eq 0){
            Write-Output "Fizz";
        }
        elseif ($_ % 5 -eq 0) {
            Write-Output "Buzz";
        }
        else {
            $_
        } 
    }

    # Alternate implementaion 1 (using teneray (false, true)[predicate])

    # 1..$Iterations | 
    #     ForEach-Object {
    #         ((($_, "Buzz")[($_ % 5 -eq 0)],"Fizz")[($_ % 3 -eq 0)],"FizzBuzz")[($_ % 3 -eq 0 -and $i % 5 -eq 0)]
    #     }

    # Alternate implementation 2

    # for ($i = 1; $i -le $Iterations; $i++){
    #     if (($i % 3 -eq 0) -and ($i % 5 -eq 0)){
    #         Write-Output "FizzBuzz";
    #     }
    #     elseif ($i % 3 -eq 0){
    #         Write-Output "Fizz";
    #     }
    #     elseif ($i % 5 -eq 0) {
    #         Write-Output "Buzz";
    #     }
    #     else {
    #         $i
    #     }
    # }

    # Alternate implementation 3 using invoke-ternaryoperator (??)

    # 1 ..$iterations | 
    #     % {
    #         ?? ($_ % 3 -eq 0 -and $_ % 5 -eq 0) {"FizzBuzz"} {
    #             ?? ($_ % 3 -eq 0) {"Fizz"} {
    #                 ?? ($_ % 5 -eq 0) {"Buzz"} {$_}
    #             }
    #         }
    #     }
}