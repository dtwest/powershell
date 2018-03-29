<#

	Aliases

#>

<#

	Variables

#>

<#

	Functions 

#>

# Credit below to Boe Prox, I think I use this import method on almost every module I've ever created.

write-verbose "Getting the public and private functions"

$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

Foreach ($Function in @($Public + $Private)){

	TRY{
	
		. $Function.fullname

	}
	CATCH{
	
		Write-Error "Failed to import function $($Function.Fullname): $_"
	
	}

}

Export-ModuleMember -Function $Public.BaseName