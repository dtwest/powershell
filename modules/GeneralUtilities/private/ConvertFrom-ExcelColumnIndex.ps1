Function ConvertFrom-ExcelColumnIndex{
    <#
    .SYNOPSIS
    Converts Excel Column Index to an Integer for the column index. 
    
    .DESCRIPTION
    Converts Excel Column Index to an Integer for the column index.
    
    .PARAMETER Column
    A string that represents the column, e.g A or BA, etc.
    
    .EXAMPLE
    ConvertFrom-ExcelColumnIndex A
    0

    ConvertFrom-ExcelColumnIndex AA
    26

    ConvertFrom-ExcelColumnIndex AAA
    702

    ConvertFrom-ExcelColumnIndex BA
    52

    ConvertFrom-ExcelColumnIndex BAA
    1378
    
    .INPUTS 
    [System.String]

    .OUTPUTS
    [System.Int]

    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    #>
    

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline,Mandatory)]
        [ValidatePattern("^[A-Z]+$")]
        [String]$Column
    )

    $result = [Int][Char]$Column.ToUpper()[0] - 65;

    if ($Column.Length -gt 1)
    {
        $result = (++$result * [Math]::Pow(26,($Column.Length -1))) + (ConvertFrom-ExcelColumnIndex $Column.Substring(1));
    }

    return $result;
}