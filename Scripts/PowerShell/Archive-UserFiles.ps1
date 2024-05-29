#Create an archive for user files, search directories for folders titled with variations of the user's name, 
#then offer to copy/delete/ignore the files to the recently created archive
function New-Archive {
    $firstName = Read-Host "Enter User First Name"
    $lastName = Read-Host "Enter User Last Name"
    function New-Folders {
        param(
            [string]$firstName,
            [string]$lastName
        )
    $currentdate = Get-Date
    $targetdate = $currentDate.Addmonths(2)
    $basePath = "\\fsfs02\Archived$"
    $folderName = "{0:yyyy-MM-dd}_{1}_{2}" -f $targetDate, $firstName, $lastName
        New-Item -ItemType Directory -Path (Join-Path $basePath $folderName) -ErrorAction SilentlyContinue
        New-Item -ItemType Directory -Path (Join-Path (Join-Path $basePath $folderName) "Home Folder") -ErrorAction SilentlyContinue
        New-Item -ItemType Directory -Path (Join-Path (Join-Path $basePath $folderName) "Folder Redirect") -ErrorAction SilentlyContinue
    }
    New-Folders -firstName $firstName -lastName $lastName
    #Construct the naming patterns
    $pattern1 = "$firstName.$lastName"
    $pattern2 = "$($firstName[0])$lastName"
    $pattern3 = "$firstName$($lastName[0])"
    # Define the directories to search in
    $directoriesToSearch = @(
        "\\dc.int\folder\UserFiles\HomeDirectory",
        "C:\Users",
        "\\dc.int\folder\UserFiles\CitrixRedirected",
        "D:\FldRdr",
        "\\fsctxfile01\D$\FSLogix\FSLOffice",
        "\\fsctxfile01\D$\FSLogix\FSLProfile"
    )
    # Iterate through each directory
    foreach ($directory in $directoriesToSearch) {
        # Check the directory exists
        if (Test-Path $directory -PathType Container) {
            # Iterate naming patterns
            foreach ($pattern in $pattern1, $pattern2, $pattern3) {
                # Construct the full path
                $fullPath = Join-Path -Path $directory -ChildPath $pattern
                # Check if the folder exists
                if (Test-Path $fullPath -PathType Container) {
                    Write-Host "Found folder: $fullPath"
                    # Ask copy, delete, ignore, or just delete
                    $action = Read-Host "Do you want to (C)opy and delete, (D)elete only, (I)gnore, or take no action? (C/D/I/N)"
                    if ($action -eq 'C' -or $action -eq 'c') {
                        # Ask the user for the destination directory
                        $destinationDirectory = Read-Host "Enter the destination directory for $($fullPath):"
                        # Create the target directory if it doesn't exist
                        if (!(Test-Path $destinationDirectory -PathType Container)) {
                            New-Item -ItemType Directory -Path $destinationDirectory
                        }
                        # Copy contents to target directory
                        robocopy $fullPath $destinationDirectory /E
                        # Remove the original folder
                        Write-Host "Removing original folder..."
                        Remove-Item -Path $fullPath -Recurse -Force
                        Write-Host "Contents copied to $destinationDirectory and original folder deleted: $fullPath"
                    } elseif ($action -eq 'D' -or $action -eq 'd') {
                        # Just delete the folder
                        Write-Host "Removing original folder..."
                        Remove-Item -Path $fullPath -Recurse -Force
                        Write-Host "Folder deleted: $fullPath"
                    } elseif ($action -eq 'I' -or $action -eq 'i') {
                        Write-Host "Folder ignored: $fullPath"
                    } elseif ($action -eq 'N' -or $action -eq 'n') {
                        Write-Host "No action taken for folder: $fullPath"
                    } else {
                        Write-Host "Invalid input. No action taken."
                    }
                }
            }
        }
    }
    Write-Host "Script Complete"
}    