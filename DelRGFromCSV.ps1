#Read from CSV RG Name and SubscriptionId and look through 
#Then call another PowerShell File to pass those values to execute
param(

  [Parameter(Position = 0, Mandatory = $true)]
  [string]
  $CsvFilePath
)

<#
The format of the CVS file would look likem
SunbscriptionId, RGName
#>

#Assuming that the file exists without any doubt

Import-Csv $CsvFilePath | ForEach-Object {
    
    
    $subId = $_.SubscriptionId
    $rg = $_.RGName

    Write-Host "Deleting the Resource Group : " + $rg -ForegroundColor Yellow
    
    #Calling another PS1 and passing the parameters
    $command = “D:\GithubProj\PowerShellWG\DeleteAllResourcesInRG_exceptRG.ps1 -SubscriptionId $subId -ResourceGroupName $rg"
    Invoke-Expression $command
}


#Take the function approach to modulerize things




