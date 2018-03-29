Describe "Create-Valid-String_Get-CryptoRandomString" {
    . ../public/Get-CryptoRandomString.ps1

    It "Should return a string of 12 length where length parameter is set to 12" {
        $String = Get-CryptoRandomString -Length 12;

        $String.Length | Should -Be 12;
    }

    It "Should return a string of 5 length that contains only the characters ^ where length is 5 and Characters is '^'" {
        $String = Get-CryptoRandomString -Length 5 -Characters "^"

        $String | Should -Be "^^^^^"
    }
}

Describe "Create-Invalid-String_Get-CryptoRandomString" {
    . ../public/Get-CryptoRandomString.ps1

    It "Should throw a divide by zero exception if characters.length is less than 1" {
        try {
            Get-CryptoRandomString -Length 1 -Characters ""
        }
        catch {
            $_.Exception | Should  -BeLike "*Attempted to divide by zero.*"            
        }
    }
}