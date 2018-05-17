Function ConvertFrom-ExcelColumnIndex{
    
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline,Mandatory)]
        [ValidatePattern("^[A-Z]+$")]
        [String]$Column
    )

    $result = [Int][Char]$Column[0] - 65;

    if ($Column.Length -gt 1)
    {
        $result = (++$result * [Math]::Pow(26,($Column.Length -1))) + (ConvertFrom-ExcelColumnIndex $Column.Substring(1));
    }

    return $result;
}