# $policyDefinitionId = "78460a36-508a-49a4-b2b2-2f5ec564f4bb"
$subscriptionId = "/subscriptions/73d1976a-3d59-4c49-948e-847f08f43071"

$polDefName = "do-not-allow-deletion"
$polDefDisplayName = "Do not allow deletion of resources"
$polAssName = "do-not-allow-deletion"
$polAssDisplayName  = "Do not allow deletion of resources"


New-AzPolicyDefinition -Name $polDefName -DisplayName $polDefDisplayName -Policy ".\policies\doNotAllowDeletionPolicy.json"

$listOfResourceTypesDisallowedForDeletion = Get-Content .\allowedResourceTypesForDeletion.txt
$policyParameterObject = @{
    'listOfResourceTypesAllowedForDeletion' = $listOfResourceTypesDisallowedForDeletion
}

$policyParameter = @"
{
    "listOfResourceTypesAllowedForDeletion":  {
      "value": [
        "Microsoft.Compute/snapshots",
        "Microsoft.Compute/restorePointCollections",
        "Microsoft.MachineLearningServices/workspaces"
      ]
    }
}
"@


$policy = Get-AzPolicyDefinition -Custom | Where-Object {$_.name -eq "do-not-allow-deletion"}
 
New-AzPolicyAssignment -Name $polAssName -Scope $subscriptionId `
 -DisplayName $polAssDisplayName -PolicyDefinition $policy `
 -PolicyParameter $policyParameter


 