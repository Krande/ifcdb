from httpx import AsyncClient
from app import settings

async with AsyncClient() as client:
    azure_response = await client.post(
        url=f'https://login.microsoftonline.com/{settings.TENANT_ID}/oauth2/v2.0/token',
        data={
            'grant_type': 'client_credentials',
            'client_id': settings.OPENAPI_CLIENT_ID,  # the ID of the app reg you created the secret for
            'client_secret': settings.CLIENT_SECRET,  # the secret you created
            'scope': f'api://{settings.APP_CLIENT_ID}/.default',  # note: NOT .user_impersonation
        }
    )
    token = azure_response.json()['access_token']

    my_api_response = await client.get(
        'http://localhost:8000/api/v1/hello-graph',
        headers={'Authorization': f'Bearer {token}'},
    )
    print(my_api_response.json())