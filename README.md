# azure-rest-api
Azure REST API training exercises for Postman.

## Blob-Storage
* contains a PowerShell file with commands to 
    * log into Azure with PSH
    * create a resource group
    * create a Storage account
    * create a Storage Account SAS token using key1
        * to create this one, you will need the commands for ```Get-AzStorageAccountKey``` and ```New-AzStorageContext```
* you will need to [import the Postman Collection into Postman](https://learning.postman.com/docs/getting-started/importing-and-exporting-data/)
    * I'd suggest creating a new workspace for your Azure HTTP API exercises
* once you have all this setup, copy the SAS token and the storage account name from PSH into the Postman collection variables
