---
synlighet: intern
godkjent: usant
tittel: BE03 - IaC - Timeplan
slug: be03-iac-timeplan
canvas_id: null
---

# Timeplan

Undervisnings øktene er delt opp i Teori med Praksis ca 50/50. Mink andelen teori, ikke praksis. For noen deler kan det være nok med 30 minutter teori/bakgrunn og 90 minutter praksis, legg inn 3-4 pauser.

## Infrastrukt som Kode (Infrastructure as Code, IaC)

> [!NOTE]
>
> IaC er noe problemematisk å lære uten faktisk infrastrukur å jobbe med. Lokal ansvarlige bør få mulighet til å hente ut nøkkler fra Hetzner kontoen som de kan administrer for sine lokale deltakere. Viss umulig, så kan en benytte IaC til å administrere GitHub repoer (eller andre SaaS produkter), for å lære grunnleggende IaC konsepter.

### 1. IaC - Intro

#### Teori

- Gå inn i hva Versjons Kontrol er og hvorfor (Git)
- Reproduserbarhet som en forutsetning for verifikasjon/kvalitetssikring
- Moderne sky leverandører leverer APIer for å bestille og konfigurere hardware.
- IaC som bestilling/konfigurasjonen, Terraform CLI som aktøren
- Alternativer: OpenTofu som FOSS fork, Pulumi som programmeringspråk "SDK", REST/GraphQL som rå alternativer

#### Implementasjon

- Sett opp, og last opp SHH nøkkel (ikke bruk passord)
- Sett opp en Hetzner maskin igjennom det Web GUIen dems
- Logg på via SSH navigere litt rundt via terminalen (for å vise terminal bruk)
- Gå igjennom stegene manuelt for å sette opp Git og .NET
- Start serveren på 0.0.0.0
- Gå inn på serverens IP, og sjekk

### 2. IaC - Cloud Init

#### Teori

- Repeter reproduserbarhet og hvordan imperative installasjon via SHH ikke (/vanskelig) er gjentakbart
- Introduser Cloud Init som en liten standardisering av _Bootstrap_ prosessen.

#### Implementasjon

> [!NOTE]
>
> Ta små steg, og `terraform destroy` -> `terraform apply` etter hver endring.

- Gå igjennom å sett opp en server som installerer å setter opp Git, .NET og Docker Compose
- Legg til kloning av repoet vårt og starting av Docker Compose manifestet ved oppstart.

### 3. IaC - Moduler

#### Teori

- Introduser modularisering av kode
- Introduser Terraform moduler som Infrastruktur moduler

#### Implementasjon

- Dra vår `Hetzner Compose App Server` ut i en egen modul
- Parameteriser modulen
  - `variable`
  - `output`
  - Dokumentasjon og **sensitivitet**
- Viss tid så oppgrader Cloud Init med et rekonsilierings skript (`systemd` er enklest på Debian)
