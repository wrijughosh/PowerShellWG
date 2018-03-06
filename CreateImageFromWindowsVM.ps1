$vmName = "wg-win2016"
$rgName = "wg-image-test"
$location = "SoutheastAsia"
$imageName = "WG-Win-Image-Demo1"
#$imageResourceGroup = "wg-image-demo"
#Get the VM
$vm = Get-AzureRmVm -Name $vmName -ResourceGroupName $rgName

#Get the ID of the managed disk
$diskID = $vm.StorageProfile.OsDisk.ManagedDisk.Id

#Create the image configuration.
$imageConfig = New-AzureRmImageConfig -Location $location
$imageConfig = Set-AzureRmImageOsDisk -Image $imageConfig -OsState Generalized -OsType Windows -ManagedDiskId $diskID

#Create the image
New-AzureRmImage -ImageName $imageName -ResourceGroupName $rgName -Image $imageConfig