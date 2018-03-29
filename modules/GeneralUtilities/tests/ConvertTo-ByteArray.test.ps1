Describe "Convert-String-to-bytearray_valid_ConvertTo-ByteArray" {
    . ../public/ConvertTo-ByteArray.ps1;
    . ../public/ConvertFrom-ByteArray.ps1;

    It "Should return a byte array from the string 'ABCD' and when converted back be the same value" {
        $string = "ABCD";

        [Byte[]]$byteArray = ConvertTo-ByteArray $String;

        $byteArray.GetType().Name | Should -Be "Byte[]";
        ConvertFrom-ByteArray $byteArray | Should -Be $string;
    }
}

Describe "Convert-String-to-bytearray_invalid_ConvertTo-ByteArray" {
    . ../public/ConvertTo-ByteArray.ps1;

    It "Should Throw invalid data exception if input is not string or castable to a string." {
        try {
            $GCI = Get-ChildItem;

            ConvertTo-ByteArray $GCI;
        }
        catch {
            $ErrorCategory = $_.Categoryinfo.Category;
        }

        $ErrorCategory | Should -Be "InvalidData";
    }
}