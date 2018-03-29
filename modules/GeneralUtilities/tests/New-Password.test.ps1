Describe "Create-Valid-Password_New-Password" {
    it "Should return a securestring" {
        . ../public/New-Password.ps1
        . ../public/Get-CryptoRandomString.ps1;

        $password = New-Password -length 16;

        $password.GetType().Name | Should -Be "SecureString";
    }
}

Describe "Create-InValid-Password_New-Password" {
    It "Should throw an error when password length is less than 1" {
        try {
            . ../public/New-Password.ps1
            . ../public/Get-CryptoRandomString.ps1;
    
            New-Password -length 0;
        }
        catch {
            $errorCategory = $_.categoryinfo.category 
        }
    
        $errorCategory | Should -Be "InvalidData"
    }

    It "Should throw an error when the passowrd length is greater than 128" {
        try {
            . ../public/New-Password.ps1
            . ../public/Get-CryptoRandomString.ps1;
    
            New-Password -length 129;
        }
        catch {
            $errorCategory = $_.categoryinfo.category 
        }
    
        $errorCategory | Should -Be "InvalidData"
    }

    It "Should throw an error when the password length is less than the min number of non alpha" {
        try {
            . ../public/New-Password.ps1
            . ../public/Get-CryptoRandomString.ps1;
    
            New-Password -length 16 -NumberOfNonAlpha 18;
        }
        catch {
            $errorReason = $_.CategoryInfo.Reason 
        }

        $errorReason | Should -Be "ArgumentOutOfRangeException"
    }
}