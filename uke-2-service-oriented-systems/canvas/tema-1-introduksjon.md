---
synlighet: intern
livsyklus: utkast
tittel: BE03 - SOA - Introduksjon til Tjeneste Orienterte Systemer
slug: be03-soa-introduksjon
canvas_id: null
---

# Introduksjon til Tjeneste Orienterte Systemer (SOA)

I begynnelsen av programmering så lagde vi systemer som inkluderte alt, fra hardware komponenter til logikk, helt opp til bruker grensesnitt. Så kalte "Big Balls of Mud" eller "Spaghetti Kode".

Disse systeme kan ha fungert og løst problemet der og da, men de er tett flettet sammen, og endringer i disse er som regel veldig til ekstremt vanskelig å gjøre. Som for eksempel endre hvem som har tilgang til en ressurs kan medføre endringer i titalls filer, gjennom et dusin undersystemer. Det er og særdeles vanskelig å resonere rundt eller isoler egenskaper ved disse.

Som en løsning på disse problemene, og flere, så har vi et konsept som kalles Tjeneste Orientert Arkitektur/Service Oriented Arkitekture.

## Teori

Tjeneste Orientering flere problemer og er inspirert av hvordan moderne markedsøkonomi og bedrifter organiserer sin virksomhet.

Noen av kvalitetene en søker å oppnå:

- (Loose Coupling) Tjenester kan utvikles uavhengig av hverandre
- (Reliability) Viss en tjeneste går ned, så kan andre håndtere mangler elegant.
- [Standardization] Standardiserte grensesnitt kan byttes ut med forskjellige implementasjoner/outsourcing
- (Agility) Små tjenester kan utvikles forter og med mindre ressurser enn større
- (Skalering) Når tjenster er veldefinerte og enkapsulerte så er individuell skalering mulig
- (Heterogenitet) Standardiserte grensesnitt tillater bruk av domene optimisert teknologier

For å kunne utvikle disse så kommer vi til å benytte oss av et sett med løsninger som vi kaller Kontainer Teknologier. Dette er standardiserte løsninger for å pakke ned, distribuere applikasjoner, og kjøre applikasjoner.

Konkret så trenger du å installere et lokalt kjøretids miljø for disse kalt [Docker Desktop](https://www.docker.com/products/docker-desktop/).

Etter det så kommer vi til pakke ned en .NET applikasjon i en Docker Container og kjøre denne, før vi laster den opp på GitHub Container Registry (GHCR) og kjører værandre sine.

Disse Containerne er veldig lett og distribuere og kjøre lokalt, en kan sjekke ut åpne registre for å se hva andre ting some er blitt laget og gjort åpent tilgjengelig. [Docker Hub](https://hub.docker.com/) er det mest kjente, men det er og andre steder som GitHub sitt eget.

> For MacOS brukere så kan [OrbStack](https://orbstack.dev/) være ett bedre alternative til Docker Desktop

## Konkretisering

### Hva, hvor, når blir dette brukt?

Tjeneste orientering er i bruk i gjennom hele samfunnet, ikke kun i digitale systemer. Bare noter deg alt du bruker i det daglige liv (helsetjeneste, rørleggertjeneste, etc). Digitale systemer følger mange av de samme prinsippene fra:

- ASP .NET Services
- Docker Compose Services
- Kubernetes Microservices

Vi kommer til å bruke:

- Dockerfile for å definere våre egne container bilder
- Docker Desktop til å overvåke og inspisere containere som kjører
- GitHub Actions til å automatisk publisere våre egne containere bilder

### Eksempler

**Dockerfile for å bygge en lokal ASP .NET Applikasjon**:

> Denne kan endre seg viss du er veldig aktiv på å organisere ting i mapper

```dockerfile
# Start with an Image where .NET 9.0 SDK is already installed
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -o out

# Build runtime image, only containes the .NET 9.0 runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /App
COPY --from=build /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
```

**GitHub Actions for å publisere kontainer bilde til GHCR**:

```yaml
name: Publish .NET Docker Image to GHCR

on:
  push:
    branches:
      - main

jobs:
  build-and-publish:
    runs-on: ubuntu-latest
    permissions:
      packages: write # Grant write permission for packages at the job level

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Log in to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: . # Path to your Dockerfile context
          file: ./Dockerfile # Path to your Dockerfile
          push: true
          tags: ghcr.io/${{ github.repository }}:latest
```

**Liste over mest brukte kommandoer**:

- Sjekk om Docker er korrekt installert:

  ```sh
  docker run hello-world
  ```

- Kjør et container bilde fra Docker Hub (NGinx)

  ```sh
  docker run --publish 8080:80 nginx
  ```

- Bygge og kjør en lokal container

  ```sh
  docker build --tag dotnet-test .
  docker run --publish 8080:5000 dotnet-test
  ```

> Vi kommer til å benytte oss av noe letter verktøy framover, så ikke tenk at du trenger å pugge disse kommandoene.

### Eksterne Lenker

- [TODO! Lenk til GitHub Repository]()
- [TODO! Lenk til CICD workflow for å containerisere ASP .NET APIer]()
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  - [For MacOS - OrbStack](https://orbstack.dev/)
- [Docker Hub](https://hub.docker.com/)
- [Microsoft - Containerize .NET app](https://learn.microsoft.com/en-us/dotnet/core/docker/build-container)

## Videre Lesing

- [Wikipedia - Tjenestedesign](https://no.wikipedia.org/wiki/Tjenestedesign)
- [Open Container Initiative](https://opencontainers.org/)

## Referanse Liste

- [Wikipedia - SOA](https://en.wikipedia.org/wiki/Service-oriented_architecture)
- [Docker Documentation](https://docs.docker.com/)
