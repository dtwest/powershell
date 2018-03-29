Describe "Convert-bytearray-to-string_valid_ConvertFrom-ByteArray" {
    . ../public/ConvertTo-ByteArray.ps1;
    . ../public/ConvertFrom-ByteArray.ps1;

    It "Should return a byte array from the string 'ABCD' and when converted back be the same value" {
        $string = "ABCD";

        [Byte[]]$byteArray = ConvertTo-ByteArray $String;

        $byteArray.GetType().Name | Should -Be "Byte[]";
        ConvertFrom-ByteArray $byteArray | Should -Be $string;
    }
}