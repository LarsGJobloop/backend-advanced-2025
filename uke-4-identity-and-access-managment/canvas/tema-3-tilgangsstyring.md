---
synlighet: intern
livsyklus: utkast
tittel: BE03 - IAM - Tilgangsstyring i praksis
slug: be03-iam-tilgangsstyring
---

# Tilgangsstyring i praksis

Når identitet og autentisering er etablert, gjenstår det viktigste spørsmålet:  
**Hva får du lov til å gjøre, og hvorfor?**  
Denne økten handler om hvordan systemer **håndhever rettigheter**, og hvordan ulike modeller for tilgangsstyring kan kombineres i praksis.

## Teori

### Oversikt over tilgangsstyringsmodeller

IAM handler ikke bare om å vite hvem du er, men også om å bestemme hva du får gjøre.  
Flere tilnærminger eksisterer, og de overlapper ofte i moderne systemer.

#### RBAC - Role Based Access Control

Rettigheter tildeles basert på **roller**.  
Eksempel:

- _Administrator_ → kan lese, skrive og slette
- _Bruker_ → kan lese og opprette
- _Gjest_ → kun lese

Fordel: Enkelt å forstå og implementere.  
Ulempe: Kan bli rigid og vanskelig å skalere ved mange roller.

#### ABAC - Attribute Based Access Control

Tilgang bestemmes av **attributter** knyttet til bruker, ressurs og kontekst.  
Eksempel:  
_Brukeren får tilgang dersom (rolle == 'ansatt') og (tidspunkt mellom 08:00–18:00)._

Fordel: Fleksibel og dynamisk.  
Ulempe: Krever presis policydefinisjon og mer kompleks evaluering.

#### PBAC - Policy Based Access Control

Tilgang styres av **deklarative regler (policies)**, gjerne uttrykt som kode.  
Eksempel:  
Et GitHub-team har policyer som definerer hvem som kan opprette repositories, hvem som kan godkjenne Pull Requests (PR-er), osv.

Fordel: Gir revisjonsmuligheter og “as code”-styring.  
Ulempe: Mer krevende å teste og validere.

#### ReBAC - Relationship Based Access Control

Tilgang bestemmes av **relasjoner** mellom aktører og ressurser.  
Eksempel:  
I Discord eller GitHub:

- _Du kan endre dette repoet fordi du er medlem av et team som eier det._

Fordel: Godt egnet for sosiale, samarbeids- og organisasjonsstrukturer.  
Ulempe: Vanskeligere å visualisere og kontrollere uten gode verktøy.

### Kombinerte modeller

I virkeligheten kombineres modellene:

- GitHub bruker **RBAC + PBAC** (team og rettningslinjer).
- Discord bruker **ReBAC + ABAC** (roller, kanaltilgang, og kontekstuelle attributter).
- Skyplattformer som Azure og AWS kombinerer **PBAC + ABAC** (IAM-rettningslinjer med betingelser).

## Konkretisering

### Hva, hvor, når blir dette brukt?

Tilgangsstyring er grunnleggende i alle moderne systemer:

- **Organisasjonsstrukturer:** Hvem kan endre innstillinger, hvem kan lese data?
- **Plattformstyring:** GitHub, Discord, Azure, AWS bruker alle kombinasjoner av RBAC, ABAC, PBAC og ReBAC.
- **Sikkerhet og compliance:** Nødvendig for å oppfylle regulatoriske krav og sikre data.

### Eksempler

**Observasjonsøvelse - Studentene analyserer eksisterende systemer som IAM-eksempler:**

#### Discord

- Roller, attributter og tillatelser
- Hvordan tillatelser arves og overstyres
- Hva skjer når en rolle fjernes eller legges til?  
  → **Diskusjon:** Hvordan håndheves tillit og eier?

#### GitHub

- Hvem kan endre repo-innstillinger?
- Hvordan kombineres organisasjonsnivå (RBAC) og repository-rettningslinjer (PBAC)?
- Hva skjer hvis en bruker mister teamtilgang, men fortsatt har en åpen PR?

Disse observasjonene gjør IAM-begrepene konkrete og viser hvordan tillit implementeres gjennom kode, konfigurasjon og praksis.

### Eksterne Lenker

- [Discord Developer Docs – Permissions & Roles](https://discord.com/developers/docs/topics/permissions)
- [GitHub Docs – Managing Access to Repositories](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories)
- [NIST SP 800-192 – Access Control Models](https://csrc.nist.gov/publications/detail/sp/800-192/final)

## Videre Lesing

- _Policy as Code_ (HashiCorp Sentinel, Open Policy Agent)
- [NIST SP 800-162 – Attribute Based Access Control](https://csrc.nist.gov/publications/detail/sp/800-162/final)
- [Zanzibar: Google's Consistent, Global Authorization System](https://research.google/pubs/pub48190/)

## Referanse Liste

- GitHub Docs – Access Management
- NIST 800-192 og 800-162 – Access Control Standard Models
- Google Research – Zanzibar whitepaper
- Open Policy Agent – [https://www.openpolicyagent.org](https://www.openpolicyagent.org)
