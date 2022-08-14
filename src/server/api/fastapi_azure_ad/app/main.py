from __future__ import annotations

from typing import Union

import uvicorn

# For local dev you will have to add parent dir to source directory
from app import movies, users
from fastapi import APIRouter, Depends, FastAPI, Security
from fastapi.middleware.cors import CORSMiddleware
from fastapi_azure_auth import SingleTenantAzureAuthorizationCodeBearer
from fastapi_azure_auth.user import User
from pydantic import AnyHttpUrl, BaseSettings, Field

router = APIRouter()


class Settings(BaseSettings):
    SECRET_KEY: str = Field("my super secret key", env="SECRET_KEY")
    BACKEND_CORS_ORIGINS: list[Union[str, AnyHttpUrl]] = ["http://localhost:8000"]
    OPENAPI_CLIENT_ID: str = Field(default="", env="OPENAPI_CLIENT_ID")
    APP_CLIENT_ID: str = Field(default="", env="APP_CLIENT_ID")
    TENANT_ID: str = Field(default="", env="TENANT_ID")

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"
        case_sensitive = True


settings = Settings()

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

azure_scheme = SingleTenantAzureAuthorizationCodeBearer(
    app_client_id=settings.APP_CLIENT_ID,
    tenant_id=settings.TENANT_ID,
    scopes={
        f"api://{settings.APP_CLIENT_ID}/user_impersonation": "user_impersonation",
    },
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


app.include_router(movies.router)
app.include_router(users.router)

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
