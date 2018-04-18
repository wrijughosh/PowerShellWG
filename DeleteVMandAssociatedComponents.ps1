<#
-------------------------------------------------------
Delete VM and its associated resources



-------------------------------------------------------
#>

#Take VM name as Parameter
#https://github.com/riedwaab/delvm/blob/master/delvm.sh

$rgName = "WG-DELETE2"
$vmName = "WG-DELETE2" #name of the VM
$osDisk = ""
$osDiskManaged = ""
$datadisks = @() 
$publicIps = @()
$nics = @()
$nsg = ""

Write-Host "Getting VM" -ForegroundColor Cyan
$vm = Get-AzureRmVM -ResourceGroupName $rgName -Name $vmName

Write-Host "Getting OS Disk" -ForegroundColor Cyan
$osDisk = $vm.StorageProfile.OsDisk.Name #need to tackle both managed an unmanaged

Write-Host "Getting Data Disk(s)" -ForegroundColor Cyan
$dataDisks = $vm.StorageProfile.DataDisks ##need to tackle both managed an unmanaged

Write-Host "Getting Public IP Addresses" -ForegroundColor Cyan
$publicIps = $vm | Get-AzureRmPublicIpAddress
#$publicIps | ForEach-Object {Write-Host $_.IpAddress}

Write-Host "Getting NICs" -ForegroundColor Cyan
$nics = $vm.NetworkProfile.NetworkInterfaces
$nics | ForEach-Object {Write-Host $_.Id}

Write-Host "Getting NSG" -ForegroundColor Cyan
$nsg = $vm | Get-AzureRmNetworkSecurityGroup

