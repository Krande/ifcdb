import os

import requests

r = requests.post(
    f"https://login.microsoftonline.com/{os.environ.get('TENANT_ID')}/oauth2/v2.0/token",
    dict(
        grant_type="client_credentials",
        client_id=os.environ.get("AZ_BL_API_CLIENT_ID"),
        client_secret=os.environ.get("AZ_CLIENT_SECRET"),
        scope=f'api://{os.environ.get("AZ_CLIENT_ID")}/.default',
    )
)
print(r.text)
