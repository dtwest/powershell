Describe "Test that Module imports successfully" {
    Set-Location ..

    It "Sould import psd1 without error" {
        Import-Module ./GeneralUtilities.psd1;
    }

    It "Should import psm1 without error" {
        Import-Module ./GeneralUtilities.psm1;
    }

    Set-Location ./tests
}