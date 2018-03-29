Function Convert-DateString {

	<#
	.Synopsis
		Used to convert non standard dates to a datetime object.
		
	.NOTES
		Author: 	Jakub Jares
		Version: 	1.0
		
		Link: 		http://www.powershellmagazine.com/2013/07/08/pstip-converting-a-string-to-a-system-datetime-object/
		
	.PARAMETER date
		Specify the string that is a date eg 20161010013030
	
	.PARAMETER format
		specify the format, eg yyyyMMddHHmmss
		
	.Example
		ps > Convert-DateString -date 20161010013030 -format yyyyMMddHHmmss
	
		Monday, October 10, 2016 1:30:30 AM
	#>
	
	[cmdletbinding()]
	param(
	
		[parameter(valuefrompipeline)]
		[string]$date,
		
		[parameter()]
		[string]$format
	
	)
	
    $result = New-Object DateTime
 
    $convertible = [DateTime]::TryParseExact(
		$Date,
		$Format,
		[System.Globalization.CultureInfo]::InvariantCulture,
		[System.Globalization.DateTimeStyles]::None,
		[ref]$result)
 
	if ($convertible) { 
		
		$result 
	
	}
}