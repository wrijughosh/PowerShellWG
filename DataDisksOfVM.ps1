$rg = ""
$csvfile = "VMandDisks.csv"
$vmobjs = @()
Get-AzureRmDisk <#-ResourceGroupName $rg #> | ForEach-Object {
    
    #Write-Host $_.Name : $_.ManagedBy.Split('/')[8] : $_.DiskSizeGB 

    $vmDiskInfo = [pscustomobject]@{
                
        'VM'=$_.ManagedBy.Split('/')[8]
        'ResourceGroupName' = $_.ResourceGroupName
        'Location' = $_.Location
        'DiskName' = $_.Name
        'DiskSize' = $_.DiskSizeGB
        'OSType'   = $_.OsType                
    }       
    
    $vmobjs += $vmDiskInfo
}

#Save to CSV
#$vmobjs | Export-Csv -NoTypeInformation -Path $csvfile
#Invoke-Item $csvfile

#Disk from VM 
$vms = Get-AzureRmVM #-ResourceGroupName $rg

foreach($vm in $vms){
    #OS Disk
    Write-Host $vm.StorageProfile.OsDisk.Name : $vm.Name
    
    #Loop through all the data disks
    $ddisks = $vm.StorageProfile.DataDisks 
    foreach($ddisk in $ddisks){
        Write-Host $ddisk.Name : $vm.Name : $ddisk.DiskSizeGB
    }
    
}
