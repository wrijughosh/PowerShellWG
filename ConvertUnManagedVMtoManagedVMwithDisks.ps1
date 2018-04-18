<#
==================================================
Convert UnManaged VM to Managed VM
Also it does convert the Unmanaged Data Disks to Managed 

Compiled by: Wriju Ghosh
Created On : 13-March-2018
==================================================
#>

param(
  [Parameter(Position = 0, Mandatory = $true)]
  [string]
  $ResourceGroupName,

  [Parameter(Position = 1, Mandatory = $true)]
  [string]
  $VMName
)

#First Stop the VM
Write-Host "Stopping the VM " $VMName -ForegroundColor Yellow
Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName # dont use -Force 

Write-Host "Converting the VM to Managed VM including Disks " $VMName -ForgroundColor Green
ConvertTo-AzureRmVMManagedDisk -ResourceGroupName $ResourceGroupName -VMName $VMName

Write-Host "Completed!!!" -ForegroundColor Green