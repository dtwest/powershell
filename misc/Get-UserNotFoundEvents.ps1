Function Get-UserNotFoundEvents {

    <#
    .SYNOPSIS
        Used to search through event logs to find username not found events
    
    .Description
        Used to search through event logs to find username not found events 

        This can be used to find instances where a user accidentally types their password into the username field when logging on or attempting to authenticate.

        NOTE that this is legacy and no longer works, it is here for demonstration purposes.

    .PARAMETER TestPasswords
        This will attempt to test if the password is a valid password for someone who has logged on the machine

        This will only attempt to test against accounts that logged on successfully within 15 minutes of the username not found event
        The logon type must be the same and it will not attempt to test the Machine Account.

    .PARAMETER TestCurrentUser
        If specified then the script will attempt to test the current user

    .Notes
        Author :    Dylan West
        Version:    1.0.0.0
        DISCLAIMER: 
            This is a legacy function, and will not work on a non windows machine (if internal and you have access to my old Get-UserNotFoundEventsFromSplunk function, use that instead).
        ORIGINAL Author: Unknown (I did appropriate some of the code to do this, however I can't remember the original author, if you know please email me so I can update this).
    #>

    [CMDLETBINDING()]
    Param(
    
    )

    $Event4625 = Get-WinEvent -FilterXml '<QueryList>
        <Query Id="0" Path="Security">
        <Select Path="Security">*[System[(Level=4 or Level=0) and (band(Keywords,4503599627370496)) and (EventID=4625)]]</Select>
        </Query>
    </QueryList>'

    $Events= $Event4625 | Where-Object {$_.Message -like "*Status:*0xC000006D*Sub Status:*0xC0000064*"}

    $Global:PotentialUsers = @()
    $AllEvent4624 = @()

    Foreach ($Event in $Events){
    
        $StartDate = get-date $event.TimeCreated.ToUniversalTime().AddMinutes(-15) -Format 'yyyy-MM-ddTHH:mm:ss.000Z'
        $EndDate = get-date $Event.TimeCreated.ToUniversalTime().AddMinutes(15) -Format 'yyyy-MM-ddTHH:mm:ss.999Z'
        
        $XMLFilter = "<QueryList>
            <Query Id=`"0`" Path=`"Security`">
            <Select Path=`"Security`">*[System[(Level=4 or Level=0) and (band(Keywords,9007199254740992)) and (EventID=4624) and TimeCreated[@SystemTime&gt;='$StartDate' and @SystemTime&lt;='$EndDate']]]</Select>
            </Query>
        </QueryList>"

        $MultipleEvent4624 = Get-WinEvent -FilterXml $XMLFilter
        $AllEvent4624 += $MultipleEvent4624 

        IF ($MultipleEvent4624){

            FOREACH ($Event4624 in $MultipleEvent4624){

                IF(($Event4624.Properties[6].value -ne 'NT AUTHORITY') -and ($Event4624.Properties[5].value -ne 'system')){
            
                    #Validate user exists
                    $ErrorActionPreference = "Stop"
                    Try{

                        $User = Get-ADDSObject -ObjectType User -Identity $Event4624.Properties[5].value

                        IF($User.SAMAccountName){

                            IF (($event4624.timecreated.ToUniversalTime() -gt $event.TimeCreated.ToUniversalTime().addminutes(-15)) -and ($event4624.TimeCreated.ToUniversalTime() -lt $event.TimeCreated.ToUniversalTime().AddMinutes(15))){

                                $output = @{
                
                                    UserName=$($Event4624.Properties[5].value|Out-String);
                                    'SuccessfulLogonTime(UTC)'=$(get-date $Event4624.TimeCreated.ToUniversalTime());
                                    PotentialPassword=$($event.Properties[5].value|Out-String);
                                    'FailedLogonTime(UTC)'=$(get-date $Event.TimeCreated.ToUniversalTime());
                
                                }
                                $object = New-Object -TypeName PSCustomObject -Property $output

                                $PotentialUsers += $object

                            }
                        }
                    
                    }
                    Catch{
                    
                        write-verbose $_.Exception
                    
                    }
                }
                #$Event4624 = $null
            }
        }
    }
    $PotentialUsers = $PotentialUsers | Sort-Object Username,PotentialPassword -Unique
    
    #Output the Usernames not found, the date the event was logged and users who successfully logged on within 15 minutes of the event.

    Write-Output $PotentialUsers
}
