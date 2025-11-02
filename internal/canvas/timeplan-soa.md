---
synlighet: intern
godkjent: usant
tittel: BE03 - SOA - Timeplan
slug: be03-soa-timeplan
---

# Timeplan

Undervisnings øktene er delt opp i Teori med Praksis ca 50/50. Mink andelen teori, ikke praksis. For noen deler kan det være nok med 30 minutter teori/bakgrunn og 90 minutter praksis, legg inn 3-4 pauser. Total tid 120 minutter.

## Tjeneste Orienterte Systemer (Service Oriented Architecture, SOA)

### 1. SOA - Intro

#### Teori

- Tjenester fra den virkelige verden
- Grensesnitt mellom organisasjoner
- Kontainer Teknologi
- Software Standardisering av pakke format og grensesnitt
- Docker Desktop

#### Implementasjon

- Gå igjennom bygging av en .NET applikasjon, se på filer og hva som må kopieres over, samt hva som kreves av kjøretids miljøet
- Kontaineriser forrige ukes applikasjon
- Start, stopp, ta imot miljø variabler
- Introduser Docker Hub/Artefact Repositories
- Last ned og test ut noen ekstern containere (Nginx, PenPot, etc)

### 2. SOA - Komposisjoner

#### Teori

- Kort, Docker Compose, fler-tjeneste komposisjoner

#### Implementasjon

- Kjør opp .NET Web Server container via local build
- Sett opp en database med en Web UI (eks. PostgreSQL)
- Koble sammen server med databasen (ikke tenk komplekst her)

### 3. SOA - Tjeneste Grensesnitt

#### Teori

- Introduser Volumes og Networking
- Pek på ressurs begrensning og rettigheter (henvis til offisiell dokumentasjon)
- Introduser vanlig Tjeneste arkitektur

  - Ingress
  - .NET Tjenester
  - Database
  - Autentiserings Tjeneste

#### Implementasjon

- Bygg ut tjenesten vår med (en holder):

  - Dedikert ingress (Traefik)
  - Statisk HTML, CSS & JS nettside
  - En (eller flere) ASP .NET REST APIer
  - En (eller flere) databaser

> [!NOTE]
>
> Traefik støtter subdomener, men dette blir brukt som en sikkerhets mekanisme og bærer en del ekstra med seg. Så gjerne nevn det, men ikke bruk.
