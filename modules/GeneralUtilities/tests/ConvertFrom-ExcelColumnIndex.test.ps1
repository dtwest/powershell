Describe "Convert-ExcelColumnIndex-to-integer_valid_Convert-ExcelColumnIndex" {
    . ../private/ConvertFrom-ExcelColumnIndex.ps1;

    It "Should return the correct index for the nth column" {
        ConvertFrom-ExcelColumnIndex A      | Should -be 0;
        ConvertFrom-ExcelColumnIndex B      | Should -be 1;
        ConvertFrom-ExcelColumnIndex AAA    | Should -be 702;
    }

    It "Should be case insensitive" {
        ConvertFrom-ExcelColumnIndex Aa     | Should -be 26;
        ConvertFrom-ExcelColumnIndex bA     | Should -be 52;
        ConvertFrom-ExcelColumnIndex baa    | Should -be 1378;
    }
}

Describe "Convert-ExcelColumnIndex-to-integer_invalid_Convert-ExcelColumnIndex" {
    . ../private/ConvertFrom-ExcelColumnIndex.ps1;

    It "Should through an exception if you enter an invalid column" {
        
        try{
            ConvertFrom-ExcelColumnIndex A3;
        }
        catch {
            $errorCategory = $_.categoryinfo.category 
        }

        $errorCategory | Should -Be "InvalidData"
    }
}