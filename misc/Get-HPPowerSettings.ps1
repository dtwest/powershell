
function Get-HPPowerSettings {
    <#
    .SYNOPSIS
    Used to get the power settings for a HP server when you don'y have access to the HP management powershell module
    
    .DESCRIPTION
    Used to get the power settings for a HP server when you don'y have access to the HP management powershell module

    I wrote this when I was doing a alot of work with tableau admins and had to write this in about 30 odd minutes.
    It has been addapted from the script it was into a function.
    
    .EXAMPLE
    
    
    .NOTES
    Author : Dylan West
    Version: 1.0.0.0
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline,Position=0)]
        [Alias("Computers", "Computer")]
        [string]
        $ComputerName
    )
    
    begin {
        $InvokeCommandParams = @{
            ComputerName = "";
            ScriptBlock = {
                
                $biosAttributes = Get-WmiObject -Namespace "root/hpq" -Class hp_biosAttribute
                
                $powerProfile = $biosAttributes | 
                                        Where-Object ElementName -eq "HP Power Profile" |
                                            Select-Object -ExpandProperty CurrentValue
        
                $powerReulator = $biosAttributes | 
                                        Where-Object ElementName -eq "HP Power Regulator" | 
                                            Select-Object -ExpandProperty CurrentValue
        
                $powerPlan = $(Get-WmiObject -Namespace root\cimv2\power -class win32_powerplan | Where-Object IsActive -eq true).ElementName
        
                $output = @{
                    PowerPlan = $powerPlan;
                    PowerRegulator = $powerReulator;
                    PowerProfile = $powerProfile; 
                }
        
                New-Object -TypeName PSObject -Property $output
            
            }
        }
    }
    
    process {
        $results = foreach ($computer in $ComputerName) {
            try {
                $InvokeCommandParams.ComputerName = $computer
                Invoke-Command @InvokeCommandParams;
            }
            finally {
                $InvokeCommandParams.ComputerName = "";
            }
        }
    }
    
    end {
        return $results;
    }
}