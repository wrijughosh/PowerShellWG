#Add-AzureAccount
$azurelocation = "australiaeast"

#CSV output
$outputfile = "C:\temp\AzQuota.csv"

#Make an array of things to be dumped in csv file
$arr = @() #declare the array

#To find all the limit commands
#Get-Help Get-AzureRm*Usage

#VM and it's quota
$vmquota = Get-AzureRmVMUsage -Location $azurelocation | Select Name, CurrentValue, Limit

#$networkquota = 
$networkquota = Get-AzureRmNetworkUsage -Location $azurelocation | Select Name, CurrentValue, Limit 

#Storage quota
$storagequota = Get-AzureRmStorageUsage | Select LocalizedName, CurrentValue, Limit

#Loop through network and dump to an array
$vmquota | ForEach-Object {
    
    $obj = New-Object PSObject 

    $obj | Add-Member NoteProperty ResourceName $_.Name.LocalizedValue
    $obj | Add-Member NoteProperty CurrentlyUsed $_.CurrentValue
    $obj | Add-Member NoteProperty Limit $_.Limit
    $obj | Add-Member NoteProperty Category "VM"

    $arr += $obj
}

$networkquota | ForEach-Object {
    
    $obj = New-Object PSObject 

    $obj | Add-Member NoteProperty ResourceName $_.Name.LocalizedValue
    $obj | Add-Member NoteProperty CurrentlyUsed $_.CurrentValue
    $obj | Add-Member NoteProperty Limit $_.Limit
    $obj | Add-Member NoteProperty Category "Network"

    $arr += $obj
}


$storagequota | ForEach-Object {
    
    $obj = New-Object PSObject 

    $obj | Add-Member NoteProperty ResourceName $_.LocalizedName
    $obj | Add-Member NoteProperty CurrentlyUsed $_.CurrentValue
    $obj | Add-Member NoteProperty Limit $_.Limit
    $obj | Add-Member NoteProperty Category "Storage"

    $arr += $obj
}


#Export to CSV
$arr | Export-Csv -Path $outputfile -NoTypeInformation -Force

Invoke-Item $outputfile
#Get-Content $outputfile
