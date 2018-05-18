Function Merge-ExcelSpreadSheets {
    <#
    .SYNOPSIS
    Given cells in a comma seperated string and a parent directory, grabs all Excel files, imports and then merges them
    
    .DESCRIPTION
     Given cells in a comma seperated string and a parent directory, grabs all Excel files, imports and then merges them
    
    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [String]$ParentDirectory,

        [Parameter(Mandatory)]
        [String]$CellRange
    )

    $CellCoordinates = Get-ExcelCellCoordinates $CellRange;

    if ($CellCoordinates.length -gt 0){
        try {
            if((Get-Item -Path $ParentDirectory).Mode -NotLike "d*"){
                Write-Error "Path is not a valid directory.";
            }
        }
        catch {
            throw $_;
        }

        $PSDrive = New-PSDrive -Name XLS -PSProvider FileSystem -Root $ParentDirectory -Confirm:$false

        Set-location XLS:\;
        $CSVPath = "$ENV:TEMP\$(New-Guid).csv";
        $ExcelSpreadSheets = Get-ChildItem -Recurse -Path .\* -Include "*.xls*";
        $CSV = @()
        
        foreach ($SpreadSheet in $ExcelSpreadSheets){
            $Data = import-excel -WorksheetName Result -NoHeader -Path $SpreadSheet.FullName;
            $Row = [Ordered]@{0 = $SpreadSheet.Fullname};
        
            for ($i = 0; $i -lt $CellCoordinates.length; $i++){
                $Row."$($i + 1)" = $Data[$CellCoordinates[$i][0]]."P$($CellCoordinates[$i][1]+1)";
            }
            $CSV += New-Object -TypeName pscustomobject -Property $row;
        }
        
        $csv | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 | Set-Content $CSVPath;

        Set-Location ~
        return $CSVPath;
    }
}