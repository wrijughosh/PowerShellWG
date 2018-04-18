<#
--------------------------------------------------------------------------------------
Find and delete Unused UnManaged disks
Script taken from MSDN https://docs.microsoft.com/en-us/azure/virtual-machines/windows/find-unattached-disks
Created : 18-April-2018
Updated : 18-April-2018

By : Wriju Ghosh
--------------------------------------------------------------------------------------
#>

$file = "orphan-unmanaged-disk.csv"

$data = @() 

$storageAccounts = Get-AzureRmStorageAccount

foreach($storageAccount in $storageAccounts){

    $storageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $storageAccount.ResourceGroupName -Name $storageAccount.StorageAccountName)[0].Value

    $context = New-AzureStorageContext -StorageAccountName $storageAccount.StorageAccountName -StorageAccountKey $storageKey

    $containers = Get-AzureStorageContainer -Context $context

    foreach($container in $containers){

        $blobs = Get-AzureStorageBlob -Container $container.Name -Context $context

        #Fetch all the Page blobs with extension .vhd as only Page blobs can be attached as disk to Azure VMs
        $blobs | Where-Object {$_.BlobType -eq 'PageBlob' -and $_.Name.EndsWith('.vhd')} | ForEach-Object { 

        Write-Host $_.Name $_.ICloudBlob.Properties.LeaseStatus 

        $obj = New-Object PSObject


        $obj | Add-Member NoteProperty Name $_.Name
        $obj | Add-Member NoteProperty LeaseStatus $_.ICloudBlob.Properties.LeaseStatus
        $obj | Add-Member NoteProperty ResourceGroup $storageAccount.ResourceGroupName
        $obj | Add-Member NoteProperty StoageAccount $storageAccount.StorageAccountName
        $obj | Add-Member NoteProperty Container $container.Name
        $obj | Add-Member NoteProperty Uri $_.ICloudBlob.Uri.AbsoluteUri 

        $data += $obj


            <#If a Page blob is not attached as disk then LeaseStatus will be unlocked
            if($_.ICloudBlob.Properties.LeaseStatus -eq 'Unlocked'){

                  if($deleteUnattachedVHDs -eq 1){

                        Write-Host "Found unattached VHD with Uri: $($_.ICloudBlob.Uri.AbsoluteUri)"

                        #$_ | Remove-AzureStorageBlob -Force

                        #Write-Host "Deleted unattached VHD with Uri: $($_.ICloudBlob.Uri.AbsoluteUri)"
                  }
                  else{
                        #Write-Host $_.ICloudBlob.Uri.AbsoluteUri
                        $_.ICloudBlob.Uri.AbsoluteUri

                  }
            }#>

        }
    }
}
$data | Export-Csv -Path $file -NoTypeInformation -Force

Invoke-Item $file

Write-Host "Complete writing to the file " + $file$data | Export-Csv -Path $file -NoTypeInformation -Force

Invoke-Item $file

Write-Host "Complete writing to the file " + $file