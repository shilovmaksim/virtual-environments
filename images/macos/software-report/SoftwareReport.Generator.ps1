param (
    [Parameter(Mandatory)][string]
    $OutputDirectory,
    $ImageName
)

if (-not (Test-Path $OutputDirectory)) { New-Item -Path $OutputDirectory -ItemType Directory | Out-Null }

#
# Write final reports
#

$systemInfo | Out-File -FilePath "${OutputDirectory}/systeminfo.txt"
$markdown | Out-File -FilePath "${OutputDirectory}/systeminfo.md"
