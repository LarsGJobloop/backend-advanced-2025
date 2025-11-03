---
synlighet: intern
livsyklus: utkast
tittel: "C# Advanced - 3-1: Introduksjon til deklarative infrastruktur"
slug: be03-3-1-iac-introduksjon
---

# Introduksjon til Infrastruktur som Kode (IaC)

En introduksjon til hvordan moderne infrastruktur administreres som kode – versjonert, reproduserbar og automatisert. Målet er å forstå prinsippene bak deklarativ infrastruktur og få førstehånds erfaring med verktøy som Terraform.

## Teori

### Hva er Infrastruktur som Kode?

Infrastructure as Code (IaC) handler om å beskrive og opprette IT-infrastruktur gjennom kode i stedet for manuelle prosesser. I stedet for å “klikke” seg gjennom et webgrensesnitt for å opprette servere og nettverk, defineres ønsket tilstand i tekstfiler – og et verktøy sørger for å implementere denne tilstanden.

Grunntanken er **reproduserbarhet og sporbarhet**:

- All infrastrukturkonfigurasjon lagres i versjonskontroll (Git).
- Endringer kan revideres, testes og rulles tilbake.
- Man kan bygge identiske miljøer på tvers av utvikling, test og produksjon.

### Versjonskontroll og Reproduserbarhet

Versjonskontrollsystemer som **Git** gir historikk og samarbeid rundt infrastrukturkode. Dette muliggjør reproduserbarhet — samme kode gir samme miljø, og dermed høyere kvalitet og forutsigbarhet.

Reproduserbarhet er en forutsetning for kvalitetssikring og verifikasjon: uten versjonskontroll vet man aldri sikkert hvilken konfigurasjon som produserte et gitt system.

### API-er som grensesnitt mot skyen

Moderne skyleverandører som AWS, Azure og Hetzner tilbyr API-er for å bestille, konfigurere og administrere infrastruktur. IaC-verktøy fungerer som “klienter” til disse API-ene, slik at utviklere kan beskrive ressursene som kode.

### Verktøy og Paradigmer

- **Terraform** – Deklarativt verktøy for å beskrive ønsket tilstand og la motoren sørge for at virkeligheten matcher denne.
- **OpenTofu** – Fri og åpen kildekode-fork av Terraform.
- **Pulumi** – Tilbyr IaC via tradisjonelle programmeringsspråk (TypeScript, Python, Go, m.fl.).
- **REST/GraphQL** – Rå alternativer for manuell orkestrering av infrastruktur.

IaC kan altså sees som et uttrykk for **deklarativ programmering** anvendt på infrastruktur: “Hva skal eksistere” heller enn “hvordan det opprettes”.

## Konkretisering

### Hva, hvor, når blir dette brukt?

Dette er et fundamentalt tema for alle som jobber med moderne IT-drift, DevOps og skyarkitektur:

- **Skyinfrastruktur:** Oppsett av servere, nettverk og lagring i Hetzner, AWS, Azure, GCP.
- **Automatisering:** Bruk av CI/CD for å realisere infrastrukturendringer automatisk.
- **Reproduserbarhet:** Kloning av et helt miljø til en ny region eller kunde med en kommando.
- **GitOps:** Drift av infrastruktur gjennom Git som "source of truth".

### Eksempler

I praksisdelen av denne økten kommer dere til å lære hvordan man:

- Generere SSH-nøkler og koble seg til en Hetzner-instans.
- Opprette og konfigurere en server gjennom et webgrensesnitt.
- Bruke Git til å versjonere konfigurasjonen.
- Bruke Terraform til å realisere infrastruktur som kode.

### Eksterne Lenker

- [Terraform.io – Dokumentasjon](https://developer.hashicorp.com/terraform/docs)
- [OpenTofu – Open Source Terraform Fork](https://opentofu.org/)
- [Pulumi – Infrastructure as Code via Programming Languages](https://www.pulumi.com/)
- [Hetzner Cloud API](https://docs.hetzner.cloud/)

## Videre Lesing

- **"The Phoenix Project"** – Roman som illustrerer hvorfor automatisering og DevOps er avgjørende.
- **"Terraform: Up and Running"** av Yevgeniy Brikman – Praktisk bok om IaC i produksjon.
- **HashiCorp Learn: Terraform** – Interaktive guider og opplæringslabber.

## Referanse Liste

- HashiCorp Terraform-dokumentasjon: [https://developer.hashicorp.com/terraform](https://developer.hashicorp.com/terraform)
- Hetzner Cloud API-dokumentasjon: [https://docs.hetzner.cloud](https://docs.hetzner.cloud)
- OpenTofu-prosjekt: [https://github.com/opentofu/opentofu](https://github.com/opentofu/opentofu)
