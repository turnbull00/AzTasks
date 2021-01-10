Set-StrictMode -Version 3

. $PSScriptRoot/helpers.ps1
. $PSScriptRoot/storageaccount.ps1


function Get-ResourceGroup() {
    [CmdletBinding()]
    param(
        [string]$ResourceGroupName,
        [ScriptBlock]$block
    )

    function PatchSubscription() {
        [CmdletBinding()]
        param(
            [string]$SubscriptionId,
            [ScriptBlock]$block
        )
        $block.Invoke()
    }

    PatchSubscription (Get-AzSubscription).Id $block
}
