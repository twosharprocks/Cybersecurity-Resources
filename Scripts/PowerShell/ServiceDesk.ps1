#Check a laptop's battery health
powercfg /batteryreport /output "filepath eg. C:\Documents\Battery-Report.html"
###
#boot-time
# Remotely check another system's boot time
function boot-time { 
$servicetag = Read-Host "Enter service tag"
SystemInfo /s $servicetag | find "Boot Time:" 
}
boot-time
###
#free-space
function free-space { 
$servicetag = Read-Host "Enter service tag"
Invoke-Command -ComputerName $servicetag {Get-PSDrive C} | Select-Object PSComputerName,Used,Free
}
###
#Check E3 and E5 licences for a list of usernames
foreach ($username in $usernames) {
    # Get licenses for the user
    $userLicenses = Get-MsolUser -UserPrincipalName $username | Select-Object -ExpandProperty Licenses
    # Check if the user has both E3 and E5 licenses
    $hasE3 = $userLicenses.AccountSkuId -contains "your_E3_license_sku"
    $hasE5 = $userLicenses.AccountSkuId -contains "your_E5_license_sku"

    # Output results
    Write-Host "$username - E3: $hasE3, E5: $hasE5"
}
###
#clear-profiles
function clear-profiles {
    $computer = Read-Host "Please enter a computer name"    
    # Test network connection before making connection
    If ($computer -ne $Env:Computername) {
        If (!(Test-Connection -ComputerName $computer -Count 1 -Quiet)) {
            Write-Warning "$computer is not accessible, please try a different computer or verify it is powered on."
            return
        }
    }
    $continueRemoving = $true
    while ($continueRemoving) {
        # Gather all of the user profiles on the computer
        Try {
            [array]$users = Get-WmiObject -ComputerName $computer Win32_UserProfile -Filter "LocalPath Like 'C:\\Users\\%'" -ErrorAction Stop
        }
        Catch {
            Write-Warning "Error retrieving user profiles: $_"
            return
        }
        # Cache the number of users
        $num_users = $users.Count
        Write-Host -ForegroundColor Green "User profiles on $($computer):"        
        # Display all user profiles
        For ($i = 0; $i -lt $num_users; $i++) {
            Write-Host -ForegroundColor Green "$($i): $(($users[$i].LocalPath).Replace('C:\Users\',''))"
        }
        Write-Host -ForegroundColor Green "q: Quit"
        $validSelection = $false
        while (-not $validSelection) {
            # Prompt for user to select profiles to remove from computer
            $accountInput = Read-Host "Select numbers to delete local profiles (comma-separated) or 'q' to quit"            
            # Check if user selected to quit
            if ($accountInput -eq "q") {
                return
            }
            else {
                # Validate the input
                $accounts = @()
                foreach ($input in $accountInput -split ",") {
                    $trimmedInput = $input.Trim()
                    if ($trimmedInput -match "^\d+$" -and [int]$trimmedInput -lt $num_users) {
                        $accounts += [int]$trimmedInput
                    }
                }
                $validSelection = $accounts.Count -gt 0
                if (-not $validSelection) {
                    Write-Warning "Invalid selection, please try again."
                }
            }
        }
        # Confirm selection
        $confirm = Read-Host "Are you sure you want to delete the selected profiles? (Y/N)"
        if ($confirm -like "Y*") {
            # Remove the selected profiles
            foreach ($account in $accounts) {
                Write-Host -ForegroundColor Yellow "Deleting profile: $(($users[$account].LocalPath).Replace('C:\Users\',''))"
                Try {
                    ($users[$account]).Delete()
                    Write-Host -ForegroundColor Green "Profile: $(($users[$account].LocalPath).Replace('C:\Users\','')) has been deleted"
                }
                Catch {
                    Write-Warning "Failed to delete profile: $(($users[$account].LocalPath).Replace('C:\Users\','')). Error: $_"
                }
            }
        }
        # Configure yes choice
        $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Remove another profile."
        # Configure no choice
        $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Quit profile removal"
        # Determine Values for Choice
        $choice = [System.Management.Automation.Host.ChoiceDescription[]]@($yes, $no)
        # Determine Default Selection
        [int]$default = 0
        # Present choice option to user
        $userchoice = $host.ui.PromptForChoice("", "Remove Another Profile?", $choice, $default)
        if ($userchoice -eq 1) {
            $continueRemoving = $false
        }
    }
}
###
