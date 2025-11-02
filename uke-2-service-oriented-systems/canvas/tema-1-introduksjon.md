---
synlighet: intern
livsyklus: utkast
tittel: BE03 - SOA - Introduksjon til Tjeneste Orienterte Systemer
slug: be03-soa-introduksjon
---

# Introduksjon til Tjeneste Orienterte Systemer (SOA)

I begynnelsen av programmering lagde vi systemer som inkluderte alt, fra hardware-komponenter til logikk, helt opp til brukergrensesnitt. Såkalte "Big Balls of Mud" eller "Spaghetti Kode".

Disse systemene kan ha fungert og løst problemet der og da, men de er tett flettet sammen, og endringer i disse er som regel veldig til ekstremt vanskelige å gjøre. For eksempel kan det å endre hvem som har tilgang til en ressurs medføre endringer i titalls filer, gjennom et dusin undersystemer. Det er også særdeles vanskelig å resonere rundt eller isolere egenskaper ved disse.

Som en løsning på disse problemene, og flere, har vi et konsept som kalles Tjenesteorientert Arkitektur (Service Oriented Architecture, SOA).

## Teori

Tjenesteorientering løser flere problemer og er inspirert av hvordan moderne markedsøkonomi og bedrifter organiserer sin virksomhet.

### Prinsipper og kvaliteter

Noen av kvalitetene en søker å oppnå:

- **(Loose Coupling)** Tjenester kan utvikles uavhengig av hverandre
- **(Reliability)** Hvis en tjeneste går ned, kan andre håndtere mangler elegant
- **(Standardization)** Standardiserte grensesnitt kan byttes ut med forskjellige implementasjoner/outsourcing
- **(Agility)** Små tjenester kan utvikles raskere og med færre ressurser enn større
- **(Skalering)** Når tjenester er veldefinerte og enkapsulerte, er individuell skalering mulig
- **(Heterogenitet)** Standardiserte grensesnitt tillater bruk av domene-optimerte teknologier

### Kontainerteknologi

For å kunne utvikle disse kommer vi til å benytte oss av et sett med løsninger som vi kaller kontainerteknologier. Dette er standardiserte løsninger for å pakke inn, distribuere applikasjoner, og kjøre applikasjoner.

Konkret trenger du å installere et lokalt kjøretidsmiljø for disse, kalt [Docker Desktop](https://www.docker.com/products/docker-desktop/).

Etter det kommer vi til å pakke inn en .NET-applikasjon i en Docker-container og kjøre denne, før vi laster den opp på GitHub Container Registry (GHCR) og kjører hverandres containere.

Disse containerne er veldig lette å distribuere og kjøre lokalt. Du kan sjekke ut åpne registre for å se hva andre ting som er blitt laget og gjort åpent tilgjengelig. [Docker Hub](https://hub.docker.com/) er det mest kjente, men det er også andre steder som GitHub sitt eget.

> For macOS-brukere kan [OrbStack](https://orbstack.dev/) være et bedre alternativ til Docker Desktop

## Konkretisering

### Hva, hvor, når blir dette brukt?

Tjenesteorientering er i bruk gjennom hele samfunnet, ikke kun i digitale systemer. Bare merk deg alt du bruker i det daglige liv (helsetjeneste, rørleggertjeneste, etc.). Digitale systemer følger mange av de samme prinsippene:

- ASP .NET Services
- Docker Compose Services
- Kubernetes Microservices

Vi kommer til å bruke:

- Dockerfile for å definere våre egne containerbilder
- Docker Desktop til å overvåke og inspisere containere som kjører
- GitHub Actions til å automatisk publisere våre egne containerbilder

### Eksempler

**Dockerfile for å bygge en lokal ASP.NET-applikasjon**:

> Denne kan endre seg hvis du er veldig aktiv på å organisere ting i mapper

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

# Build runtime image, only contains the .NET 9.0 runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /App
COPY --from=build /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
```

**GitHub Actions for å publisere containerbilde til GHCR**:

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

- Kjør et containerbilde fra Docker Hub (NGinx)

  ```sh
  docker run --publish 8080:80 nginx
  ```

- Bygge og kjør en lokal container

  ```sh
  docker build --tag dotnet-test .
  docker run --publish 8080:5000 dotnet-test
  ```

> Vi kommer til å benytte oss av lettere verktøy framover, så ikke tenk at du trenger å memorere disse kommandoene.

### Eksterne Lenker

- [TODO! Lenk til GitHub Repository]()
- [TODO! Lenk til CICD workflow for å containerisere ASP .NET APIer]()
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  - [For macOS - OrbStack](https://orbstack.dev/)
- [Docker Hub](https://hub.docker.com/)
- [Microsoft - Containerize .NET app](https://learn.microsoft.com/en-us/dotnet/core/docker/build-container)

## Videre Lesing

- [Wikipedia - Tjenestedesign](https://no.wikipedia.org/wiki/Tjenestedesign)
- [Open Container Initiative](https://opencontainers.org/)

## Referanse Liste

- [Wikipedia - SOA](https://en.wikipedia.org/wiki/Service-oriented_architecture)
- [Docker Documentation](https://docs.docker.com/)
