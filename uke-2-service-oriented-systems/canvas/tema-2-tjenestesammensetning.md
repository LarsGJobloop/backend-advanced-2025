---
synlighet: intern
livsyklus: utkast
tittel: BE03 - SOA - Tjenestesammensetning
slug: be03-soa-tjenestesammensetning
---

# Tjenestesammensetning

En trend de siste årene har vært et fokus på Mikrotjenester, hvor vi splitter opp løsningene våre i veldig små biter for å lettere kunne utvikle løsninger. Det er en arkitektur for stor skala løsninger og spesielt attraktivt/mye brukt når det er stor usikkerhet rundt hva som kreves for at bedriften skal være levedyktig.

Vi skal se på en mikro utgave av dette mønsteret her med hjelp av Docker Compose.

## Teori

Mikrotjenester er et arkitektur mønster som beskriver løsninger hvor tjenestene er potensielt på størrelse med en KommentarTjeneste. Dette gjør det veldig lett og kjapt og eksperimentere, men enkeltvis så er disse ikke nødvendigvis noe som en kan ta betalt for.

Så verdien kommer først når du setter flere av disse sammen til et større produkt som en Blog Platform, eller Learning Management System. Dette leder til at mye av kompleksiteten er flytte fra individuell programmer til orkestrering/sammensettingene av disse tjenestene til en løsning.

Det største og mest kjente løsningen for å definere disse tjenestesammensetning er [Kubernetes](https://kubernetes.io/). Kubernetes er, potensielt, enormt stort og komplekst, og kommer fra Google sitt interne løsning (Borg) som de benytter for å adminisrer sine egne maskiner og produkter.

Kort fortalt så er Kubernetes et distribuert operative system, ment for å kjøre tjenester på flåter av maskiner ([65,000+](https://cloud.google.com/blog/products/containers-kubernetes/gke-65k-nodes-and-counting)).

Vi holder oss relativt mye enklere og skal benytte oss av [Docker Compose]() for å sette opp våre egne komposisjoner som kan kjøres lokalt, og senere på en server. Docker Compose mangler mye av funksjonaliteten til Kubernetes, men det er lett å kjøre på sin egen maskin og gir ett innblikk i, og muligheten for å teste, hvordan moderne systemer snakker sammen og hvordan en kan hente inn mange ferdig løsninger som benyttes i industrien (Identitet, tilgangstyring og database løsninger vil være blandt de nyttigste).

## Konkretisering

### Hva, hvor, når blir dette brukt?

Tjenestesammensetning vil bli brukt i de aller fleste løsninger. Eksakt hvordan dette gjøres varierer, og i markedet i dag så florere det av Platform løsninger som kan benyttes. Hvor det operative ansvaret blir outsourcet til spesialiserte bedrifter og du sitter med en Web GUI eller Web API som du benytter deg av.

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

- [TODO! Lenk til GitHub Repository]()
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## Videre Lesing

- [Wikipedia - Service Composability](https://en.wikipedia.org/wiki/Service_composability_principle)

## Referanse Liste

{{ Lenke til autorative ressurser for temaet }}
