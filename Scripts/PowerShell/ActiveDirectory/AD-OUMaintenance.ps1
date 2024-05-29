#List Any Disabled users in the "Office Users" OU
function Find-Disabled-Office {
$ouPath = "OU=Office Users,DC=int" 
$OfficeUsers = Get-ADUser -Filter {
    Enabled -eq $false
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
Write-host "Disabled Users in OU=Office Users (Check for an offboarding ticket in Jira - Move to Off Boarding?)"
$OfficeUsers | Format-Table -AutoSize
write-host "#####"
}
###
#List Enabled users in the "Inactive Users" OU
function Find-Enabled-Inactive { 
$ouPath = "OU=Inactive Users,DC=int" 
$EnabledInactive = Get-ADUser -Filter {
    Enabled -eq $true
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
Write-host "Enabled Users in OU=Inactive Users (Check for notification of Leave in Jira - Disable? Or move to Office Users?)"
$EnabledInactive | Format-Table -AutoSize
write-host "#####"
}
###
#List Enabled users in the "Offboarding" OU
function Find-Enabled-Offboarding { 
$ouPath = "OU=Off Boarding,DC=int" 
$EnabledOffboarding = Get-ADUser -Filter {
    Enabled -eq $true
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
Write-host "Enabled Users in OU=Off Boarding (Check for an offboarding ticket in Jira - Disable? Or move to Office Users?)"
$EnabledOffboarding | Format-Table -AutoSize
write-host "#####"
}
###
#Office Users who have not been logged in for 6 months or more
function Find-NoLogin6mo {
$ouPath = "OU=Office Users,DC=int" 
$sixMonthsAgo = (Get-Date).AddMonths(-6)
# Get users from the specified OU who have not logged in for 6 months or more
$users = Get-ADUser -Filter {
    LastLogonDate -lt $sixMonthsAgo -and
    Enabled -eq $true
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
# Display the results
$users | Format-Table -AutoSize
}
###
#Students who have not been logged in for 1 month or more
function Find-StudentNoLogin {
$ouPath = "OU=Students,DC=int" 
$OneMonthAgo = (Get-Date).AddMonths(-1)
$users = Get-ADUser -Filter {
    LastLogonDate -lt $OneMonthAgo -and
    Enabled -eq $true
} -SearchBase $ouPath -Properties LastLogonDate,Enabled | Select-Object SamAccountName,LastLogonDate,Enabled
$users | Format-Table -AutoSize 
}
###
#Disable every account in a specific OU (eg. “Inactive”)
function disable-inactive {
$ouPath = "OU=Inactive Users,DC=int"
# Get a list of user accounts in the specified OU
$inactiveUsers = Get-ADUser -Filter * -SearchBase $ouPath
# Disable each user account in the OU
foreach ($user in $inactiveUsers) {
    Disable-ADAccount -Identity $user
    Set-ADUser -Identity $user
	Write-Host "Disabled user account: $($user.SamAccountName)"
} }
###
# List Groups Assigned to Offboarded Users and Remove all groups Except "Domain Users"
function Remove-OffboardingGroups {
$ouPath = "OU=Off Boarding,DC=int"
$users = Get-ADUser -Filter * -SearchBase $ouPath
# Iterate each user
foreach ($user in $users) {  
    # Get groups that the user is a member of
    $userGroups = Get-ADUser $user | Get-ADPrincipalGroupMembership | Where-Object { $_.Name -ne "Domain Users" -and $_.Name -notlike "Group_*" } | Select-Object Name    
    if ($userGroups.Count -gt 0) {
        # Display groups
        Write-Host "Groups:"
        $userGroups | ForEach-Object {
            Write-Host " - $($_.Name)"
        }
        # Removing user from non-"Domain Users" groups
        $confirm = Read-Host "Remove $($user.Name) from all groups except 'Domain Users'? (Y/N)"
        if ($confirm -eq "Y" -or $confirm -eq "y") { 
				$userGroups | ForEach-Object {
                Remove-ADGroupMember -Identity $_.Name -Members $user -confirm:$false -erroraction SilentlyContinue
                Write-Host "Removed $($user.Name) from $($_.Name)"
            } }
        }
    }
}
###
#List users in "OU=Offboarding" who have not been modified for >3months
function Find-Offboarded-unmodified {
Write-host "Users in OU=Off Boarding not modified for >3months (Delete from AD)"
$ouPath = "OU=Off Boarding,DC=int"
$thresholdDate = (Get-Date).AddMonths(-3)
$OffboardedUnmodified = Get-ADUser -Filter * -SearchBase $ouPath -Properties * | Where-Object { $_.whenChanged -lt $thresholdDate }
if ($users) {
    $users | Select-Object SamAccountName, whenChanged
	$confirmation = Read-Host "Do you want to delete offboarded user accounts older than 3 months? (yes/no)"
    if ($confirmation -eq "yes") {
        foreach ($user in $OffboardedUnmodified) {
            Remove-ADUser -Identity $user -Confirm:$false
            Write-Host "User $($user.Name) has been deleted."
        }}
} else {
    Write-Host "No users last modified >3 months ago."
} }
write-host "#####"
###
#Show if accounts in $employeeIDList are enabled or disabled
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
#List all Office Users missing an EmployeeID
function Find-NoEmployeeID {
$ouPath = "OU=Office Users,DC=int"
Write-Host "Office Users without EmployeeID"
$usersWithoutEmployeeID = Get-ADUser -Filter {EmployeeID -notlike "*"} -SearchBase $ouPath -Properties EmployeeID
foreach ($user in $usersWithoutEmployeeID) {
	Write-Host "$($user.SAMAccountName) - $user"
} }
###
#New Employee List from Payroll - Finding Missing employeeIDs
function find-missing-employeeIDs {
$excelFilePath = Read-Host "Provide full filepath to New Employee Report" 
$worksheetName = "New Employees Report"
$columnName = "Emp No"
$newusers = Import-Excel -Path $excelFilePath -WorksheetName $worksheetName | Select-Object -ExpandProperty $columnName
$employeeIdList = $newusers -replace '(.+),$', '"$1"'
Get-ADUser -Filter {employeeID -eq $employeeIdList} -Properties Enabled,employeeID
foreach ($employeeID in $employeeIDList) {
    # Get the user based on employeeID
    $user = Get-ADUser -Filter {employeeID -eq $employeeID}
    # Check if the user exists
    if ($user) {
        if (-not $user.Enabled) { Write-Host "Disabled - $($employeeID) is $user."} 
		else { }
    } else { Write-Host "User with employeeID $employeeID not found in Active Directory." 
			$username = Read-Host "Enter Username to assign this EmployeeID"
			Set-ADUser -Identity "$username" -Replace @{employeeID=$employeeID}
			} }
}
###
#Terminated Employee List from Payroll - Finding Active Users who no longer work for UC
function find-terminated-users {
$excelFilePath = Read-Host "Provide full filepath to Terminated Employee Report" 
$worksheetName = "Terminated Employees Report"
$columnName = "Emp No"
$terminated = Import-Excel -Path $excelFilePath -WorksheetName $worksheetName | Select-Object -ExpandProperty $columnName
#
$employeeIdList = $terminated -replace '(.+),$', '"$1"'
Get-ADUser -Filter {employeeID -eq $employeeIDList} -Properties Enabled,employeeID
foreach ($employeeID in $employeeIDList) {
    $user = Get-ADUser -Filter {employeeID -eq $employeeID}
    # Check if the user exists
    if ($user) {
        if (-not $user.Enabled) { } 
		else {Write-Host "Enabled - $($employeeID) is $user." 
		$action = Read-Host "Disable this account? (y/n)"}
		if ($action -eq 'y') {
		Disable-ADAccount -Identity $user
		Write-Host "$user account disabled" 
		}
		else { }
		}
    } else { Write-Host "User with employeeID $employeeID not found in Active Directory." }
}