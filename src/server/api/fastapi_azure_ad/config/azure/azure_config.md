# Azure Config

Requires 2 files; an `.env` and a `cert.pem` file. 


The `.env` file should contain the following variables

    TENANT_ID=
    APP_CLIENT_ID=
    OPENAPI_CLIENT_ID=
    EDGEDB_DSN=

The first 3 variable definitions are found in the tutorial described here
https://intility.github.io/fastapi-azure-auth/single-tenant/azure_setup.

while the definition of `EDGEDB_DSN` can be found [here](https://www.edgedb.com/docs/reference/dsn#dsn-specification) 
while the values are from the setup in https://www.edgedb.com/docs/guides/deployment/azure_flexibleserver)