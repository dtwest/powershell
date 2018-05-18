Function Get-ExcelCellCoordinates{
    <#
    .SYNOPSIS
    Returns Cell coordinates given a string with cells / cell ranges comma separated.
    
    .DESCRIPTION
    Given a string with cells and or rnages of cells, returns an array of coordinates for the cell in form [Int[]]
    
    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [String]$CellRange
    )

    $CellCoordinates = @();
    
    Foreach($i in $CellRange.Trim('').Split(',')){
        if ($i.IndexOf(':') -gt -1){
            $Cells = (Split $i "^[^:]*").Trim(':');
            $CellCoordinates+= Get-ExcelCellRange $Cells[0] $Cells[1]; # no , so results unroll
        }
        else {
            $CellCoordinates += , (ConvertFrom-ExcelCell $i);
        }
    }

    return $CellCoordinates;
}