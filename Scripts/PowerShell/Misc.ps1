#Check a laptop's battery health
powercfg /batteryreport /output "filepath eg. C:\Documents\Battery-Report.html"

#Check a system's boot time
SystemInfo /s ComputerIDHere | find "Boot Time:"

#Checking for E3 and E5 licences
foreach ($username in $usernames) {
    # Get licenses for the user
    $userLicenses = Get-MsolUser -UserPrincipalName $username | Select-Object -ExpandProperty Licenses
    # Check if the user has both E3 and E5 licenses
    $hasE3 = $userLicenses.AccountSkuId -contains "your_E3_license_sku"
    $hasE5 = $userLicenses.AccountSkuId -contains "your_E5_license_sku"

    # Output results
    Write-Host "$username - E3: $hasE3, E5: $hasE5"
}
