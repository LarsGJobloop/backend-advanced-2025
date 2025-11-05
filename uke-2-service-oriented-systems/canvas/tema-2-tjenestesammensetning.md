---
synlighet: intern
livsyklus: akseptert
tittel: "C# Advanced - 2-2: Tjenestesammensetning"
slug: be03-2-2-soa-tjenestesammensetning
---

# Tjenestesammensetning

En trend de siste årene har vært et fokus på mikrotjenester, hvor du splitter opp løsningene dine i veldig små biter for å lettere kunne utvikle løsninger. Det er en arkitektur for storskala løsninger og spesielt attraktivt/mye brukt når det er stor usikkerhet rundt hva som kreves for at løsningen skal være levedyktig.

Du skal se på en mikro utgave av dette mønsteret her med hjelp av Docker Compose.

## Teori

### Mikrotjenester

Mikrotjenester er et arkitekturmønster som beskriver løsninger hvor tjenestene er potensielt på størrelse med en KommentarTjeneste. Dette gjør det veldig lett og kjapt å eksperimentere, men alene er disse ikke nødvendigvis noe som du kan ta betalt for.

Så verdien kommer først når du setter flere av disse sammen til et større produkt som en blogplatform, eller Learning Management System. Dette leder til at mye av kompleksiteten er flyttet fra individuelle programmer til orkestrering/sammensettingen av disse tjenestene til en løsning.

### Orkestrering og sammensetning

Det største og mest kjente løsningen for å definere disse tjenestesammensetningene er [Kubernetes](https://kubernetes.io/). Kubernetes er, potensielt, enormt stort og komplekst, og kommer fra Googles interne løsning (Borg) som de benytter for å administrere sine egne maskiner og produkter.

Kort fortalt er Kubernetes et distribuert operativsystem, ment for å kjøre tjenester på flåter av maskiner ([65,000+](https://cloud.google.com/blog/products/containers-kubernetes/gke-65k-nodes-and-counting)).

Du kommer til å holde deg relativt mye enklere og skal benytte deg av [Docker Compose](https://docs.docker.com/compose/) for å sette opp dine egne komposisjoner som kan kjøres lokalt, og senere på en server. Docker Compose mangler mye av funksjonaliteten til Kubernetes, men det er lett å kjøre på din egen maskin og gir et innblikk i, og muligheten for å teste, hvordan moderne systemer snakker sammen og hvordan du kan hente inn mange ferdige løsninger som benyttes i industrien (identitet, tilgangsstyring og database-løsninger vil være blant de nyttigste).

## Konkretisering

### Hva, hvor, når blir dette brukt?

Tjenestesammensetning vil bli brukt i de aller fleste løsninger. Eksakt hvordan dette gjøres varierer, og i markedet i dag florerer det av plattformløsninger som kan benyttes, hvor det operative ansvaret blir outsourcet til spesialiserte bedrifter og du sitter med en web-GUI eller web-API som du benytter deg av.

### Eksempler

**Docker Compose - Nginx**:

```yaml
name: single-service

services:
  web:
    # The repository (default hub.docker.io), name of container image along with the tag/version to use
    image: nginx:alpine
    # Ports are a list of mappings between host ports and container/app ports
    ports:
      - 8080:80
```

**Docker Compose - Lokal tjeneste**:

```yaml
name: simpler-composition

services:
  api:
    # Path to the Dockerfile and which context (directory) to build from
    build:
      dockerfile: Dockerfile
      context: ./Api
    ports:
      - 8080:5000
```

**Docker Compose - Flere tjenester**:

```yaml
name: simpler-composition

services:
  memory-service:
    build:
      dockerfile: Dockerfile
      context: ./memory-service
    # Ports are a limited resource, so you can't bind more than a single service to one
    ports:
      - 8080:5000

  inspirational-quote-service:
    build:
      dockerfile: Dockerfile
      context: ./inspirational-quote-service
    ports:
      # Ports are a limited resource, so you can't bind more than a single service to one
      - 8081:5000
```

### Eksterne Lenker

- [Docker Compose Documentation](https://docs.docker.com/compose/)

## Videre Lesing

- [Wikipedia - Service Composability](https://en.wikipedia.org/wiki/Service_composability_principle)

## Referanse Liste

- Docker Inc. (2024). _Docker Compose Documentation._ docs.docker.com.
