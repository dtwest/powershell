Describe "Create-Valid-String_Get-RandomString" {
    . ../public/Get-RandomString.ps1;
    [Int[]]$AlphaCharacterSet = (65..90) + (97..122) + (48..57);
    [Int[]]$NonAlphaCharacterSet = (32..47) + (58..64) + (91..96) + (123..126);

    It "Should return a random string of length 10 when length param is 10"{

        $String = Get-RandomString -length 10;

        $String.length | Should -Be 10;
    }

    It "Should return a random string with at least 3 nonAlpha Characters when minNonAlpha is 3" {
        $string = Get-RandomString -length 10 -MinNonAlpha 3;

        [int]$nonAlpha = 0;
        
        for ($i = 0; $i -lt $string.length; $i ++){
            if ($NonAlphaCharacterSet -contains [int][char]$string[$i]) {
                $nonAlpha++
            }
        }

        $nonAlpha | Should -BeGreaterOrEqual 3;
    }

    It "Should Return a random string with a maximum of 5 non alpha characters when maxNonAlpha is 5" {
        $string = Get-RandomString -length 128 -MaxNonAlpha 5;
    
        [int]$nonAlpha = 0;
        
        for ($i = 0; $i -lt $string.length; $i ++){
            if ($NonAlphaCharacterSet -contains [int][char]$string[$i]) {
                $nonAlpha++
            }
        }

        $nonAlpha | Should -BeLessOrEqual 5;
    }

    It "Should return a random string with 10 non alpha characters when both min and max non alpha are 10" {
        $string = Get-RandomString -length 10 -MaxNonAlpha 10 -MinNonAlpha 10;
        
            [int]$nonAlpha = 0;
            
            for ($i = 0; $i -lt $string.length; $i ++){
                if ($NonAlphaCharacterSet -contains [int][char]$string[$i]) {
                    $nonAlpha++
                }
            }
    
            $nonAlpha | Should -Be 10
    }
}

Describe "Create-Invalid-String_Get-RandomString" {
    . ../public/Get-RandomString.ps1;

    It "Should throw an arguement out of range exception when Min is Greated than Max nonAlpha" {
        try {
            Get-RandomString -length 10 -MinNonAlpha 2 -MaxNonAlpha 1
        }
        catch {
            $errorReason = $_.CategoryInfo.Reason 
        }

        $errorReason | Should -Be "ArgumentOutOfRangeException"

    }

    It "Should throw an arguement out of range exception when min non alpha is greater than length" {
        try {
            Get-RandomString -length 10 -MinNonAlpha 24
        }
        catch {
            $errorReason = $_.CategoryInfo.Reason 
        }

        $errorReason | Should -Be "ArgumentOutOfRangeException"
    }
}