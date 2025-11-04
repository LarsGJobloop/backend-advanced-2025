---
synlighet: intern
godkjent: sant
tittel: "C# Advanced - 4-0: Timeplan"
slug: be03-4-0-iam-timeplan
---

# Timeplan - Identity and Access Management (IAM)

> For instruktører: Undervisningen er delt i tre økter på 2 timer. Ca. 30-40 min teori per økt, resten praksis og diskusjon. Legg inn 3-4 korte pauser, helst i overgangene mellom teori og praksis.

Denne uken arbeider du med identitet og tilgangsstyring gjennom en kombinasjon av teori og praksis.

## Økt 1 - Identitet, legitimasjon og tillit

> For instruktører: Bruk konkrete, sansbare eksempler - trafikkontroll fungerer godt. Hjelp studentene å forstå at "identitet" og "autoritet" alltid er relasjonelle konsepter.

### Teori

Du vil lære om:

- Hvordan systemer etablerer identitet og tillit:
  1. Trafikkontroll: førerkort og vognkort → autoriteter (f.eks. Statens Vegvesen, Politiet)
  2. Legitimasjon i digital sammenheng: Pass → CA, JWT → Signatur
- Legitimasjonstyper:
  - Fødselsattest, pass, BankID, penger, førerkort
  - Digitale analoger: JSON Web Token, sertifikater, OAuth-leverandører
- Autoriteter:
  - Offentlige: BankID, eID
  - Private: Google, GitHub, Microsoft Entra ID
- Hvorfor tillit er kjernen i IAM

### Praksis

Du skal:

- Bruke [jwt.io](https://jwt.io) til å inspisere et eksempel JWT
- Identifisere `header`, `payload`, `signature`
- Diskutere forskjellen på `Claims` og `Scopes`
- Demonstrer i .NET:
  - Lese et token fra `HttpContext.Request.Headers["Authorization"]`-headeren
  - Parse det med `System.IdentityModel.Tokens.Jwt`-biblioteket

### Refleksjon

Du skal reflektere over:

- Hvordan beviser et system at det er "deg" eller "en person"?
- Hvor kommer egentlig tilliten fra?

## Økt 2 - OAuth 2.0 og GitHub CLI-autentisering

**Mål:** Du skal forstå og implementere en fungerende GitHub-OAuth-flyt i en .NET-CLI.

### Teori

Du vil lære om:

- OAuth 2.0 - rollene og flyten:
  - Resource Owner, Client, Authorization Server, Resource Server
- Authorization Code Flow:
  - Bruker gir samtykke → kode → token → tilgang
- Consent og scopes - hvordan GitHub definerer hva en app får gjøre
- Hvorfor OAuth ikke i seg selv håndterer identitet (men kan kombineres med OpenID Connect for det)

### Praksis

Du skal:

- Registrere en GitHub OAuth-app
- Sette opp `Redirect URI`, `Client ID`, `Client Secret`
- Implementere i .NET CLI:
  1. Åpne Authorization URL i nettleser
  2. Motta `Authorization Code` via `localhost` callback
  3. Bytte code → token
  4. Kalle GitHub API (`https://api.github.com/user/repos`) med `Authorization: Bearer <token>`
- Diskutere hva som skjer under panseret (HTTP flows, consent, tokens)

### Ressurser

- [GitHub OAuth Apps Documentation](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps)
- [.NET HttpClient for OAuth flows (Microsoft Docs)](https://learn.microsoft.com/en/dotnet/api/system.net.http.httpclient)

### Refleksjon

Du skal reflektere over:

- Hva er forskjellen på "Autentisering" og "Autorisasjon" her?
- Hvilke data stoler GitHub egentlig på?

## Økt 3 - Tilgangsstyring i praksis

> For instruktører: Denne økten holdes hovedsakelig som samtale, analyse og demonstrasjon. Unngå ny kode, la studentene bruke observasjon og refleksjon for å lære.

### Teori

Du vil lære om:

- RBAC (Role Based Access Control)  
  Roller → rettigheter (f.eks. "admin", "member")
- ABAC (Attribute Based Access Control)  
  Beslutning basert på attributter (tid, sted, eierskap)
- PBAC (Policy Based Access Control)  
  Regler og policies (eks. GitHubs team- og org-policies)
- ReBAC (Relationship Based Access Control)  
  Relasjoner styrer tilgang (eks. Discord-serverroller eller GitHub-repo-tilganger)

### Demonstrasjon / Diskusjon

Du skal:

- Analysere Discord som et IAM-system:
  - Roller, attributter og tillatelser
  - Hvem eier ressursene, og hvem setter policyene?
- Se på GitHub org-nivå:
  - Hvordan RBAC + PBAC kombineres (teams + repository-innstillinger)
- Diskutere hvordan disse prinsippene ville sett ut i en egen applikasjon

### Ressurser

- [Discord Developer Docs – Permissions & Roles](https://discord.com/developers/docs/topics/permissions)
- [GitHub Docs – Managing Access to Repositories](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories)
- [NIST – Access Control Models](https://csrc.nist.gov/publications/detail/sp/800-192/final)

### Refleksjon

Du skal reflektere over:

- Hvordan kan en policy beskrives som kode?
- Hvilke kompromisser ser du mellom fleksibilitet og sikkerhet?

## Struktur for hver økt

| Tid         | Innhold                                |
| ----------- | -------------------------------------- |
| 0–30 min    | Teori / introduksjon                   |
| 30–90 min   | Praksis, demo eller observasjonsøvelse |
| 90–105 min  | Pause og spørsmål                      |
| 105–120 min | Oppsummering / refleksjon              |

## Kort oppsummering

Uke 4 avslutter modulen ved å binde sammen utviklingspraksis og sikkerhet:  
fra hvordan identitet etableres, til hvordan autorisasjon håndheves i distribuerte systemer.  
Du skal **forstå IAM som konsept** og **beherske en fungerende OAuth-flow i .NET** – nok til å bygge videre på dette i egne prosjekter.
