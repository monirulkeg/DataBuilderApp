# DataBuilderApp

> [!TIP] Make sure the docker is running


### Run
**Set env variable**
```powershell
$Env:SA_PASSWORD="Your pass!"
```

**Run container**

```docker
docker compose up -d
````
#### REST
http://localhost:5001/swagger

#### GraphQL
http://localhost:5001/graphql

---


### Configuration details

**Configuring a Relationship**

There are three types of relationships that can be established between two entities:

- One-to-Many Relationship
- Many-to-One Relationship
- Many-To-Many Relationship

[Read more about enitty relationship](https://learn.microsoft.com/en-us/azure/data-api-builder/relationships)


**REST/GraphQL support for views**

A view, from a REST/GraphQL perspective, behaves like a table. All GraphQL operations are supported. [Read more](https://learn.microsoft.com/en-us/azure/data-api-builder/database-objects#views)

$\color{Apricot}{Data API builder supports stored procedures for relational databases (i.e. MSSQL), but not for non-relational databases (i.e. NoSQL).}$

 > Adding view

```bash
dab add BookDetail --source dbo.vw_books_details --source.type View --source.key-fields "id" --permissions "anonymous:read"
```
> Adding store procedure

```bash
dab add GetCowrittenBooksByAuthor --source dbo.stp_get_all_cowritten_books_by_author --source.type "stored-procedure" --source.params "searchType:s" --permissions "anonymous:execute" --rest.methods "GET" --graphql.operation "query"
```
---

*Graphql query*

```bash

query {
  organisations {
    items {
      Id
      Name
      organisationalUnits {
        items {
          Archived
          Id
          Logo
          Name
          OrganisationId
          ParentOrganisationalUnitId
          organisationalAddresses {
            items {
              AddressType
              City
              Coordinates
              Country
              FormattedAddressKey
              Id
              LocationId
              OrganisationalUnitId
              Region
              Street
              ZipCode
              AddressLocation {
                Coordinates
                Id
                Level
                Name
                ParentId
              }
            }
          }
        }
      }
    }
  }
}

```
#### Mutation

``` bash
mutation {
  createLocation(
    item: { Coordinates: "location-xy", Level: 2, Name: "another location", ParentId: 0 }
  ) {
    Name
    ParentId
  }
  createAddress(
    item: {
      AddressType: 2
      City: "Centraln"
      Coordinates: "safasdf asdf asd"
      FormattedAddressKey: ""
      Country: "Sweden"
      LocationId: 2
      OrganisationalUnitId: 1
      Region: null
      Street: "Nice street"
      ZipCode: "546 54"
    }
  ) {
    AddressType
    City
    
  }
}
```



[![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_linkedin_circle_color_107178.png)](https://www.linkedin.com/in/mr-monirul/)