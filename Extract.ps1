
# Define folders and files to exclude from replacement
$deployedAppLocation = Read-Host "Enter the deployed application path: "
# $deployedAppLocation = 'C:\Users\User\Aditya\Personal\New folder\Equipcom' ## Testing

# Get the file paths for exclusion
$oilImages = Get-ChildItem $deployedAppLocation\Oil\Images | ForEach-Object { $_.Pa }
$reportImages = Get-ChildItem $deployedAppLocation\Reports\Images | ForEach-Object { $_.FullName }
$reportCrystalReports = Get-ChildItem $deployedAppLocation\Reports\CrystalReports | ForEach-Object { $_.FullName }
$tyreImages = Get-ChildItem $deployedAppLocation\Tyre\Images | ForEach-Object { $_.FullName }

$excludeItems = @("Fusioncharts-suite-xt", "GSNetImages", "Images", "PDFS", "TreeLineImages", "Wall.jpg" , "web.config") + $oilImages + $reportImages + $reportCrystalReports + $tyreImages

$zipFile = "Build.zip"

# Extract contents of the zip file to a temporary folder
$temporaryExtractionPath = "$deployedAppLocation\TempExtraction" # Join-Path $deployedAppLocation "TempExtraction"
$finalDestinationPath = 'C:\Users\User\Aditya\Personal\New folder\TempExtraction' ## Change it later on 

Expand-Archive -Path $zipFile -DestinationPath $temporaryExtractionPath -Force

$itemsToMove = Get-ChildItem "$temporaryExtractionPath\*" | ForEach-Object { $_.FullName }

# Move-Item -Path "$tempExtractedSubFolder\*" -Destination $finalDestinationPath -Exclude $excludeItems -Force 
Move-Item -Path $itemsToMove -Destination $finalDestinationPath -Exclude $excludeItems -Force

# Remove the temporary extraction folder
Remove-Item -Path $temporaryExtractionPath -Force -Recurse

# Keep the PowerShell window open until the user presses Enter 
# Read-Host -Prompt "Press Enter to exit"