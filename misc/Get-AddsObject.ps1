Function Get-ADDSObject {
    
        <#
        .SYNOPSIS
            Used to get information about a User from AD directly without using activedirectory module
            
        .DESCRIPTION
            Used to get information about a User from AD directly without using activedirectory module
            
        .NOTES
            Author: 	Dylan West
            Version: 	1.3
            
            Re-made so that it was more flexible.
        
        .PARAMETER UserName
            Specify the user to check, defaults to $ENV:Username
                
        .LINK
            $recipDisplayTypes and $RecipTypeDetails grabed from : 
            https://blogs.technet.microsoft.com/johnbai/2013/09/11/o365-exchange-and-ad-how-msexchrecipientdisplaytype-and-msexchangerecipienttypedetails-relate-to-your-on-premises/"
            
            Search from:
            https://technet.microsoft.com/en-us/library/ff730967.aspx
        #>
        
        [cmdletbinding()]
        param(
        
            [Parameter(position=0,ValueFromPipeline,mandatory)]
            [string]$Identity,
        
            [parameter(position=1)]
            [string]$ObjectType = 'User',
            
            [Parameter(position=2)]
            [string]$Filter = 'SAMAccountName',
            
            [Parameter(Position=3)]
            [Array]$Properties
        
        )
        
        Begin{
        
            write-verbose "Creating Hashtables for Recipient Display Types and Recipient Type Details"
            
            $RecipDisplayTypes = [ordered]@{
            
                'MailboxUser'=	0
                'DistrbutionGroup'=	1
                'PublicFolder'=	2
                'DynamicDistributionGroup'=	3
                'Organization'=	4
                'PrivateDistributionList'=	5
                'RemoteMailUser'=	6
                'ConferenceRoomMailbox'=	7
                'EquipmentMailbox'=	8
                'ACLableMailboxUser'=	1073741824
                'SecurityDistributionGroup'=	1043741833
                'SyncedMailboxUser'=	-2147483642
                'SyncedUDGasUDG'=	-2147483391
                'SyncedUDGasContact'= -2147483386
                'SyncedPublicFolder'=	-2147483130
                'SyncedDynamicDistributionGroup'=	-2147482874
                'SyncedRemoteMailUser'=	-2147482106
                'SyncedConferenceRoomMailbox'=	-2147481850
                'SyncedEquipmentMailbox'=	-2147481594
                'SyncedUSGasUDG'=	-2147481343
                'SyncedUSGasContact'=	-2147481338
                'ACLableSyncedMailboxUser'=	-1073741818
                'ACLableSyncedRemoteMailUser'=	-1073740282
                'ACLableSyncedUSGasContact'=	-1073739514
                'SyncedUSGasUSG'=	-1073739511
            }
            write-debug "`$RecipDisplayTypes is $RecipDisplayTypes"
            
            $RecipTypeDetails = [ordered]@{
            
                'User Mailbox (On Prem)'=	1	
                'Linked Mailbox'=	2
                'Shared Mailbox'=	4	
                'Legacy Mailbox'=	8	
                'Room Mailbox'=	16	
                'Equipment Mailbox'=	32	
                'Mail Contact'=	64	
                'Mail User'=	128	
                'Mail-Enabled Universal Distribution Group'=	256	
                'Mail-Enabled Non-Universal Distribution Group'=	512	
                'Mail-Enabled Universal Security Group'=	1024	
                'Dynamic Distribution Group'=	2048	
                'Public Folder'=	4096
                'System Attendant Mailbox'=	8192
                'System Mailbox'=	16384	
                'Cross-Forest Mail Contact'=	32768
                'User'=	65536
                'Contact'=	131072
                'Universal Distribution Group'=	262144
                'Universal Security Group'=	524288
                'Non-Universal Group'=	1048576	
                'Disabled User'=	2097152	
                'Microsoft Exchange'=	4194304
                'Arbitration Mailbox'=	8388608
                'Mailbox Plan'=	16777216
                'Linked User'=	33554432
                'Room List'=	268435456
                'Discovery Mailbox'=	536870912
                'Role Group'=	1073741824
                'Remote Mailbox (O365)'=  2147483648                        
                'Team Mailbox'=	137438953472
            
            }
            write-debug "`$RecipTypeDetails is $RecipTypeDetails"
        
            $UACValue = [ordered]@{
            
                'SCRIPT'=1
                'ACCOUNTDISABLE'=2
                'HOMEDIR_REQUIRED'=8
                'LOCKOUT'=16
                'PASSWD_NOTREQD'=32
                'PASSWD_CANT_CHANGE'= 64
                'ENCRYPTED_TEXT_PWD_ALLOWED'=128
                'TEMP_DUPLICATE_ACCOUNT'=256
                'NORMAL_ACCOUNT'=512
                'INTERDOMAIN_TRUST_ACCOUNT'=2048
                'WORKSTATION_TRUST_ACCOUNT'=4096
                'SERVER_TRUST_ACCOUNT'=8192
                'DONT_EXPIRE_PASSWORD'=65536
                'MNS_LOGON_ACCOUNT'=131072
                'SMARTCARD_REQUIRED'=262144
                'TRUSTED_FOR_DELEGATION'=524288
                'NOT_DELEGATED'=1048576
                'USE_DES_KEY_ONLY'=2097152
                'DONT_REQ_PREAUTH'=4194304
                'PASSWORD_EXPIRED'=8388608
                'TRUSTED_TO_AUTH_FOR_DELEGATION'=16777216
                'PARTIAL_SECRETS_ACCOUNT'=67108864
            
            }
            write-debug "`$UACValue is $UACValue"
                        
        }
        
        Process {
        
            $strFilter = "(&(objectCategory=$ObjectType)($Filter=$Identity))"
    
            $objDomain = New-Object System.DirectoryServices.DirectoryEntry
    
            $objSearcher = New-Object System.DirectoryServices.DirectorySearcher
            $objSearcher.SearchRoot = $objDomain
            $objSearcher.PageSize = 9999
            $objSearcher.Filter = $strFilter
            $objSearcher.SearchScope = "Subtree"
    
            $colProplist = "*"
            foreach ($i in $colPropList){$objSearcher.PropertiesToLoad.Add($i) | out-Null} #This is important, Out-Null prevents the 0 from appearing.
    
            try{
            
                $erroactionpreference = 'stop'
            
                $colResults = $objSearcher.FindAll()
        
            }
            catch{
        
                write-error "Unable to reach a domain controller to run the search.`nPlease make sure to be connected to the company network!"
                Break;
            
            }
            $erroactionpreference = 'Continue'
            
            $results = $colresults.properties
            
            write-verbose "Creating default output"
            
            $output = [Ordered]@{
    
                'DistinguishedName'=$results.distinguishedname
                'DisplayName'=$results.displayname
                'ObjectClass'=$results.objectclass
                'SAMAccountName'=$results.samaccountname
                'UserPrincipalName'=$results.userprincipalname
    
            }
            
            write-verbose "Checking if the object is a user, if so will calculate UAC"
            
            IF ($results.objectclass -contains 'user'){
            
                $CalcUAC1 = @()
                $useraccountcontrol = [int]$results.useraccountcontrol[0]
                foreach ($i in $($uacvalue.getenumerator() | sort-object value -Descending).value){
                    
                    if ($useraccountcontrol -ge $i){
                    
                        write-verbose "Intiger $i makes up Intiger for User Account Control, adding to list"
                        
                        $useraccountcontrol = (($useraccountcontrol)-$i)
                        $CalcUAC1 += $i
                    
                    }
                    else{
                    
                        write-verbose "Intiger $i does not make up Intiger for User Account Control, not adding to list"
                    
                    }
                    
                }
                $UAC = foreach ($i in $CalcUAC1){
                    
                    ($UACValue.getenumerator() | where {$_.value -eq ($i)})
                
                }
                $output.add('UserAccountControl',$Uac.Name)
            }
            
            write-verbose "Checking for Recipient Type details and display type"
            
            IF($results.msexchrecipienttypedetails -and $results.msexchrecipientdisplaytype){
            
                $RTD = ($RecipTypeDetails.getenumerator() | where {$_.value -eq ($results.msexchrecipienttypedetails[0])})
                write-debug "`$RTD = $RTD"
                
                $RDT = ($recipDisplayTypes.getenumerator() | where {$_.value -eq ($results.msexchrecipientdisplaytype[0])})
                write-debug "`$RDT = $RDT"
                
            }
            ELSE{
            
                write-verbose "No Type Details, skipping over this one."
            
            }
            IF($RDT -and $RTD){
            
                if($results.mail){
                
                    $output.add('mail',$results.mail)
                    
                }
                if($results.'msrtcsip-primaryuseraddress' -and $results.'msrtcsip-userenabled'){
                
                    $output.add('msrtcsip-primaryuseraddress',$results.'msrtcsip-primaryuseraddress')
                    $output.add('msrtcsip-userenabled',$results.'msrtcsip-userenabled')
                    $output.add('msrtcsip-deploymentlocator',$results.'msrtcsip-deploymentlocator')
                
                }
                $output.add('msexchrecipienttypedetails',$RTD.name + ' (' + $RTD.value + ')')
                $output.add('msexchrecipientdisplaytype',$RDT.name + ' (' + $RDT.Value + ')')
            
            }
            
            FOREACH ($I in $Properties){
            
                IF ($Results.$I){
                
                    IF ($Output.keys -eq $I){
                    
                        write-verbose "Already In output, no need to re-add property: $i"
                    
                    }
                    ELSE{
                    
                        $Output.Add("$I",$Results.$i)
                    
                    }
                }
                ELSEIF ($Properties -eq '*'){
                
                    $output =  $results
                    IF ($results.objectclass -contains 'user'){
                    
                        $output.useraccountcontrol = "$($Uac.Name)"
                    
                    }
                    IF($RDT -and $RTD){
    
                        $output.msexchrecipienttypedetails = ($RTD.name + ' (' + $RTD.value + ')')
                        $output.msexchrecipientdisplaytype = ($RDT.name + ' (' + $RDT.Value + ')')
                
                    }
                    
                }
                ELSE{
                
                    write-verbose "No additional properties requested"
                
                }
            }
        
        }
    
        End{
        
            New-Object -TypeName PSCustomObject -Property $output		
        
        }
    }	
    