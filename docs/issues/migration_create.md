# Migration Create in Azure

When attempting to do migrations or anything from the cli communicating with a cloud instance, be sure that your call
isn't blocked by IT restrictions.

My experience when communicating with my EdgeDB cloud instance from my work computer was that the following 
cmd line

`edgedb -I azure migration create --database mixed --tls-security insecure --non-interactive`

could freeze and hang for hours without any progress. The following logs where observed on my docker logs on my 
container instance in Azure.

```
INFO 25 2022-08-24T12:35:23.251 edb.server: Connection discarded to backend database: edgedb
INFO 25 2022-08-24T12:39:04.145 edb.server: Connection discarded to backend database: small
INFO 25 2022-08-24T12:39:05.193 edb.server: Backend connections to database small: 1 were established in at least the last 1.0 seconds.
INFO 25 2022-08-24T12:55:45.125 edb.server: Connection established to backend database: edgedb
INFO 25 2022-08-24T12:55:45.126 edb.server: Connection discarded to backend database: small
INFO 25 2022-08-24T12:55:45.823 edb.server: introspecting database 'small'
INFO 25 2022-08-24T12:55:46.896 edb.server: Backend connections to database small: 1 were established in at least the last 1.0 seconds.
INFO 25 2022-08-24T12:59:45.352 edb.server: Connection discarded to backend database: edgedb
INFO 25 2022-08-24T13:02:15.044 edb.server: Connection established to backend database: mixed
INFO 25 2022-08-24T13:05:04.245 edb.server: Connection discarded to backend database: small
INFO 25 2022-08-24T13:05:05.291 edb.server: Backend connections to database small: 1 were established in at least the last 1.0 seconds.
INFO 25 2022-08-24T13:19:04.277 edb.server: Connection discarded to backend database: mixed
INFO 25 2022-08-24T13:19:05.338 edb.server: Backend connections to database mixed: 1 were established in at least the last 1.0 seconds.
```


Here are the versions I used to test

```
CLI:      2.0.5+da7c868
SERVER (Azure):   2.1+c600476 (uses an incredibly long time to respond)
SERVER (local):   2.1+c600476 (works as expected)
```

## Potential workarounds

If it proves to be a timeout issue then maybe this can help

    edgedb> configure instance set session_idle_transaction_timeout := <duration>'0';

https://github.com/edgedb/edgedb/discussions/3395#discussioncomment-2101020
