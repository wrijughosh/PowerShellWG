#$disks = Get-AzureRmDisk -ResourceGroupName "wg-ubuntu"

#foreach($disk in $disks)
{
 #   Write-Host $disk.Type $disk.DiskSizeGB    
}

$vms = Get-AzureRmVM -ResourceGroupName "wg-ubuntu"

foreach($vm in $vms){

    Write-Host $vm.StorageProfile.OsDisk.Vhd.Uri.Split('/')
    $arr = $vm.StorageProfile.OsDisk.Vhd.Uri.Split('/')
   
    foreach($datadisk in $vm.StorageProfile.DataDisks){
        Write-Host $datadisk
    }    
}
