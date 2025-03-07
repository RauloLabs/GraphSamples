#﻿
# AzureAdPotho.ps1
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

#Method >>> Update profilePhoto
#Base on (Aplication autentication):
#https://learn.microsoft.com/en-us/graph/api/profilephoto-update?view=graph-rest-1.0&tabs=http


# Define variables
$tenantId = "Add value"
$clientId = "Add value"
$clientSecret = "Add value"
$userPrincipalName = "exouser1@contoso.com"
$photoPath = "C:\temp\PhotoS.jpg" #Define the file location

# Get an access token
$body = @{
    grant_type    = "client_credentials"
    scope         = "https://graph.microsoft.com/.default"
    client_id     = $clientId
    client_secret = $clientSecret
}

$tokenResponse = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $tokenResponse.access_token

# Upload the profile photo
$photoBytes = [System.IO.File]::ReadAllBytes($photoPath)

$uri = "https://graph.microsoft.com/v1.0/users/" + $userPrincipalName +  "/photo/" + '$value'
Invoke-RestMethod -Method Put -Uri $uri  -Headers @{Authorization = "Bearer $accessToken"} -Body $photoBytes -ContentType "image/jpeg"

