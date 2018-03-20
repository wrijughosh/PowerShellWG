param(
  <#[Parameter(Position = 0, Mandatory = $true)]
  [string]
  $SubscriptionId,#>

  [Parameter(Position = 1, Mandatory = $true)]
  [string]
  $ResourceGroupName
)

#$null = Set-AzureRmContext -SubscriptionId $SubscriptionId

@(
  'Microsoft.Compute/virtualMachineScaleSets'
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Storage/storageAccounts'
  'Microsoft.Network/connections'
  'Microsoft.Network/virtualNetworkGateways'
  'Microsoft.Network/loadBalancers'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/publicIPAddresses'
  'Microsoft.Network/networkSecurityGroups'
  'Microsoft.Network/virtualNetworks'
  'Microsoft.Compute/disks'
  '*' # remaining
) | % {
  $params = @{
    'ResourceGroupNameContains' = $ResourceGroupName
  }

  if ($_ -ne '*') {
    $params.Add('ResourceType', $_)
  }

  $resources = Find-AzureRmResource @params
  $resources | Where-Object { $_.ResourceGroupName -eq $ResourceGroupName } | % { 
    Write-Host ('Processing {0}/{1}' -f $_.ResourceType, $_.ResourceName)
    $_ | Remove-AzureRmResource -Verbose -Force
  }
}

#Clue: https://www.codeisahighway.com/effective-ways-to-delete-resources-in-a-resource-group-on-azure/
