function Edit-ADUser {
    $NewUser = Read-Host "Enter the new user's pre-2000 username"
    $sourceUser = Read-Host "Enter the source user's pre-2000 username"
    $manager = Read-Host "Enter the manager's pre-2000 username"
    $jobtitle = Read-Host "Enter the user's job title"
    $department = Read-Host "Enter the user's department or site name for Jo's"    
    #Address selection
    Write-host "Select the user's office (or select 0 to manually input address details)"
    Write-host "1: CITY1 - Address"
    Write-host "2: CITY2 - Address"
    Write-host "3: CITY3 - Address"
    Write-host "4: CITY4 - Address"
    Write-host "5: CITY5 - Address"
    Write-host "6: CITY6 - Address"
    Write-host "7: CITY7 - Address"
    Write-host "8: CITY8 - Address"
    Write-host "9: CITY9 - Address"
    Write-host "0: Manually input address details"
    $officeChoice = Read-host "Enter option number"    
    switch ($officeChoice) {
        0 { $office = Read-Host "Enter the user's city (ALL CAPS)"
            $streetAddress = Read-Host "Enter the user's street address"
            $city = Read-Host "Enter the user's city"
            $postalCode = Read-Host "Enter the user's postcode"        }
        1 { $office = 'CITY1 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        2 { $office = 'CITY2 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        3 { $office = 'CITY3 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        4 { $office = 'CITY4 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        5 { $office = 'CITY5 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        6 { $office = 'CITY6 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        7 { $office = 'CITY7 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        8 { $office = 'CITY8 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
        9 { $office = 'CITY9 - Address'
            $streetAddress = 'Address'
            $city = 'city'
            $postalCode = '00000'        }
    }
    # Home Directory Creation
    $ADIdentity = Get-ADUser -Identity $NewUser
    $BasePath = "\\dc.int\UserFiles\HomeDirectory\"
    $HomeDirectory = $BasePath + $ADIdentity.SamAccountName   
    # Copy Group Permissions from sourcename to New User
    Set-ADUser -Identity $NewUser -Office $office -department $department -streetAddress $streetAddress -state STATE -city $city -PostalCode $postalCode -description $jobtitle -title $jobtitle -company "Company Name" -Replace @{c="COUNTRYCODE";wWWHomePage="http:\\www.companyname.org"} -HomeDirectory $HomeDirectory -HomeDrive "NetworkDrive:" -manager $manager   
    $sourceGroups = Get-ADUser -Identity $sourceUser -Properties MemberOf | Select-Object -ExpandProperty MemberOf
    foreach ($group in $sourceGroups) {
        # Add the group to the target user
        Add-ADGroupMember -Identity $group -Members $NewUser
    }    
    Write-Host "Details and Membership groups added to $NewUser in Active Directory"
}
