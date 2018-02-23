#===================================================

# GET THE PRIVATE IP Addresses of VMs

#===================================================
#Add-AzureRmAccount
$rgs = Get-AzureRmResourceGroup  

foreach ($rg in $rgs)
{
    $rgName = $rg.ResourceGroupName

    $vms = get-azurermvm -ResourceGroupName $rgName

    $nics = get-azurermnetworkinterface -ResourceGroupName $rgName | where VirtualMachine -NE $null #skip Nics with no VM

    foreach($nic in $nics)
    {
        $vm = $vms | where-object -Property Id -EQ $nic.VirtualMachine.id
        $prv =  $nic.IpConfigurations | select-object -ExpandProperty PrivateIpAddress
        
        Write-Host $vm.Name : `
                   $prv : `
                   $rgName : `
                   $vm.Location : `
                   $vm.HardwareProfile.VmSize : `
                   $vm.StorageProfile.ImageReference.Sku : `
                   $vm.StorageProfile.ImageReference.Offer : `
                   $vm.StorageProfile.DataDisks.Count : `
                   $vm.StorageProfile.DataDisks.Capacity

        #$vmInfo = [pscustomobject]@{
        #    'Mode'              ='ARM'
        #    'Name'              = $vm.Name
        #    'PrivateIP'         = $prv
        #    'ResourceGroupName' = $vm.ResourceGroupName
        #    'Location'          = $vm.Location
            #'VMSize'            = $vm.HardwareProfile.VMSize
            #'Status'            = $null
            #'ImageSKU'          = $vm.StorageProfile.ImageReference.Sku
            #'OS'                = $vm.StorageProfile.ImageReference.Offer
        #}
        
        #$vms | where Name -EQ $vm | select Statuses[1].DisplayStatus
            
        #$vmStatus = $vm | Get-AzureRmVM -Status
        #$vmInfo.Status = $vmStatus.Statuses[1].DisplayStatus

        #$vmobjs += $vmInfo
        #Write-Host "."        
    }  
}

$file = "C:\temp\All_VM.csv"
#$vmobjs | Export-Csv -NoTypeInformation -Path $file -f
#Write-Host "VM list written to $file"

#Invoke-Item $file 