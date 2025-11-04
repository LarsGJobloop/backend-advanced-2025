---
synlighet: intern
godkjent: sant
tittel: "C# Advanced - 3-0: Timeplan"
slug: be03-3-0-iac-timeplan
---

# Timeplan

> For instruktører: Undervisnings øktene er delt opp i Teori med Praksis ca 50/50. Mink andelen teori, ikke praksis. For noen deler kan det være nok med 30 minutter teori/bakgrunn og 90 minutter praksis, legg inn 3-4 pauser.

Denne uken arbeider du med Infrastruktur som kode gjennom en kombinasjon av teori og praksis.

## Infrastruktur som Kode (Infrastructure as Code, IaC)

> For instruktører: IaC er noe problemematisk å lære uten faktisk infrastruktur å jobbe med. Lokal ansvarlige bør få mulighet til å hente ut nøkkler fra Hetzner kontoen som de kan administrere for sine lokale deltakere. Viss umulig, så kan en benytte IaC til å administrere GitHub repoer (eller andre SaaS produkter), for å lære grunnleggende IaC konsepter.

### 1. IaC - Intro

#### Teori

Du vil lære om:

- Hva versjonskontroll er og hvorfor det er viktig (Git)
- Reproduserbarhet som en forutsetning for verifikasjon/kvalitetssikring
- Hvordan moderne sky leverandører leverer APIer for å bestille og konfigurere produkter
- IaC som bestilling/konfigurasjonen, Terraform CLI som aktøren
- Alternativer: OpenTofu som FOSS fork, Pulumi som programmeringspråk "SDK", REST/GraphQL som rå alternativer

#### Implementasjon

Du skal:

- Sette opp og laste opp SSH nøkkel (ikke bruk passord)
- Sette opp en Hetzner maskin gjennom deres Web GUI
- Logge på via SSH og navigere rundt via terminalen
- Gå gjennom stegene manuelt for å sette opp Git og .NET
- Starte serveren på 0.0.0.0
- Gå inn på serverens IP og sjekke at alt fungerer

### 2. IaC - Cloud Init

#### Teori

Du vil:

- Repetere reproduserbarhet og se hvordan imperativ installasjon via SSH ikke er (enkelt) gjentakbar
- Lære om Cloud Init som en standardisering av _Bootstrap_ prosessen

#### Implementasjon

> For instruktører: Ta små steg, og `terraform destroy` -> `terraform apply` etter hver endring.

Du skal:

- Gå gjennom å sette opp en server som installerer og setter opp Git, .NET og Docker Compose
- Legge til kloning av repoet og starting av Docker Compose manifestet ved oppstart

### 3. IaC - Moduler

#### Teori

Du vil:

- Lære om modularisering av kode
- Lære om Terraform moduler som infrastruktur moduler

#### Implementasjon

Du skal:

- Dra ut `Hetzner Compose App Server` i en egen modul
- Parameterisere modulen
  - `variable`
  - `output`
  - Dokumentasjon og **sensitivitet**
- Hvis tid tillater, oppgradere Cloud Init med et rekonsilierings skript (`systemd` er enklest på Debian)
