<#
===================================================
Get the list of VMs under a single subscription 
 
By      : Wriju Ghosh 
Created : 22-Feb-2018
Created : 23-Feb-2018

Get the PRIVATE IP Addresses of VMs
Get Disks of the VM (so far only 6 considered)

===================================================
#>

#Add-AzureRmAccount

 
$file = "AllVM1s.csv"
$vmobjs = @()

#$subscriptionIds = @()
#$null = Set-AzureRmContext -SubscriptionId ""
$subscriptionIds += "cbc75b62-c7f2-4385-8450-4cb7e7c79153"
$subscriptionIds += "cbc75b62-c7f2-4385-8450-4cb7e7c79153"
$subscriptionIds += "cbc75b62-c7f2-4385-8450-4cb7e7c79153"

foreach($subscriptionId in $subscriptionIds)
{
    $null = Set-AzureRmContext -SubscriptionId $subscriptionId
    $subscription = Get-AzureRmSubscription -SubscriptionId $subscriptionId

    $subscriptionName = $subscription.Name
        
    $rgs = Get-AzureRmResourceGroup
    foreach ($rg in $rgs)
    {
        $rgName = $rg.ResourceGroupName

        $vms = get-azurermvm -ResourceGroupName $rgName

        #$nics = get-azurermnetworkinterface -ResourceGroupName $rgName | where VirtualMachine -NE $null #skip Nics with no VM

        #foreach($nic in $nics)
        foreach($vm in $vms)
        {
            #$vm = $vms | where-object -Property Id -EQ $nic.VirtualMachine.id
            #$prv =  $nic.IpConfigurations | select-object -ExpandProperty PrivateIpAddress
            
            $vm.StorageProfile.ImageReference.Sku
            $vm.StorageProfile.ImageReference.Offer

            $vmInfo = [PSCustomObject]@{
                #'Mode'              ='ARM'
                'SubscriptionId'    = $subscriptionId
                'SubscriptionName'  = $subscriptionName

                'Name'              = $vm.Name
                #'PrivateIP'         = $prv
                'ResourceGroupName' = $vm.ResourceGroupName
                'Location'          = $vm.Location
                'VMSize'            = $vm.HardwareProfile.VMSize

                'ImageSKU'          = $vm.StorageProfile.ImageReference.Sku
                'OS'                = $vm.StorageProfile.ImageReference.Offer
                                

                #'OSDisk'            = $vm.StorageProfile.OsDisk.DiskSizeGB

                <#
                'Disk1'             = $vm.StorageProfile.DataDisks[0].Name
                'Disk1Size'         = $vm.StorageProfile.DataDisks[0].DiskSizeGB
            
                'Disk2'             = $vm.StorageProfile.DataDisks[1].Name
                'Disk2Size'         = $vm.StorageProfile.DataDisks[1].DiskSizeGB
            
                'Disk3'             = $vm.StorageProfile.DataDisks[2].Name
                'Disk3Size'         = $vm.StorageProfile.DataDisks[2].DiskSizeGB
            
                'Disk4'             = $vm.StorageProfile.DataDisks[3].Name
                'Disk4Size'         = $vm.StorageProfile.DataDisks[3].DiskSizeGB

                'Disk5'             = $vm.StorageProfile.DataDisks[4].Name
                'Disk5Size'         = $vm.StorageProfile.DataDisks[4].DiskSizeGB

                'Disk6'             = $vm.StorageProfile.DataDisks[5].Name
                'Disk6Size'         = $vm.StorageProfile.DataDisks[5].DiskSizeGB            
                #>
            }
                
            $vmobjs += $vmInfo        
        }  
    }
}


$vmobjs | Export-Csv -NoTypeInformation -Path $file -f
Invoke-Item $file 
Write-Host "VM list written to $file"

Invoke-Item $file 