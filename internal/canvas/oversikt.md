---
synlighet: åpen
godkjent: usant
tittel: BE03 - Backend Advanced
---

# BE03 - Backend Advanced

## Formål

Denne modulen bygger videre på grunnleggende backend-utvikling og gir deltakerne praktisk erfaring med moderne verktøy og arbeidsformer.  
Gjennom fire uker skal du sette opp, utvikle og drifte en enkel applikasjon ved hjelp av testdrevet utvikling, containerisering og infrastruktur som kode.

## Læringsmål

Etter modulen skal du ha fått erfaring med:

- Å utvikle en liten backend-applikasjon med testdrevet utvikling (TDD).
- Å kjøre og sette sammen tjenester i containere ved hjelp av Docker og Docker Compose.
- Å bruke infrastruktur som kode (Terraform og Cloud-init) for å sette opp og oppdatere en server.
- Å bygge et lite CLI-verktøy som autentiserer via GitHub OAuth.
- Å forstå hvordan prinsipper som standardisering, versjonering og reproduserbarhet henger sammen i moderne utviklingsmiljøer.

## Stillingsutlysningsordbok - **Gate Buster List**

- Infrastructure as Code (IaC) / Terraform
- Kontainerteknologi / Docker
- Test Driven Development (TDD) / Løsningsverifisering
- Identity og tilgangsstyring (IAM) / OAuth / RBAC / ABAC / PBAC
- Service Oriented Architecture (SOA) / Microservices
- GitOps / DevOps

## Leveranser

### Uke 1 - TDD-basert Web API

- **Mål:** Utforske hvordan testdrevet utvikling kan brukes til å bygge en liten API-tjeneste.
- **Leveranse:** Et lite ASP.NET Web API utviklet med TDD for et avgrenset domene.
- **Verktøy:** xUnit, MVC Testing Framework.

### Uke 2 - Docker Compose-applikasjon

- **Mål:** Lære hvordan man containeriserer applikasjoner og kobler dem sammen i et enkelt system.
- **Leveranse:** Et Docker Compose-manifest som inkluderer:
  - Ingress (f.eks. Traefik)
  - Domenetjeneste (f.eks. ASP.NET Web API)
  - Database (f.eks. PostgreSQL)
  - Parametrisering for lokale og «produksjons»-miljøer

### Uke 3 - Infrastruktur som kode (IaC)

- **Mål:** Få innsikt i hvordan infrastruktur kan defineres og kjøres som kode.
- **Leveranse:** En Terraform- og Cloud-init-basert løsning som setter opp en Hetzner-server:
  - Kjører og oppdaterer Docker Compose-applikasjonen
  - Parametrisert rekonsiliering mot Git-repositorium

### Uke 4 - .NET CLI med autentisering

- **Mål:** Utforske autentisering via tredjepart og bygging av enkle CLI-verktøy.
- **Leveranse:** En .NET CLI-applikasjon med:
  - GitHub OAuth-autentisering
  - In-memory lagring av Access- og Refresh-tokens
  - Uthenting av tilgangsbegrensede ressurser”

## Teknologier

- **Utvikling og testing:** ASP.NET, xUnit
- **Containere:** Docker, Docker Compose
- **Infrastruktur:** Terraform, Cloud-init
- **Autentisering:** GitHub OAuth, JSON Web Tokens (JWT)

## Utviklingspraksis og metode _(aktivt vurdert)_

Dette er den sentrale læringsdelen i modulen og danner grunnlaget for vurdering.  
Den handler om **hvordan** du utvikler – ikke bare hva du bygger.

- Testdrevet utvikling (TDD) som metode for å drive fram design og funksjonalitet.
- Vitenskapelig metode brukt som ramme for eksperimentering og hypotesetesting i kode.
- Kontinuerlig integrering og læring som del av utviklingsløpet.
- Versjonering og standardisering som verktøy for kvalitet og reproduserbarhet.

## Bakenforliggende konsepter _(ikke vurdert direkte)_

Disse temaene danner bakteppet for modulens praksis og brukes som referanser i refleksjon, diskusjon og demonstrasjon.

### Arkitektur og systemforståelse

- Tjenesteorienterte arkitekturer (SOA) og modulær tenkning.
- Containerteknologi og isolasjon av ansvar.
- GitOps og “kilde som sannhet”-prinsippet.

### Kryptografi og tillit

- **Nøkler og identitet:** SSH og sertifikater.
- **Tokens og legitimasjon:** JWT, OAuth og OpenID Connect.
- **Tillit:** Hvordan systemer etablerer og beviser tilganger mellom aktører.

### Tilgangsstyring

- **RBAC:** Role-Based Access Control
- **ABAC:** Attribute-Based Access Control
- **PBAC:** Policy-Based Access Control
- **ReBAC:** Relationship-Based Access Control

## Oppsummering

Modulen fokuserer på å **bygge og forstå**, med vekt på utviklingspraksis og refleksjon rundt hvordan man nærmer seg problemløsning.  
Gjennom fire praktiske leveranser får du erfaring med å utvikle, containerisere og drifte en backend-tjeneste på en reproduserbar måte. Fra kode til enkel produksjonssetting.
