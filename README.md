# Simple Proxy

A very simple HTTP Proxy server based on https://github.com/elazarl/goproxy

## Features:

* Configurable via environment variables
* HTTP Basic Auth (even a configurable Realm!)
* [Dockerized](https://hub.docker.com/r/rjocoleman/simple-proxy/)

## Usage

```
ADDRESS= # default 0.0.0.0:8080
VERBOSE= # default false
USERNAME=
PASSWORD=
REALM=
```


Standalone:

Download from Github Releases

```
USERNAME=foo -e PASSWORD=bar ./simple-proxy
```

[Docker](https://hub.docker.com/r/rjocoleman/simple-proxy/):

```
docker run -d --restart=always -e USERNAME=foo -e PASSWORD=bar -p 8080:8080 rjocoleman/simple-proxy
```
