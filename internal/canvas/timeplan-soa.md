---
synlighet: intern
godkjent: sant
tittel: "C# Advanced - 2-0: Timeplan"
slug: be03-2-0-soa-timeplan
---

# Timeplan

> For instruktører: Undervisnings øktene er delt opp i Teori med Praksis ca 50/50. Mink andelen teori, ikke praksis. For noen deler kan det være nok med 30 minutter teori/bakgrunn og 90 minutter praksis, legg inn 3-4 pauser. Total tid 120 minutter.

Denne uken arbeider du med tjenesteorienterte systemer gjennom en kombinasjon av teori og praksis.

## Tjeneste Orienterte Systemer (Service Oriented Architecture, SOA)

### 1. SOA - Intro

#### Teori

Du vil lære om:

- Tjenester fra den virkelige verden
- Grensesnitt mellom organisasjoner
- Kontainerteknologi
- Software standardisering av pakkeformat og grensesnitt
- Docker Desktop

#### Implementasjon

Du skal:

- Gå gjennom bygging av en .NET applikasjon, se på filer og hva som må kopieres over, samt hva som kreves av kjøretidsmiljøet
- Kontainerisere forrige ukes applikasjon
- Starte, stoppe, og ta imot miljøvariabler
- Lære om Docker Hub/Artefact Repositories
- Laste ned og teste ut noen eksterne containere (Nginx, PenPot, etc)

### 2. SOA - Komposisjoner

#### Teori

Du vil lære om:

- Docker Compose og fler-tjeneste komposisjoner

#### Implementasjon

Du skal:

- Kjøre opp .NET Web Server container via local build
- Sette opp en database med en Web UI (eks. PostgreSQL)
- Koble sammen server med databasen

### 3. SOA - Tjeneste Grensesnitt

#### Teori

Du vil lære om:

- Volumes og Networking
- Ressursbegrensning og rettigheter (se offisiell dokumentasjon)
- Vanlig tjenestearkitektur

  - Ingress
  - .NET Tjenester
  - Database
  - Autentiserings Tjeneste

#### Implementasjon

Du skal bygge ut tjenesten med:

- Dedikert ingress (Traefik)
- Statisk HTML, CSS & JS nettside
- En (eller flere) ASP .NET REST APIer
- En (eller flere) databaser

> For instruktører: Bruk path-based routing, ikke subdomene routing. Subdomener bærer ekstra kompleksitet og er primært for kompartmentalisering av risiko.
