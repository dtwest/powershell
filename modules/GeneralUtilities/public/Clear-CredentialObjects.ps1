Function Clear-CredentialObjects {

	<#
	.Synopsis
		Grabs all ps credential objects then makes the securestring read only, disposes of it and removed the variable.
		
	.DESCRIPTION
		Grabs all ps credential objects then makes the securestring read only, disposes of it and removed the variable.
		
		Uses the system.security.securestring.makereadonly method to make sure the password can no longer be modifed in each credential object.
		Then uses system.security.securestring.dispose to write binary 0's to the memory alocated for the value.
		Then Removes the credential object.

        Created out of Paranoia
		
	.Notes
		Author : 	Dylan West
		Version:	1.0.0.0
		History: 
					1.0.0.0 - initial version
					1.1.0.0 - Removed a Supurfluous verbose statement, changed name from remove-* to clear-*
		
	.Example
		PS C:\Users\Dywest\Clear-CredentialObjects
		
	.LINK
		https://msdn.microsoft.com/en-us/library/system.security.securestring.makereadonly(v=vs.110).aspx
		
	.LINK
		https://msdn.microsoft.com/en-us/library/system.security.securestring.dispose(v=vs.110).aspx
	
	#>

	[cmdletbinding()]
	Param()
	
	$Variables = Get-Variable
	
	For ($i = 0;$i -le $Variables.count; $i++){
		
		Try {
		
			$VariableTest = $Variables[$i].Value.gettype() -like '*PSCredential*'
		
		}
		Catch{
		
			IF ($Variables[$i].name -eq 'null'){
			
				write-verbose "Variable Number $i : $($Variables[$i].name) It's literally null, what more do you want from me I'm just a computer."
			
			}
			ELSE{
			
				write-verbose "$($Variables[$i].name) has no value, or the value is null!"
			
			}
		}
		
		IF ($VariableTest){
		
			$Variables[$i].Value.Password.MakeReadOnly()
			$Variables[$i].Value.Password.Dispose()
			
			write-verbose "Removing the variable just to be sure."
			
			$Name = $Variables[$i].name
			
			Get-Variable $Name -scope Global | Remove-Variable -scope global
		
		}
		ELSE {
		
			write-verbose "Variable Number $i : $($Variables[$i].name) is not a credential object."

		}

		$VariableTest = $Name = $null
	
	}


}