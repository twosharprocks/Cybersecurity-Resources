#List AD accounts assigned to a member group
function Find-GroupMembers {
$GroupName = Read-Host "Enter the member group name to search"
$OU = Read-Host "Enter the Organisational Unit to search"
$Users = Get-ADUser -Filter * -SearchBase $OU
foreach ($User in $Users) {
    # Check if the user is a member of the "Domain Users" group
    $isGroupMember = Get-ADGroupMember -Identity $GroupName -Recursive | Where-Object {$_.SamAccountName -eq $User.SamAccountName}
    if ($isGroupMember) {
        Write-Output "User $($User.SamAccountName) is a member of $GroupName"
    }
}
}