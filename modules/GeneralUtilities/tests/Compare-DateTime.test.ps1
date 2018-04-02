Describe "Compare-Valid-DateTimes_Compare-DateTime" {
    . ../public/Compare-DateTime.ps1
    it "Should Return an object with total years - total milliseconds" {
        $a = Compare-DateTime -StartDate $(Get-Date 1/1/2016) -EndDate $(Get-Date 1/1/2017);

        $a.TotalWeeks

        $a.TotalYears           | Should -Be 1;
        $a.TotalCalendarMonths  | Should -Be 12;
        [int32]$a.TotalWeeks    | Should -Be 52;
        $a.TotalDays            | Should -Be 366;
        $a.TotalHours           | Should -Be 8784;
        $a.TotalMinutes         | Should -Be 527040;
        $a.TotalSeconds         | Should -Be 31622400;
        $a.TotalMilliseconds    | Should -Be 31622400000;
    }
} 