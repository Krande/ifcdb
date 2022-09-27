import os
import requests
from azure.identity import InteractiveBrowserCredential

cred = InteractiveBrowserCredential(
    client_id=os.environ.get("AZ_BL_API_CLIENT_ID"),
    tenant_id=os.environ.get("AZ_TENANT_ID")
)

token = cred.get_token(f'api://{os.environ.get("AZ_CLIENT_ID")}/.default').token
print(token)

r = requests.get('http://localhost:8000/users', headers={'Authorization': f'Bearer {token}'})
print(r.text)
