#After creating a user, set attributes to the account in AD
$NewUser = 'username'
$employeeID = "employeeIDhere"
$sourceUser = 'otherUserToDrawPermissionsFrom' #Reference the pre-2000 username
$manager = 'usersManager' #Reference the pre-2000 username
$jobtitle = 'jobtitle'
$office = "Office Address"
$department = "user's department"
$streetAddress = "Address"
$city = 'city'
$postalCode = 'postcode'
#Set attributes below that are standard for all users 
Set-ADUser -Identity $NewUser -Office $office -department $department -streetAddress $streetAddress -state SA -city $city -PostalCode $postalCode -description $jobtitle -title $jobtitle -manager $manager -company "Company Name" -employeeID $employeeID -Replace @{c="CountryCode";wWWHomePage="http:\\www.companywebsite.com"} -HomeDirectory $HomeDirectory -HomeDrive "F:"
#Create a Home Directory Variable
$ADIdentity = Get-ADUser -Identity $NewUser
$BasePath = "\\DomainController\UserFiles\HomeDirectory\"
$HomeDirectory = $BasePath + $ADIdentity.SamAccountName
#Copy Group Permissions from sourceUser to NewUser
$sourceGroups = Get-ADUser -Identity $sourceUser -Properties MemberOf | Select-Object -ExpandProperty MemberOf
foreach ($group in $sourceGroups) {
   # Add the group to the target user
   Add-ADGroupMember -Identity $group -Members $NewUser
}
# End of AD Onboarding
