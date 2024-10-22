### https://devblogs.microsoft.com/azure-sql/build-apis-with-dab-using-containers/

### https://github.com/croblesm/sqlcmd-go-scratch (For execute script)

https://stackoverflow.com/questions/69941444/how-to-have-docker-compose-init-a-sql-server-database

#### Create docker network
> [!TIP]
> docker network create library-network

#### SQL Container

```powershell

docker run \
    --name SQL-Library \
    --hostname SQL-Library \
    --env 'ACCEPT_EULA=Y' \
    --env 'MSSQL_SA_PASSWORD=P@ssw0rd!' \
    --publish 1401:1433 \
    --network library-network \
    --detach mcr.microsoft.com/mssql/server:2022-latest
```

#### Folder structure

```
	├── DAB-Config
    ├── .env
    └── dab-config.json
```
 | .env
 
 | CONN_STRING=Server=SQL-Library;Database=library;User ID=SA;Password=P@ssw0rd!;TrustServerCertificate=true

#### Create DAB Container
```bash
	docker run `
     --name DAB-Library `
     --volume "D:\Development\MicrosoftDataApiBuilder\DabDockerCompose\DAB-Config:/App/configs" `
     --publish 5001:5000 `
     --env-file "./DAB-Config/.env" `
     --network library-network `
     --detach mcr.microsoft.com/azure-databases/data-api-builder:latest `
     --ConfigFileName /App/configs/dab-config.json
 ```