Function ConvertFrom-ExcelCell{
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline)]
        $Cell
    )

    process{
        $regex = "^[^0-9]*";
        
        $Cell = Split $Cell $regex;
        
        # Move the column to the actual column position.
        [Array]::Reverse($Cell); 
        
        # Get Numbers and stuff.
        $Cell[0] = [Int]$Cell[0] -1; #Cast to int and subtract 1 to get the correct value.
        $Cell[1] = ConvertFrom-ExcelColumnIndex $Cell[1]; # Get int pos value for the column.
    
        return $Cell;
    }
}