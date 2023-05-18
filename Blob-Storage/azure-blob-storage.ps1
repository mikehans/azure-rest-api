# source: https://learn.microsoft.com/en-us/azure/storage/scripts/storage-common-rotate-account-keys-powershell
Connect-AzAccount

# I have MFA enabled on my subscription, so the above errors out,
#   telling me I need to add the param + my Tenant ID (not the one here)
Connect-AzAccount -Tenant 2d5070000-d000-d000-d000-8c1f3dbe0000

$location = "australiaeast"
$rg = "mystoragetest-rg"

New-AzResourceGroup -name $rg -Location $location

$storageAcct = "ateststorageaccount$(get-random -Minimum 101 -Maximum 999)"

New-AzStorageAccount -ResourceGroupName $rg -Name $storageAcct -Location $location -SkuName Standard_LRS

$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $rg -Name $storageAcct).Value[0]


# Creating a Storage SAS Token because I don't want to use the key over HTTP
#    It requires a Storage Context (missing from the doco for New-AzStorageAccountSASToken)
#    see: https://stackoverflow.com/questions/43626779/get-azurestorageblob-could-not-get-the-storage-context-please-pass-in-a-stora
$storageCtx = New-AzStorageContext -StorageAccountName "ateststorageaccount318" -StorageAccountKey $storageAccountKey

# see: https://learn.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccountsastoken
New-AzStorageAccountSASToken -Service Blob,Queue -ResourceType Service,Container,Object -Protocol HttpsOnly -Permission "rwlcdf" -Context $storageCtx -ExpiryTime (get-date).AddDays(1)



