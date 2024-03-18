# The following is a series of scripts that can be used to:
# (1) Find email addresses in a large amount of text, 
# (2) Format those email addresses so PowerShell can search for them in Active Directory
# (3) Search AD for users with those email addresses inside different OUs & if they're enabled/disabled
---
## (1) Find emails in text
#Text you want to search for email addresses
$text = @"
Copy and paste in here the text you want to search for email addresses
"@
# Regular expression pattern for finding email addresses
$emailPattern = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'
# Use Select-String to find email addresses in the text
$matches = $text | Select-String -Pattern $emailPattern -AllMatches | ForEach-Object { $_.Matches.Value }
---
## (2) Format emails so PowerShell can search for them in Active Directory
#Add " to the start and ," to the end of each line
$emailAddresses = $matches -replace '(.+)', '"$1",'
# Display the emailAddresses variable
Write-Host $emailAddresses
---
## (2.1) Creating an "emailAddresses" variable if you already have the list formatted correctly
$emailAddresses = @(
"email1@company.co",
"email2@gmail.com",
"email3@notforprofit.org"
)
---
## (3.1) Enabled AD Users with email addresses listed in the emailAddresses variable
write-host "--- Enabled Users with emails matches ---"
write-host ""
foreach ($email in $emailAddresses) {
    $user = Get-ADUser -Filter {EmailAddress -eq $email} -Properties Enabled
	if ($user) {
        if ($user.Enabled -eq $true) {
            Write-Host "Enabled - $email is $user.identity"
        } else {}
    } else {
        Write-Host "$email not found in Active Directory."
    }
}
---
## (3.2) Enabled AD Users from a specific Domain group (eg. Administrators) with email address matches 
#Define $ouPath for which Group to search (eg. Administrators, Office, Inactive, Resources, ect)
$ouPath = "OU=Administrators,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
#Disabled users with matching emails
write-host ""
write-host "--- Enabled Users in $ouPath with matching email addresses ---"
write-host ""
#Filter and print user with description
foreach ($email in $emailAddresses) {
    $user = Get-ADUser -Filter {EmailAddress -eq $email} -SearchBase "OU=Administrators,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
	if ($user.Enabled -eq $true) {
            Write-Host "User: $($user.SamAccountName) Description: $($user.Description)"
        } else {}
}
