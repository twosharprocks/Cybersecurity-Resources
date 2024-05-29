#Set or change an employeeID
function set-employeeID {
    $username = Read-Host "Enter username to add employeeID to"
    $employeeID = Read-Host "Enter employeeID for $username"
    Set-ADUser -Identity $username -Replace @{employeeID="$employeeID"}
    }
#Set or change "workdays" (or any other user attirbute)
function set-UserAttribute {
    $username = Read-Host "Enter username to add workdays to"
    $workdays = Read-Host "Enter user's work days"
    Set-ADUser -Identity $username -Replace @{extensionAttribute10="$workdays"}
    }
#Edit a mailbox
function edit-mailbox {
    $NewMailbox = Read-Host 'Enter the username of the new shared mailbox'
    $description = Read-Host 'Enter the mailbox description'
    $office = "Office name here"
    $department = "Add Department here" 
    $streetAddress = "Add address here"
    $city = 'City name here'
    $postalCode = 'Postcode here'
    #Code starts here - do not edit below this point
    Set-ADUser -Identity $NewMailbox -Office $office -department $department -streetAddress $streetAddress -state STATE -city $city -PostalCode $postalCode -description $description -title $description -company "Company Name" -Replace @{c="AU";wWWHomePage="http:\\www.websitehere.com"}
    write-host "Details added to $NewMailbox in Active Directory"
    }
#Find AD accounts from a list of display names
$text = Read-Host "Paste list of display names here:"
$displayNameList = $text -replace '(.+)', '"$1",'
$ouPath = Read-Host "Enter OU to search"
foreach ($displayName in $displayNameList) {
    $user = Get-ADUser -Filter { DisplayName -eq $displayName } -SearchBase $ouPath
    if ($user) {
        Write-Host "'$displayName' matches $user in $ouPath"
    } else {
        Write-Host "'$displayName' not found in $ouPath"
    }
}