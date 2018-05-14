<#
-------------------------------------------------------------------
To find the Managed Disks created but not being used inside the VM
Developed by    Wriju Ghosh
Created on      25-February-2018
Updated on      25-February-2018

Disclaimer: Please test before you use in your subscription. 
------------------------------------------------------------------
#>


#Add-AzureRmAccount
$file = "orphan-managed-disk.csv"
$data = @() 

$MVHDS = Get-AzureRmDisk 

$MVHD = $MVHDS | Where {$_.OwnerId -eq $null}

foreach($disk in $MVHD){
    Write-Host $disk.Name -ForegroundColor Green

    $obj = New-Object PSObject

    $obj | Add-Member NoteProperty Name           $disk.Name
    $obj | Add-Member NoteProperty Location       $disk.Location
    $obj | Add-Member NoteProperty DiskSize       $disk.DiskSizeGB
    $obj | Add-Member NoteProperty VM             $disk.ManagedBy
    $obj | Add-Member NoteProperty ResourceGroup  $disk.ResourceGroupName
    $obj | Add-Member NoteProperty CreatedOn      $disk.TimeCreated
    $obj | Add-Member NoteProperty OS             $disk.OsType

    $data += $obj
}

$data | Export-Csv -Path $file -NoTypeInformation -Force
Invoke-Item $file
Write-Host "Complete writing to the file " + $file
