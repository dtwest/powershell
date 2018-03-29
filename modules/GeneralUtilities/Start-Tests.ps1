# Sets location to tests and then executes ever test file.

Set-Location ./tests

gci ./*test.ps1 | %{. $_.fullname}

Set-Location .. 


