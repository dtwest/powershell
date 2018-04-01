Describe "Invoke-TernaryOperator-valid" {
    . ../public/Invoke-TernaryOperator.ps1
    
    it "Should return an array of processes from ?? `$true {Get-Proccess}" {
        $processes = ?? $true {Get-Process};

        $processes[0].gettype().name | Should -Be "Process";

        $processes = Invoke-TernaryOperator -Condition $true -IfTrue {Get-Process};
        
        $processes[0].gettype().name | Should -Be "Process";
    }

    it "Should return boolean true if ?? `$true OR boolean false if ?? `$false" {
        ?? $true | Should -Be $true;
        ?? $false | Should -Be $False;

        $(?? $true).gettype().name | Should -Be "Boolean"
        $(?? $false).gettype().name | Should -Be "Boolean"

        Invoke-TernaryOperator -Condition $true | Should -Be $true;
        Invoke-TernaryOperator -Condition $false | Should -Be $False;

        $(Invoke-TernaryOperator -Condition $true).gettype().name | Should -Be "Boolean"
        $(Invoke-TernaryOperator -Condition $false).gettype().name | Should -Be "Boolean"
    }
}