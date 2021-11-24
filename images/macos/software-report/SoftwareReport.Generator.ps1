param (
    [Parameter(Mandatory)][string]
    $OutputDirectory,
    $ImageName
)

$ErrorActionPreference = "Stop"

Import-Module MarkdownPS
Import-Module "$PSScriptRoot/SoftwareReport.Common.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xcode.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Android.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Java.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xamarin.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Toolcache.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Browsers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.WebServers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"

# Operating System info
$os = Get-OSVersion

$markdown = ""

# OS info
$markdown += Build-OSInfoSection
$markdown += New-MDList -Style Unordered -Lines ("Image Version: {0}" -f $ImageName.Split('_')[1])

#
# Generate systeminfo.txt with information about image (for debug purpose)
#
$dateTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$systemInfo = [string]::Join([System.Environment]::NewLine, @(
    "Date: ${dateTime}",
    "Image name: ${ImageName}"
))


if (-not (Test-Path $OutputDirectory)) { New-Item -Path $OutputDirectory -ItemType Directory | Out-Null }

#
# Write final reports
#
Write-Host $markdownExtended
$systemInfo | Out-File -FilePath "${OutputDirectory}/systeminfo.txt" -Encoding UTF8NoBOM
$markdown | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM
