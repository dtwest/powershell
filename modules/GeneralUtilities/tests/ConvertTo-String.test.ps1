Describe "Convert-SecureString-to-string_ConvertTo-String" {
    . ../public/ConvertTo-String.ps1;

    It "Should Return a plaintext string converted from a secure.string" {
        $string  = "This is a Test";

        $SecureString = ConvertTo-SecureString -String $string -AsPlainText -Force;

        ConvertTo-String $SecureString | Should -Be $string;
    }
}

Describe "Convert-String-to-String_ConvertTo-String" {
    . ../public/ConvertTo-String.ps1;

    It "Should throw InvalidData exception when variable other than a secure string inputed" {
        try {
            ConvertTo-String "TESTING";
        }
        catch {
            $ErrorCategory = $_.Categoryinfo.Category;
        }

        $ErrorCategory | Should -Be "InvalidData";
    }
}
