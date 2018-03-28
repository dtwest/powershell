Function Rename-ItemsRecursive {
    <#
    .SYNOPSIS
        Rename All Files under a directory to a random String.
    .DESCRIPTION
        Request from an end user at a place of work (still waiting on that bottle of scotch).

    .NOTES
        Author : Dylan West - dywest (dywest)
        Version: 1.0.0.0
    .LINK
        https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/22/use-powershell-to-rename-files-in-bulk/
        https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/05/generate-random-letters-with-powershell/
    #>
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory,Position=0)]
        [string]$Path
    )
    ##### Creating PS Dirve to get around character limit, doing foreach directory.
    [string]$DriveName = "RN"
    [String]$TempDrive = "TD"
    ## Create the Drive
    New-PSDrive -Root $Path -Name $DriveName -PSProvider FileSystem | out-null
    ## Get The child items of the root folder (non recursive, we are going to create a drive for each directory to get around the max length issue)
    [Array]$ChildItems = Get-ChildItem -path "$DriveName`:\"-force
    
    ##Set Hashtable for Original Name, OldName (This will be output at the end)

    $Results = @()

    ## Initial Folder
    $ChildItems | 
        Where-Object Mode -NotLike "D*" |
            Foreach-Object {
        
                #Create random 10 character string using Upper, lower case letters, and Numbers. 
                #Check that the name hasn't been used before.
                DO{
                
                    $String = -Join ((65..90) + (97..122) + (48..57) | 
                        Get-Random -Count 10 |
                            ForEach-Object {[Char]$_})

                    IF ($String -in $Results.NewName){
                    
                        $String = $null
                    
                    }

                }Until($String)
            
                #Rename the file but keep the extension
                $_ | Rename-Item -NewName "$String$(IF ($_.Extension){"$($_.Extension)"})"
        
                $Output = @{
                
                    OldFullName = $_.FullName;
                    NewFullName = $($_.FullName -replace $($_.Name),"$String$(IF ($_.Extension){"$($_.Extension)"})");
                    NewName = $String;
                    OldName = $_.Name;
                
                }

                $Results += New-Object -TypeName PSCustomObject -Property $Output

                $String = $Output = $null
            }
    ## Foreach Directory Underneath and beyond
    $DirectoriesRecursive = Get-ChildItem -path "$DriveName`:\" -Directory -Recurse -Force
    Foreach ($Directory in $DirectoriesRecursive){
        New-PSDrive -Root $Directory.Fullname -Name $TempDrive -PSProvider FileSystem  | out-null
        $TempChildItems = Get-ChildItem -path "$TempDrive`:\" -force
        $TempChildItems | 
        Where-Object Mode -NotLike "D*" |
            Foreach-Object {
        
                #Create random 10 character string using Upper, lower case letters, and Numbers. 
                #Check that the name hasn't been used before.
                DO{
                
                    $String = -Join ((65..90) + (97..122) + (48..57) | 
                        Get-Random -Count 10 |
                            ForEach-Object {[Char]$_})

                    IF ($String -in $Results.NewName){
                    
                        $String = $null
                    
                    }

                }Until($String)
            
                #Rename the file but keep the extension
                $_ | Rename-Item -NewName "$String$(IF ($_.Extension){"$($_.Extension)"})"
        
                $Output = @{
                
                    OldFullName = $_.FullName;
                    NewFullName = $($_.FullName -replace $($_.Name),"$String$(IF ($_.Extension){"$($_.Extension)"})");
                    NewName = $String;
                    OldName = $_.Name;
                
                }

                $Results += New-Object -TypeName PSCustomObject -Property $Output

                $String = $Output = $null
            }
            $TempChildItems = $null
            Set-Location ~
            Remove-PSDrive $TempDrive
    }
    Set-Location ~
    Remove-PSDrive $DriveName

    Write-Output $Results
}