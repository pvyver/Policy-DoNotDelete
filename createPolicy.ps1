#region create policy definition
$polDefName = "do-not-allow-deletion"
$polDefDisplayName = "Do not allow deletion of resources"

New-AzPolicyDefinition -Name $polDefName -DisplayName $polDefDisplayName -Policy ".\policies\doNotAllowDeletionPolicy.json"
#region create policy definition
