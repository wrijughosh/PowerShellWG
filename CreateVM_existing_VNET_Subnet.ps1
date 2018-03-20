<#
=========================================
Create VM from existing VNet, Subnet NSG..
=========================================
#>
#param()

#Prepare the VM parameters 
$rgName = "rg-newVM"
$vmName = "wg-newVM"

$location = "eastus"

#Get VNet (pre-created)
$vnetName = "wg0vnet"
$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName

#Get the Subnet (pre-created) 
$subnetName = "webapp-subnet"
$subnet = Get-AzureRmVirtualNetwork -Name $vnet -ResourceGroupName $rgName `
             | Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName

#Get NSG (pre-created)
$nsgName = "wg-NSG-Http"
$nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName

#Create NIC (Private Ip Dynamic)
$nicName = $vmName + "nic"
$IPConfigName = $vmName + "IPConfig"
$IPconfig = New-AzureRmNetworkInterfaceIpConfig -Name $IPConfigName `
     -PrivateIpAddressVersion IPv4 -SubnetId $subnet #Dynamic Private IP
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName `
        -PrivateIpAddressVersion IPv4 -Location "eastUs" -SubnetId `
        $subnet.Id -IpConfigurationName $IPConfigName


#Get-AzureRmVMSize -Location "eastus"
$VMSize = "Standard_DS1_v2"
#$storageAccountType = "StandardLRS"
#$IPaddress = "10.10.10.10"
#OS 

$sku = ""

#Create the VM resources
#
#$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location -IpConfiguration $IPconfig

$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize $VMSize
$vm = Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $nic.Id

#$osDisk = New-AzureRmDisk -DiskName $osDiskName -Disk (New-AzureRmDiskConfig -AccountType $storageAccountType -Location $location -CreateOption Import -SourceUri $osDiskUri) -ResourceGroupName $rgName
#$vm = Set-AzureRmVMOSDisk -VM $vm -ManagedDiskId $osDisk.Id -StorageAccountType $storageAccountType -DiskSizeInGB 128 -CreateOption Attach -Windows


$vm = Set-AzureRmVMBootDiagnostics -VM $vm -disable

#Create the new VM
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm


#Get-AzureRmResourceGroups | Foreach-Loop { Get-AzureRmVM -ResourceGroupName $_.ResourceGroupName | 