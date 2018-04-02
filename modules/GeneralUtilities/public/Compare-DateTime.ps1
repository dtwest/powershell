
Function Compare-DateTime {
    <#
    .SYNOPSIS
        Used to get the date difference between the reference dattime object and the differnect date time object.

    .DESCRIPTION
        I had to create this when we were doing wanna cry validations and I needed to work out rough estimations of time frames.

        That was a fun weekend.

    .notes
        Author : Dylan West
        Version: 1.1.0.0

    .EXAMPLE
        PS C:\Users\dtwest> Compare-DateTime -StartDate $(Get-Date 1/1/2014) -EndDate $(Get-Date 1/1/2015)


        TotalYears          : 1
        TotalCalendarMonths : 12
        TotalWeeks          : 52.1428571428571
        TotalDays           : 365
        TotalHours          : 8760
        TotalMinutes        : 525600
        TotalSeconds        : 31536000
        TotalMilliseconds   : 31536000000



        PS C:\Users\dtwest> Compare-DateTime -StartDate $(Get-Date 1/1/2016) -EndDate $(Get-Date 1/1/2017)


        TotalYears          : 1
        TotalCalendarMonths : 12
        TotalWeeks          : 52.2857142857143
        TotalDays           : 366
        TotalHours          : 8784
        TotalMinutes        : 527040
        TotalSeconds        : 31622400
        TotalMilliseconds   : 31622400000



        PS C:\Users\dtwest> Compare-DateTime -StartDate $(Get-Date 1/1/2016) -EndDate $(Get-Date)


        TotalYears          : 1.46793235173492
        TotalCalendarMonths : 17.615188220819
        TotalWeeks          : 76.4936638035101
        TotalDays           : 535.455646624571
        TotalHours          : 12850.9355189897
        TotalMinutes        : 771056.131139382
        TotalSeconds        : 46263367.8683629
        TotalMilliseconds   : 46263367868.3629
    
    #>

    [CmdletBinding()]
    param(

        [parameter(position=0,Mandatory,HelpMessage="The Start DateTime Object")]
        [DateTime]$StartDate,

        [parameter(position=0,Mandatory,HelpMessage="The End DateTime Object")]
        [DateTime]$EndDate

    )

    Begin{
    
        IF ($StartDate -Gt $EndDate){
        
            Write-Error -Exception "Invalid Date Range" -Message "The Date range specifed is invalid as the StartDate is greater than the EndDate."
            Break
        
        }    
    }

    Process {
    
        Write-Verbose "Creating Year Range and getting total number of months in the range EndMonth..StartMonth + 12*Years inbetween"

        #Range of Years from Start to end
        $YearRange = $StartDate.Year..$EndDate.Year
        
        #Working out Months Total.
        $Months = 0
        IF ($YearRange.Count -gt 1){
        
            $Months += $($StartDate.Month..12).Count #Add Start years Months
            $Months += $(1..$EndDate.Month).Count #Add End Years Months.

            $Months += $($YearRange.Count - 2) * 12 #- 2 for the start year and end year, if there are only 2 years, then we don't want to add months for years in between, hence the - 2.
        
        }
        ELSEIF ($YearRange.Count -eq 1){
        
            $Months += $($startdate.Month..$EndDate.Month).count
        
        }
                    
        $Months += $($(New-TimeSpan -Days $([datetime]::DaysInMonth($StartDate.Year,$StartDate.Month))) - $($(New-TimeSpan -Days  $($StartDate.Day - 1)) + $StartDate.timeofday)).TotalSeconds / $(New-TimeSpan -Days $([datetime]::DaysInMonth($StartDate.Year,$StartDate.Month))).TotalSeconds
        
        $Months += $($(New-TimeSpan -Days  $($EndDate.Day - 1)) + $EndDate.timeofday).TotalSeconds / $(New-TimeSpan -Days $([datetime]::DaysInMonth($EndDate.Year,$EndDate.Month))).TotalSeconds
                    
        $Months = $months - 2 #Removing the 2 extra Months, since we added two further entries for End month and start Month above

        $timespan = $($EndDate - $StartDate)

        $output = [ordered]@{
            
            TotalYears = $($Months / 12);
            TotalCalendarMonths = $months;
            TotalWeeks = $($timespan.TotalDays / 7)
            TotalDays = $timespan.TotalDays;
            TotalHours = $timespan.TotalHours;
            TotalMinutes = $timespan.TotalMinutes;
            TotalSeconds = $timespan.TotalSeconds;
            TotalMilliseconds = $timespan.TotalMilliseconds
        
        }
    }

    End{
    
        New-Object -TypeName PsCustomObject -Property $output
    
    }

}