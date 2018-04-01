Describe "Convert-Valid-DateString_Convert-DateString" {
    . ../public/Convert-DateString.ps1;

    It "Should Return a valid Date time string from 2018-03-29 and the format yyyy-MM-dd" {
        $(Convert-DateString 2018-03-29 -format yyyy-MM-dd).ToString() | should -Be  ("3/29/18 12:00:00 AM" -or "29/3/18 12:00:00 AM")
    }

    It "Should return a valid date time string from 2016100013030 yyyyMMddHHmmss" {
        $(Convert-DateString -date 20161010013030 -format yyyyMMddHHmmss).ToString() | Should -Be "10/10/16 1:30:30 AM";
    }
}