#Specific username to offboard and the updated description
function move-user-offboarding {
    $user = read-host 'Username'
    $updatedDescription = read-host 'ICT Number and Date'
    # Do not edit anything below this
    Disable-ADAccount -Identity $user
    $destinationOU = "OU=Off Boarding,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
    #Hide user from Address Lists
    Set-ADUser -Identity $user -Replace @{msExchHideFromAddressLists="TRUE"}
    # Get the user object & update their description
    Get-ADUser -Identity $user | Set-ADUser -description $updatedDescription
    if ($user -eq $null) {
        Write-Host "User not found."
        exit
    }
    # Move the user to the new OU
    Get-ADUser -Identity $user | Move-ADObject -TargetPath $destinationOU
    # Get the group memberships of the user
    $userGroups = Get-ADPrincipalGroupMembership -Identity $user
    # Loop through the user's group memberships and remove them, excluding "Domain Users"
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
    Write-Host "$user moved to Off Boarding and Group memberships (excluding 'Domain Users') removed"
    }
    
