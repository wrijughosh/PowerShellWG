#Create VM
<#
$location = "eastus"
$vmName = "vm2"
$vmSize = "Standard_A1"

#Unique Name of the resource group
$rgName = "rg-smallvm1"
#New-AzureRmResourceGroup -Name $rgName -Location $location
$cred = Get-Credential
New-AzureRmVM -Name $vmName -ResourceGroupName $rgName -Location $location `
    -Size $vmSize -Credential $cred
#>

