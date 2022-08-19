from __future__ import annotations

import uvicorn
from app.dependencies import azure_scheme

# For local dev you will have to add parent dir to source directory
from app.internal import apiconfig
from app.routers import entities, migration, users, files
from fastapi import APIRouter, FastAPI, Security
from fastapi.middleware.cors import CORSMiddleware

router = APIRouter()
settings = apiconfig.settings


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


app.include_router(users.router)
app.include_router(migration.router)
app.include_router(entities.router)
app.include_router(files.router)

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
