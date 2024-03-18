#List all Disabled Users in a specific OU (eg. "Office Users")
#Specify the distinguished name of the OU where the group is located
$ou = "OU=Office Users,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
	write-host ""
	write-host "--- Disabled Accounts in Office Users (This user should be in Inactive or Offboarding)---"
	write-host ""
# Retrieve all disabled users in the specified OU
$disabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties Description -SearchBase $ou
# Iterate through the disabled users and print their descriptions
foreach ($user in $disabledUsers) {
    Write-Host "User: $user.identity $($user.SamAccountName) Description: $($user.Description)"
}
###
#List all Office Users missing an EmployeeID
# Specify the OU path
$ouPath = "OU=Office Users,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
Write-Host "Office Users without EmployeeID"
# Get users in the specified OU without an EmployeeID
$usersWithoutEmployeeID = Get-ADUser -Filter {EmployeeID -notlike "*"} -SearchBase $ouPath -Properties EmployeeID
# Display the results
foreach ($user in $usersWithoutEmployeeID) {
	Write-Host "$($user.SAMAccountName) - $user"
}
###
#Office Users who have not been logged in for 6 months or more
$ouPath = "OU=Office Users,OU=Users,OU=_Users & Groups,DC=acm,DC=int" 
$sixMonthsAgo = (Get-Date).AddMonths(-6)
# Get users from the specified OU who have not logged in for 6 months or more
$users = Get-ADUser -Filter {
    LastLogonDate -lt $sixMonthsAgo -and
    Enabled -eq $true
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
# Display the results
$users | Format-Table -AutoSize
###
#Students who have not been logged in for 1 month or more
$ouPath = "OU=Students,OU=Users,OU=_Users & Groups,DC=acm,DC=int" 
$OneMonthAgo = (Get-Date).AddMonths(-1)
# Get users from the specified OU who have not logged in for 6 months or more
$users = Get-ADUser -Filter {
    LastLogonDate -lt $OneMonthAgo -and
    Enabled -eq $true
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
# Display the results
$users | Format-Table -AutoSize
###
#Disable every account in a specific OU (eg. “Inactive”)
$ouPath = "OU=Inactive Users,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
# Get a list of user accounts in the specified OU
$inactiveUsers = Get-ADUser -Filter * -SearchBase $ouPath
# Disable each user account in the OU
foreach ($user in $inactiveUsers) {
    Disable-ADAccount -Identity $user
    Set-ADUser -Identity $user
	Write-Host "Disabled user account: $($user.SamAccountName)"
}
###
#From an $employeeIDList show if matching accounts are enabled or disabled
foreach ($employeeID in $employeeIDList) {
    $adUser = Get-ADUser -Filter {EmployeeID -eq $employeeID} -Properties Enabled
    if ($adUser) {
        $isEnabled = $adUser.Enabled
        Write-Host "Employee ID: $employeeID - Account $adUser Enabled: $isEnabled"
    } else {
        Write-Host "Employee ID: $employeeID - Account not found in Active Directory"
    }
}
###
#Enable/Disable all the usernames in a list (eg. $usernames)
