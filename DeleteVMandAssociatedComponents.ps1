<#
-------------------------------------------------------
Delete VM and its associated resources



-------------------------------------------------------
#>

#Take VM name as Parameter
#https://github.com/riedwaab/delvm/blob/master/delvm.sh

$vmName = "" #name of the VM
$osdisk = null
$datadisks = @() 
$publicIps = @()
$nics = @()
$nsg = null

Write-Host "Getting VM" -ForegroundColor Cyan
$vm = Get-AzureRmVM -ResourceGroupName $rgName -Name $vmName

Write-Host "Getting OS Disk" -ForegroundColor Cyan
$osdisk = $vm.StorageProfile.OsDisk.Name #need to tackle both managed an unmanaged

Write-Host "Getting Data Disk(s)" -ForegroundColor Cyan
$datadisks = $vm.StorageProfile.DataDisks

Write-Host "Getting Public IP Addresses" -ForegroundColor Cyan
$publicIps = $vm | Get-AzureRmPublicIpAddress

Write-Host "Getting NICs" -ForegroundColor Cyan
$nics = $vm.NetworkProfile.NetworkInterfaces

Write-Host "Getting NSG" -ForegroundColor Cyan
$nsg = $vm | Get-AzureRmNetworkSecurityGroup

