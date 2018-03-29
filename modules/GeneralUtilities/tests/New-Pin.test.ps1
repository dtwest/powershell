Describe "Create-Valid-Pin_New-Pin" {
    it "Should Return an integer of length 16 when length is 16" {
        . ../public/New-Pin.ps1;

        $pin = New-Pin -Length 16;

        $pin.length | Should -Be 16;
    }

    It "should return an integer of length 4 when length is not specified" {
        . ../public/New-Pin.ps1;

        $pin = New-Pin;

        $pin.length | Should -Be 4;
    }
}

Describe "Create-Invalid-Pin_New-Pin" {
    It "Should throw an error when pin length is less than 4" {
        try {
            . ../public/New-Pin.ps1;

            New-Pin -Length 1
        }
        catch {
            $errorCategory = $_.categoryinfo.category 
        }

        $errorCategory | Should -Be "InvalidData"
    }

    It "Should throw an error when pin length is greater than 2048" {
        try {
            . ../public/New-Pin.ps1;

            New-Pin -Length 2049
        }
        catch {
            $errorCategory = $_.categoryinfo.category 
        }

        $errorCategory | Should -Be "InvalidData"
    }
}