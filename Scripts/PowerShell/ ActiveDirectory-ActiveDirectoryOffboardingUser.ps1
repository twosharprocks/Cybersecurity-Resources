#Removing a user from their group memberships and updating their description
$user = 'username'
$updatedDescription = 'new user description eg. Terminated'
# Get the user object & update their description
Get-ADUser -Identity $user | Set-ADUser -description $updatedDescription
if ($user -eq $null) {
    Write-Host "User not found."
    exit
}
# Get the group memberships of the user
$userGroups = Get-ADPrincipalGroupMembership -Identity $user
#Loop through the user's group memberships and remove them, excluding "Domain Users"
foreach ($group in $userGroups) {
    if ($group.objectClass -eq 'group' -and $group.Name -ne "Domain Users") {
        # Use Try-Catch to handle any potential errors (e.g., if the user is not a member of the group)
        try {
            Remove-ADGroupMember -Identity $group -Members $user -Confirm:$false
            Write-Host "Removed $($user.SamAccountName) from $($group.Name)"
        } catch {
            Write-Host "Failed to remove $($user.SamAccountName) from $($group.Name)"
        }
    }
}
Write-Host "Group memberships (excluding 'Domain Users') removed from $user"
