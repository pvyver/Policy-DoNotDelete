$subscriptionId = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

#region policy definition
$polDefName = "do-not-allow-deletion"
$polDefDisplayName = "Do not allow deletion of resources"

New-AzPolicyDefinition -Name $polDefName -DisplayName $polDefDisplayName -Policy ".\policies\doNotAllowDeletionPolicy.json"
#region policy definition


#region policy assignment
$polAssName = "do-not-allow-deletion"
$polAssDisplayName  = "Do not allow deletion of resources"

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

#endregion policy assignment

 