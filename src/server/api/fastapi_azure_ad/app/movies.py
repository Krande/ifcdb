from __future__ import annotations

from http import HTTPStatus
from typing import Iterable

import edgedb
from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel

router = APIRouter()
client = edgedb.create_async_client()


class RequestData(BaseModel):
    name: str
    address: str
    schedule: str
    host_name: str


class Person(BaseModel):
    name: str


class MovieData(BaseModel):
    title: str
    release_year: int
    actors: list[Person]


################################
# Get Movie
################################


@router.get("/movie")
async def get_movie(title: str = Query(None, max_length=50)) -> Iterable[MovieData]:
    print("getting events")
    if not title:
        movies = await client.query(
            """
            SELECT Movie {title, id, release_year, actors : {name}};
            """
        )

    else:
        movies = await client.query(
            """
            SELECT Movie {
                title, id, release_year, actors : {name}
            } FILTER .title=<str>$title
            """,
            title=title,
        )
    response = (
        MovieData(
            title=movie.title,
            release_year=movie.release_year,
            actors=[Person(name=actor.name) for actor in movie.actors],
        )
        for movie in movies
    )
    return response


# ################################
# Create events
# ################################


@router.post("/events", status_code=HTTPStatus.CREATED)
async def post_event(event: RequestData) -> MovieData:
    try:
        (created_event,) = await client.query(
            """
            WITH name:=<str>$name, address:=<str>$address,
            schedule:=<str>$schedule, host_name:=<str>$host_name

            SELECT (
                INSERT Event {
                name:=name,
                address:=address,
                schedule:=<datetime>schedule,
                host:=assert_single((SELECT DETACHED User FILTER .name=host_name))
            }) {name, address, schedule, host: {name}};
            """,
            name=event.name,
            address=event.address,
            schedule=event.schedule,
            host_name=event.host_name,
        )

    except edgedb.errors.InvalidValueError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={
                "error": "Invalid datetime format. " "Datetime string must look like this: '2010-12-27T23:59:59-07:00'",
            },
        )

    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail=f"Event name '{event.name}' already exists,",
        )

    return MovieData(
        name=created_event.name,
        address=created_event.address,
        schedule=created_event.schedule,
        # host=Host(name=created_event.host.name) if created_event.host else None,
    )


# ################################
# Update events
# ################################


@router.put("/events")
async def put_event(event: RequestData, filter_name: str) -> Iterable[MovieData]:

    try:
        updated_events = await client.query(
            """
            WITH filter_name:=<str>$filter_name, name:=<str>$name,
            address:=<str>$address, schedule:=<str>$schedule,
            host_name:=<str>$host_name

            SELECT (
                UPDATE Event FILTER .name=filter_name
                SET {
                    name:=name, address:=address,
                    schedule:=<datetime>schedule,
                    host:=(SELECT User filter .name=host_name)
                    }
                ) {name, address, schedule, host: {name}}

            ;
            """,
            filter_name=filter_name,
            name=event.name,
            address=event.address,
            schedule=event.schedule,
            host_name=event.host_name,
        )

    except edgedb.errors.InvalidValueError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={
                "error": "Invalid datetime format. " "Datetime string must look like this: '2010-12-27T23:59:59-07:00'",
            },
        )

    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={"error": f"Event name '{event.name}' already exists,"},
        )

    response = (
        MovieData(
            name=updated_event.name,
            address=updated_event.address,
            schedule=updated_event.schedule,
            # host=Host(name=updated_event.host.name) if updated_event.host else None,
        )
        for updated_event in updated_events
    )
    return response


# ################################
# Delete events
# ################################


@router.delete("/events")
async def delete_event(filter_name: str) -> Iterable[MovieData]:
    deleted_events = await client.query(
        """
        SELECT (
            DELETE Event FILTER .name=<str>$filter_name)
            {name, address, schedule, host : {name}};
        """,
        filter_name=filter_name,
    )

    response = (
        MovieData(
            name=deleted_event.name,
            address=deleted_event.address,
            schedule=deleted_event.schedule,
            # host=Host(name=deleted_event.host.name) if deleted_event.host else None,
        )
        for deleted_event in deleted_events
    )

    return response
