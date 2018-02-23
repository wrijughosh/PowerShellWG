#Add-AzureRmAccount

$stoageAcc = Get-AzureRmStorageAccount 

$unManagedDisks = $stoageAcc | Get-AzureStorageContainer | Get-AzureStorageBlob | Where {$_.Name -like '*.vhd'}

$managedDisks = 