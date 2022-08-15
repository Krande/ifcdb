from __future__ import annotations

import uvicorn

# For local dev you will have to add parent dir to source directory
from app import apiconfig, azure_ad, migrate, users
from fastapi import APIRouter, Depends, FastAPI, Security
from fastapi.middleware.cors import CORSMiddleware
from fastapi_azure_auth.user import User

router = APIRouter()
settings = apiconfig.settings
azure_scheme = azure_ad.azure_scheme

app = FastAPI(
    swagger_ui_oauth2_redirect_url="/oauth2-redirect",
    swagger_ui_init_oauth={
        "usePkceWithAuthorizationCodeGrant": True,
        "clientId": settings.OPENAPI_CLIENT_ID,
    },
)

if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )


@app.on_event("startup")
async def load_config() -> None:
    """
    Load OpenID config on startup.
    """
    await azure_scheme.openid_config.load_config()


@app.get("/", dependencies=[Security(azure_scheme)])
async def root():
    return {"message": "Hello World"}


@app.get("/hello-user", dependencies=[Security(azure_scheme)])
async def hello_user(user: User = Depends(azure_scheme)) -> dict[str, bool]:
    """
    Wonder how this auth is done?
    """
    print(user.name)
    return user.dict()


@app.get("/health_check", include_in_schema=False)
async def health_check() -> dict[str, str]:
    return {"status": "Ok"}


app.include_router(users.router)
app.include_router(migrate.router)

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
