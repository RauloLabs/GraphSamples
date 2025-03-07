#﻿
# SPReports.ps1
#
# By Raul N, Microsoft Ltd. 2025. Use at your own risk.  No warranties are given.
#
#  DISCLAIMER:
# THIS CODE IS SAMPLE CODE. THESE SAMPLES ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.
# MICROSOFT FURTHER DISCLAIMS ALL IMPLIED WARRANTIES INCLUDING WITHOUT LIMITATION ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR OF FITNESS FOR
# A PARTICULAR PURPOSE. THE ENTIRE RISK ARISING OUT OF THE USE OR PERFORMANCE OF THE SAMPLES REMAINS WITH YOU. IN NO EVENT SHALL
# MICROSOFT OR ITS SUPPLIERS BE LIABLE FOR ANY DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS,
# BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OF OR INABILITY TO USE THE
# SAMPLES, EVEN IF MICROSOFT HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. BECAUSE SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION
# OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU.

#Method >>> reportRoot: getSharePointSiteUsageDetail
#Base on (Aplication autentication):
#https://learn.microsoft.com/en-us/graph/api/reportroot-getsharepointsiteusagedetail?view=graph-rest-1.0&tabs=http

# Define the required variables
$clientId = "YOUR_CLIENT_ID"
$clientSecret = "YOUR_CLIENT_SECRET"
$tenantId = "YOUR_TENANT_ID"
$reportPeriod = "D7" # Change this to the desired period (e.g., D7, D30, D90, D180)

# Get an access token
$body = @{
    grant_type    = "client_credentials"
    scope         = "https://graph.microsoft.com/.default"
    client_id     = $clientId
    client_secret = $clientSecret
}
$tokenResponse = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $tokenResponse.access_token

# Get SharePoint site usage details
$headers = @{
    Authorization = "Bearer $accessToken"
}
$response = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/v1.0/reports/getSharePointSiteUsageDetail(period='$reportPeriod')" -Headers $headers

# Convert the response to a string
$responseString = $response | Out-String

# Get the current date and time in the specified format
$currentDateTime = Get-Date -Format "M_d_yyyy h_mm_ss tt"

# Define the file path with the date and time included
$filePath = "C:\temp\sp\MSSharePointSiteUsageDetail_$currentDateTime.csv"

# Save the string to a CSV file
$responseString | Out-File -FilePath $filePath -Encoding utf8
