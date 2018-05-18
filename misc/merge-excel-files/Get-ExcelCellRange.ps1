Function Get-ExcelCellRange {
    <#
    .SYNOPSIS
    Given an X and Y cell value returns integer coordinates for every cell in that range.
    
    .DESCRIPTION
    Given an X and a Y, returns an array of every cell in that range.
    
    .PARAMETER X
    Start Cell
    
    .PARAMETER Y
    End Cell
    
    .EXAMPLE
    Get-ExcelCellRange A1 b1
    0
    0
    0
    1

    "$(Get-ExcelCellRange A1 b1)"
    System.Object[] System.Object[]

    .EXAMPLE
    Get-ExcelCellRange A1 b2
    0
    0
    0
    1
    1
    0
    1
    1

    "$(Get-ExcelCellRange A1 b2)"
    System.Object[] System.Object[] System.Object[] System.Object[]
    
    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $X,

        [Parameter(Mandatory)]
        $Y
    )

    $X = ConvertFrom-ExcelCell $X;
    $Y = ConvertFrom-ExcelCell $Y;

    # Do Range stuff.
    $Cells = @();
    foreach ($i in $X[0]..$Y[0]){
        foreach ($j in $X[1]..$Y[1]){
            $Cells += , @($i,$j);
        }
    }

    return $Cells;
}