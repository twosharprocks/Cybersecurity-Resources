# The following is a series of scripts that can be used to find email addresses in text, then search for Active Directory users with matching emails and determine if they're enabled or disabled.
$text = Read-Host 'Paste the block of text to search for email addresses here:'
$emailPattern = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'
$matches = $text | Select-String -Pattern $emailPattern -AllMatches | ForEach-Object { $_.Matches.Value }
$emailAddresses = $matches -replace '(.+)', '"$1",'
Write-Host $emailAddresses
# Copy the output from above, but exclude the comma on the final line, then redefine $emailAddresses using 2.1 below;
## (2.1) Creating an "emailAddresses" variable if you already have the list formatted correctly
$emailAddresses = @(
"email1@company.co",
"email2@gmail.com",
"email3@notforprofit.org"
)
## (3) Search AD for users with email addresses found in $emailAddresses
foreach ($email in $emailAddresses) {
	$user = Get-ADUser -Filter
	if ($user -ne $null) {
	Write-Output "$email belongs to $($user.SamAccountName)"
	}
	else {
	Write-Output "$email does not match any user"
	}
}
## (4.1) Enabled AD Users with email addresses listed in the emailAddresses variable
write-host "--- Enabled Users found with matching email addresses ---"
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
## (4.2) Enabled AD Users from a specific Domain group (eg. Administrators) with email address matches 
#Define $ouPath for which Group to search (eg. Administrators, Office, Inactive, Resources, ect)
$ouPath = "OU=AdministratorsDC=int"
#Disabled users with matching emails
write-host "--- Users in $ouPath with matching email addresses ---"
write-host ""
#Filter and print user with description
foreach ($email in $emailAddresses) {
    $user = Get-ADUser -Filter {EmailAddress -eq $email} -SearchBase "OU=Administrators,OU=Users,OU=_Users & Groups,DC=acm,DC=int"
	if ($user.Enabled -eq $true) {
            Write-Host "Enabled - $($user.SamAccountName) Description: $($user.Description)"
        } else {
	Write-Host "Disabled - $($user.SamAccountName) Description: $($user.Description)"
	}
}
}
