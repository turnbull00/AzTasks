function Get-StorageAccount() {
    [CmdletBinding()]
    param(
        [string]$StorageAccountName,
        [ScriptBlock]$block
    )

    function Get-RotateKey() {
        [CmdletBinding()]
        param(
            [string]$KeyToRotate,
            [string]$ApiVersion = "2019-06-01"
        )

        $KeyToRotate = ($KeyToRotate -eq "Secondary") ? "key2" : "key1"
        $resourcePath = "/subscriptions/{0}/resourceGroups/{1}/providers/Microsoft.Storage/storageAccounts/{2}/regenerateKey?api-version={3}" -f $SubscriptionId, $ResourceGroupName, $StorageAccountName, $ApiVersion

        $response = Invoke-AzRestMethod -Path $resourcePath -Method "POST" -Payload (@{keyName=$KeyToRotate} | ConvertTo-Json)
        if($response.StatusCode -ne 200) {
            Write-Host "Could not rotate storage account key: $StorageAccountName"
        }
    }

    function Get-Details() {
        [CmdletBinding()]
        param(
            [string]$ApiVersion = "2019-06-01"
        )
        $resourcePath = "/subscriptions/{0}/resourceGroups/{1}/providers/Microsoft.Storage/storageAccounts/{2}?api-version={3}" -f $SubscriptionId, $ResourceGroupName, $StorageAccountName, $ApiVersion
        $response = Invoke-AzRestMethod -Path $resourcePath -Method "GET"
        if($response.StatusCode -ne 200) {
            Write-Host "Could not rotate storage account key: $StorageAccountName"
        } else {
            Get-PrettyJson $response.Content
        }
    }

    $block.Invoke()
}

function Get-StorageAccounts() {
    [CmdletBinding()]
    param(
        [ScriptBlock]$block
    )

    $storageAccountNames = Get-AzResource -ResourceType "Microsoft.Storage/storageAccounts" | select -ExpandProperty Name
    foreach($storageAccountName in $storageAccountNames) {
        StorageAccount $storageAccountName $block
    }
}