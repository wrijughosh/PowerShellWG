#Create VM
Param(    
    [string]$VMName,
    [string]$RGName,
    [string]$Location 
)

#Create VM

$location = "eastus" #hardcoded 
#$vmName = "vm2"
$vmSize = "Standard_A1" #hardoced

#Check if RG Exists
Write-Host "Checking if the RG exists.." -ForegroundColor Yellow
Get-AzureRmResourceGroup -Name $RGName -ErrorVariable notPresent `
    -ErrorAction SilentlyContinue

if ($notPresent)
{
    # ResourceGroup doesn't exist 
    # Hence create a new one
    New-AzureRmResourceGroup -Name $RGName -Location $Location
    Write-Host "RG Created.." -ForegroundColor Green
}
else
{
    # ResourceGroup exist - do nothing.. continue
    Write-Host "RG already exists.." -ForegroundColor Yellow
}

#then create the VM
New-AzureRmVM -Name $VMName -ResourceGroupName $RGName `
    -Location $location -Size $vmSize 


