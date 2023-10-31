#New User AD Attributes below
$NewUser = 'username'
$sourceUser = 'userToDrawPermissionsFrom' #Reference the pre-2000 username
$manager = 'usersManager' #Reference the pre-2000 username
$jobtitle = 'jobtitle'
$office = "Office Address"
$department = "user department"
$streetAddress = "Adrress"
$city = 'city'
$postalCode = 'postcode'

#Code starts here - do not edit below this point
#Create a Home Directory Variable
$ADIdentity = Get-ADUser -Identity $NewUser
$BasePath = "\\DomainController\UserFiles\HomeDirectory\"
$HomeDirectory = $BasePath + $ADIdentity.SamAccountName

#Copy Group Permissions from sourcename to New User
Set-ADUser -Identity $NewUser -Office $office -department $department -streetAddress $streetAddress -state SA -city $city -PostalCode $postalCode -description $jobtitle -title $jobtitle -manager $manager -company "Company Name" -Replace @{c="CountryCode";wWWHomePage="http:\\www.companywebsite.com"} -HomeDirectory $HomeDirectory -HomeDrive "H:"
$sourceGroups = Get-ADUser -Identity $sourceUser -Properties MemberOf | Select-Object -ExpandProperty MemberOf
foreach ($group in $sourceGroups) {
   # Add the group to the target user
   Add-ADGroupMember -Identity $group -Members $NewUser
}
# End of AD Onboarding