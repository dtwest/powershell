Function ConvertFrom-ExcelCellRange{
    <#
    .SYNOPSIS
    Converts a Cell range of format LETTERNUMBER:LETTERNUMBER to coordinates and returns cells
    
    .DESCRIPTION
    Converts a Cell range of format LETTERNUMBER:LETTERNUMBER to coordinates and returns cells.

    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    #>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline,Mandatory)]
        [ValidatePattern("([A-Za-z]+[0-9]+):([A-Za-z]+[0-9]+)")]
        $CellRange
    )

    process {
        $Cells = $CellRange.split(':');

        $Output = @();
        $Cells | ForEach-Object {
            $Output += , (ConvertFrom-ExcelCell $_);
        }

        return $Output;
    }
}