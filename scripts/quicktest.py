import edgedb

client = edgedb.create_client(
    "ifc_test_server",
    tls_security="insecure",
)
res = client.query_json("SELECT IfcUnit {}")
print(res)
