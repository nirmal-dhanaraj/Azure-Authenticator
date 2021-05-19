#== Step1 ===============

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Metadata", "true")

$response = Invoke-RestMethod 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' -Method 'GET' -Headers $headers
                         
$access_token =$response.access_token
echo "$access_token"
"`n`n"

#== Step2 ===============

$headers1 = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers1.Add("Content-Type", "application/x-www-form-urlencoded")
$headers1.Add("Accept-Encoding", "base64")

$body = "jwt=$access_token"
$response1 = Invoke-RestMethod 'https://dap-standalone.corpad.com/authn-azure/AzureAE1/dev/host%2Fazure-apps%2FAD/authenticate' -Method 'POST' -Headers $headers1 -Body $body
echo "$response1"
"`n"

#== Step3 ===============

$headers2 = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers2.Add("Authorization", "Token token=`"$response1`"")

$response2 = Invoke-RestMethod 'https://dap-standalone.corpad.com/secrets/dev/variable/secrets/test-variable' -Method 'GET' -Headers $headers2
"`n"
echo "The Secret from Conjur Is :"
echo "$response2" 
