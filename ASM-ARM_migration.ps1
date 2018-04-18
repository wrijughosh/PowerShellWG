
#---------
# NETWORK
#---------
#to find the network name 
#Get-AzureVnetSite | Select -Property Name

$vnetName = "Group ASM-ARM ASM-ARM"

# VALIDATE
#$validate = Move-AzureVirtualNetwork -Validate -VirtualNetworkName $vnetName

#$validate.ValidationMessages

# PREPARE
#Move-AzureVirtualNetwork -Prepare -VirtualNetworkName $vnetName 

# COMMIT
#Move-AzureVirtualNetwork -Commit -VirtualNetworkName $vnetName

#----------
# STORAGE
#----------

$storageAccountName = "asmarm8046"

#Get-AzureDisk | where-Object {$_.MediaLink.Host.Contains($storageAccountName)} | Select-Object -ExpandProperty AttachedTo -Property `
  #DiskName | Format-List -Property RoleName, DiskName

  # VALIDATE
  #Move-AzureStorageAccount -Validate -StorageAccountName $storageAccountName
  
  # PREPARE
  #Move-AzureStorageAccount -Prepare -StorageAccountName $storageAccountName

  # COMMIT
  Move-AzureStorageAccount -Commit -StorageAccountName $storageAccountName

  
