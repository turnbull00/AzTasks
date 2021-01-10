. ./src/ops.ps1

$keyToRotate = "Primary"

ResourceGroup "scripting" {
    StorageAccount "f23oij" {
        RotateKey $keyToRotate
    }
}

# ResourceGroup "scripting" {
#     StorageAccount "f23oij" {
#         Details
#     }
# }


# ResourceGroup "scripting" {
#     StorageAccounts {
#         Details
#     }
# }