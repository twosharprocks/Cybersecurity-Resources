#This script 
Function DecodeUserAccountControl ([int]$UAC)
{
$UACPropertyFlags = @(
"SCRIPT",
"ACCOUNTDISABLE",
"RESERVED",
"HOMEDIR_REQUIRED",
"LOCKOUT",
"PASSWD_NOTREQD",
"PASSWD_CANT_CHANGE",
"ENCRYPTED_TEXT_PWD_ALLOWED",
"TEMP_DUPLICATE_ACCOUNT",
"NORMAL_ACCOUNT",
"RESERVED",
"INTERDOMAIN_TRUST_ACCOUNT",
"WORKSTATION_TRUST_ACCOUNT",
"SERVER_TRUST_ACCOUNT",
"RESERVED",
"RESERVED",
"DONT_EXPIRE_PASSWORD",
"MNS_LOGON_ACCOUNT",
"SMARTCARD_REQUIRED",
"TRUSTED_FOR_DELEGATION",
"NOT_DELEGATED",
"USE_DES_KEY_ONLY",
"DONT_REQ_PREAUTH",
"PASSWORD_EXPIRED",
"TRUSTED_TO_AUTH_FOR_DELEGATION",
"RESERVED",
"PARTIAL_SECRETS_ACCOUNT"
"RESERVED"
"RESERVED"
"RESERVED"
"RESERVED"
"RESERVED"
)
$Attributes = ""
1..($UACPropertyFlags.Length) | Where-Object {$UAC -bAnd [math]::Pow(2,$_)} | ForEach-Object {If ($Attributes.Length -EQ 0) {$Attributes = $UACPropertyFlags[$_]} Else {$Attributes = $Attributes + " | " + $UACPropertyFlags[$_]}}
Return $Attributes
}
$ReportPath = "\\Directory\Filepath\FolderReportIsWrittenInto"
$ReportDate = Get-Date -Format dd-MM-yyyy
$Users = Get-ADUser -Filter * -Properties CanonicalName, PasswordExpired, LastLogonDate, PasswordLastSet, PasswordNeverExpires, PasswordNotRequired, MemberOf, Description, Created, userAccountControl, CannotChangePassword, LockedOut, AccountExpirationDate
# Report arrays
$Legend = @()
$DisableUserReport = @()
$InactiveAccountsReport = @()
$UnusedAccountsReport = @()
$ExpiredAccountDateReport = @()
$ExpiredAccountPasswordReport = @()
$AllUserReport = @()
Foreach($User in $Users){
    $UserOU = $User.CanonicalName.Substring(0, $User.CanonicalName.LastIndexOf('/'))  
    If($User.PasswordLastSet){
        $PasswordExpiryDate = (Get-Date ($User.PasswordLastSet)).AddDays(90)
    }
    Elseif($User.PasswordLastSet = $null){
        $PasswordExpiryDate = "NULL"
    }
    $UAC = DecodeUserAccountControl($User.userAccountControl)
    $AllUserReport += New-Object PSObject -Property ([ordered]@{
        'Username' = $User.SamAccountName
        'Name' = $User.Name
        'Description' = $User.Description
        'OU' = $UserOU
        'Creation Date' = $User.Created
        'Password Last Set' = $User.PasswordLastSet
        'Password Expiration Date' = $PasswordExpiryDate
        'User Account Control' = $UAC
        'Last Logon' = $User.LastLogonDate
        'Account Enabled' = $User.Enabled
        'Password Not Required' = $User.PasswordNotRequired
        'Password Never Expires' = $User.PasswordNeverExpires
        'Password Cannot Change' = $User.CannotChangePassword
        'Account Locked Out' = $User.LockedOut
        'Account Expiration' = $User.AccountExpirationDate
    })
    # Disabled accounts
    If($User.Enabled -eq $false){
        $DisableUserReport += New-Object PSObject -Property ([ordered]@{
            'Username' = $User.SamAccountName
            'Name' = $User.Name
            'Description' = $User.Description
            'OU' = $UserOU
            'Creation Date' = $User.Created
            'Password Last Set' = $User.PasswordLastSet
            'Password Expiration Date' = $PasswordExpiryDate
            'Password Expired' = $User.PasswordExpired
            'User Account Control' = $UAC
            'Last Logon' = $User.LastLogonDate
            'Account Enabled' = $User.Enabled
            'Password Not Required' = $User.PasswordNotRequired
            'Password Never Expires' = $User.PasswordNeverExpires
            'Password Cannot Change' = $User.CannotChangePassword
            'Account Locked Out' = $User.LockedOut
            'Account Expiration' = $User.AccountExpirationDate
        })
    }
    # Inactive accounts
    If($User.LastLogonDate -lt (Get-Date).AddDays(-365) -and !($User.LastLogonDate -eq $null)){
        $InactiveAccountsReport += New-Object PSObject -Property ([ordered]@{
            'Username' = $User.SamAccountName
            'Name' = $User.Name
            'Description' = $User.Description
            'OU' = $UserOU
            'Creation Date' = $User.Created
            'Password Last Set' = $User.PasswordLastSet
            'Password Expiration Date' = $PasswordExpiryDate
            'Password Expired' = $User.PasswordExpired
            'User Account Control' = $UAC
            'Last Logon' = $User.LastLogonDate
            'Account Enabled' = $User.Enabled
            'Password Not Required' = $User.PasswordNotRequired
            'Password Never Expires' = $User.PasswordNeverExpires
            'Password Cannot Change' = $User.CannotChangePassword
            'Account Locked Out' = $User.LockedOut
            'Account Expiration' = $User.AccountExpirationDate
        })
    }
    # Unused accounts
    If($User.LastLogonDate -eq $null){
        $UnusedAccountsReport += New-Object PSObject -Property ([ordered]@{
            'Username' = $User.SamAccountName
            'Name' = $User.Name
            'Description' = $User.Description
            'OU' = $UserOU
            'Creation Date' = $User.Created
            'Password Last Set' = $User.PasswordLastSet
            'Password Expiration Date' = $PasswordExpiryDate
            'Password Expired' = $User.PasswordExpired
            'User Account Control' = $UAC
            'Last Logon' = $User.LastLogonDate
            'Account Enabled' = $User.Enabled
            'Password Not Required' = $User.PasswordNotRequired
            'Password Never Expires' = $User.PasswordNeverExpires
            'Password Cannot Change' = $User.CannotChangePassword
            'Account Locked Out' = $User.LockedOut
            'Account Expiration' = $User.AccountExpirationDate
        })
    }
    # Expired dates
    If($User.AccountExpirationDate -lt (Get-Date) -and !($User.AccountExpirationDate -eq $null)){
        $ExpiredAccountDateReport += New-Object PSObject -Property ([ordered]@{
            'Username' = $User.SamAccountName
            'Name' = $User.Name
            'Description' = $User.Description
            'OU' = $UserOU
            'Creation Date' = $User.Created
            'Password Last Set' = $User.PasswordLastSet
            'Password Expiration Date' = $PasswordExpiryDate
            'Password Expired' = $User.PasswordExpired
            'User Account Control' = $UAC
            'Last Logon' = $User.LastLogonDate
            'Account Enabled' = $User.Enabled
            'Password Not Required' = $User.PasswordNotRequired
            'Password Never Expires' = $User.PasswordNeverExpires
            'Password Cannot Change' = $User.CannotChangePassword
            'Account Locked Out' = $User.LockedOut
            'Account Expiration' = $User.AccountExpirationDate
        })
    }
    # Expired Password
    If($User.PasswordExpired -eq $true){
        $ExpiredAccountPasswordReport += New-Object PSObject -Property ([ordered]@{
            'Username' = $User.SamAccountName
            'Name' = $User.Name
            'Description' = $User.Description
            'OU' = $UserOU
            'Creation Date' = $User.Created
            'Password Last Set' = $User.PasswordLastSet
            'Password Expiration Date' = $PasswordExpiryDate
            'Password Expired' = $User.PasswordExpired
            'User Account Control' = $UAC
            'Last Logon' = $User.LastLogonDate
            'Account Enabled' = $User.Enabled
            'Password Not Required' = $User.PasswordNotRequired
            'Password Never Expires' = $User.PasswordNeverExpires
            'Password Cannot Change' = $User.CannotChangePassword
            'Account Locked Out' = $User.LockedOut
            'Account Expiration' = $User.AccountExpirationDate
        })
    }
}
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "All Users"
    'Purpose' = "All users in AD"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Disabled Users"
    'Purpose' = "Accounts that are disabled (enabled = false)"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Unused-No Logon Users"
    'Purpose' = "Users with the LastLogonDate field set to NULL"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Inactive Users"
    'Purpose' = "Users with the LastLogonDate field a year ago from date of running"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Expired Users"
    'Purpose' = "Users with the account expiration date past the date of running"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Password Expired Users"
    'Purpose' = "Users with an expired password"
})
$Groups = Get-ADGroup -Filter * -Properties CanonicalName, Created, Member, Modified, mail
# Report array
$AllGroupsReport = @()
$EmptyGroupsReport = @() 
$MaxTwoMemberGroupsReport = @()
$GroupsModified365DaysAgoReport = @()
Foreach($Group in $Groups){
    $GroupOU = $Group.CanonicalName.Substring(0, $Group.CanonicalName.LastIndexOf('/'))
    $MemberCount = $Group.Member.Count
    $AllGroupsReport += New-Object PSObject -Property ([ordered]@{
        'Group Name' = $Group.Name
        'Group Username' = $Group.SamAccountName
        'Group OU' = $GroupOU
        'Group Type' = $Group.GroupCategory
        'Group Scope' = $Group.GroupScope
        'Created Date' = $Group.Created
        'Modified Date' = $Group.Modified
        'Mail Address (if DL)' = $Group.Mail
        'Member Count' = $MemberCount
    })
    If($MemberCount -eq 0)
    {
        $EmptyGroupsReport += New-Object PSObject -Property ([ordered]@{
            'Group Name' = $Group.Name
            'Group Username' = $Group.SamAccountName
            'Group OU' = $GroupOU
            'Group Type' = $Group.GroupCategory
            'Group Scope' = $Group.GroupScope
            'Created Date' = $Group.Created
            'Modified Date' = $Group.Modified
            'Mail Address (if DL)' = $Group.Mail
            'Member Count' = $MemberCount
        })
    }
    If($MemberCount -lt 3 -and !($MemberCount -eq 0))
    {
        $MaxTwoMemberGroupsReport += New-Object PSObject -Property ([ordered]@{
            'Group Name' = $Group.Name
            'Group Username' = $Group.SamAccountName
            'Group OU' = $GroupOU
            'Group Type' = $Group.GroupCategory
            'Group Scope' = $Group.GroupScope
            'Created Date' = $Group.Created
            'Modified Date' = $Group.Modified
            'Mail Address (if DL)' = $Group.Mail
            'Member Count' = $MemberCount
        })
    }
    If($Group.Modified -lt (Get-Date).AddDays(-365))
    {
        $GroupsModified365DaysAgoReport += New-Object PSObject -Property ([ordered]@{
            'Group Name' = $Group.Name
            'Group Username' = $Group.SamAccountName
            'Group OU' = $GroupOU
            'Group Type' = $Group.GroupCategory
            'Group Scope' = $Group.GroupScope
            'Created Date' = $Group.Created
            'Modified Date' = $Group.Modified
            'Mail Address (if DL)' = $Group.Mail
            'Member Count' = $MemberCount
        })
    }
}
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "All Groups"
    'Purpose' = "All groups in AD"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Empty Groups"
    'Purpose' = "Groups with no members"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Groups Members < 2"
    'Purpose' = "Groups with less than 2 members"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Groups Modified > 365 Days"
    'Purpose' = "Groups modified over a year ago"
})
$Computers = Get-ADComputer -Filter * -Properties CanonicalName, Created, Enabled, Modified, LastLogonDate, OperatingSystem, OperatingSystemVersion
# Computer report arrays
$AllComputers = @()
$AllWorkstations = @()
$AllServers = @()
$DisabledComputers = @()
$InactiveComputers = @()
$NoLogonComputers = @()
Foreach($Computer in $Computers)
{
    $ComputerOU = $Computer.CanonicalName.Substring(0, $Computer.CanonicalName.LastIndexOf('/'))

    $AllComputers += New-Object PSObject -Property ([ordered]@{
        'Name' = $Computer.Name
        'OU' = $ComputerOU
        'Created Date' = $Computer.Created
        'Modified Date' = $Computer.Modified
        'Enabled' = $Computer.Enabled
        'Last Logon Date' = $Computer.LastLogonDate
        'OS' = $Computer.OperatingSystem
        'OS Version' = $Computer.OperatingSystemVersion
    })

    If($Computer.Enabled -eq $false)
    {
        $DisabledComputers += New-Object PSObject -Property ([ordered]@{
            'Name' = $Computer.Name
            'OU' = $ComputerOU
            'Created Date' = $Computer.Created
            'Modified Date' = $Computer.Modified
            'Enabled' = $Computer.Enabled
            'Last Logon Date' = $Computer.LastLogonDate
            'OS' = $Computer.OperatingSystem
            'OS Version' = $Computer.OperatingSystemVersion
        })
    }
    If($Computer.LastLogonDate -lt (Get-Date).AddDays(-90) -and !($Computer.LastLogonDate -eq $null))
    {
        $InactiveComputers += New-Object PSObject -Property ([ordered]@{
            'Name' = $Computer.Name
            'OU' = $ComputerOU
            'Created Date' = $Computer.Created
            'Modified Date' = $Computer.Modified
            'Enabled' = $Computer.Enabled
            'Last Logon Date' = $Computer.LastLogonDate
            'OS' = $Computer.OperatingSystem
            'OS Version' = $Computer.OperatingSystemVersion
        })
    }
    If($Computer.LastLogonDate -eq $null)
    {
        $NoLogonComputers += New-Object PSObject -Property ([ordered]@{
            'Name' = $Computer.Name
            'OU' = $ComputerOU
            'Created Date' = $Computer.Created
            'Modified Date' = $Computer.Modified
            'Enabled' = $Computer.Enabled
            'Last Logon Date' = $Computer.LastLogonDate
            'OS' = $Computer.OperatingSystem
            'OS Version' = $Computer.OperatingSystemVersion
        })
    }
}
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "All Computers"
    'Purpose' = "All computers in AD"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Disabled Computers"
    'Purpose' = "Computers that are not enabled"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "Inactive Computers"
    'Purpose' = "Computers with logon date over a year ago"
})
$Legend += New-Object PSObject -Property ([ordered]@{
    'Worksheet Name' = "No Logon Computers"
    'Purpose' = "Computers with no logon date"
})
$Legend | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Legend"
$AllUserReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "All Users"
$DisableUserReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Disabled Users"
$UnusedAccountsReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Unused-No Logon Users"
$InactiveAccountsReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Inactive Users"
$ExpiredAccountDateReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Expired Users"
$ExpiredAccountPasswordReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Password Expired Users"
$AllGroupsReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "All Groups"
$EmptyGroupsReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Empty Groups"
$MaxTwoMemberGroupsReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Groups Members < 2"
$GroupsModified365DaysAgoReport | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Groups Modified > 365 Days"
$AllComputers | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "All Computers"
$DisabledComputers | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Disabled Computers"
$InactiveComputers | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "Inactive Computers"
$NoLogonComputers | Export-Excel "$ReportPath\$ReportDate - AD Report.xlsx" -WorksheetName "No Logon Computers"
