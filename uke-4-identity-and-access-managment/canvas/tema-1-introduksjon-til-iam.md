---
synlighet: intern
livsyklus: akseptert
tittel: "C# Advanced - 4-1: Introduksjon til Identitet og Tilgangsstyring"
slug: be03-4-1-iam-introduksjon
---

# Introduksjon til Identitet og Tilgangsstyring

IAM (Identity and Access Management) handler om hvordan systemer vet **hvem du er**, **hva du kan gjøre**, og **hvorfor de stoler på deg**.  
Denne økten etablerer grunnlaget for forståelsen av identitet, legitimasjon og tillit, både i fysiske og digitale systemer.

## Teori

### Identitet og tillit i praksis

For å forstå identitet i digitale systemer, starter vi med et konkret eksempel:  
Ved en **trafikkontroll** må du bevise at du er deg (førerkort), at du har lov til å kjøre kjøretøyet (vognkort), og at begge dokumentene er gyldige og utstedt av en **autoritativ kilde** (Statens Vegvesen, Politiet).  
Dette danner et bilde av **autentisering (bevise hvem du er)** og **autorisasjon (hva du får lov til)**.

### Digitale analoger

I digitale systemer er disse dokumentene erstattet av elektroniske bevis:

- **Fødselsattest / Pass** → Sertifikater og signaturer (f.eks. CA, X.509)
- **Førerkort / BankID** → eID-tjenester og Identitetsleverandører (IdP)
- **Vognkort / medlemskort** → JSON Web Tokens (JWTs) og OAuth 2.0-tokens

Når en applikasjon mottar et **JWT**, validerer den:

1. **Header** – signaturalgoritme og nøkkel-ID
2. **Payload** – påstander (_Claims_) om identitet, rolle eller rettigheter
3. **Signature** – kryptografisk bevis på at innholdet ikke er manipulert

Dette gir grunnlaget for tillit i distribuerte systemer uten sentral kontroll.

### Autoriteter og tillit

Tillit i IAM bygges opp gjennom **kjeder av autoritet**:

- Offentlige: BankID, eIDAS, Skatteetaten
- Private: Google, GitHub, Microsoft Entra ID

Systemer må definere **hvilke autoriteter de stoler på**, og hvilke mekanismer som brukes for å bekrefte deres signaturer.  
Til slutt er tillit alltid **relasjonell**, den eksisterer mellom aktører, ikke som en egen entitet.

## Konkretisering

### Hva, hvor, når blir dette brukt?

IAM ligger i kjernen av nesten all moderne programvare:

- Når du **logger inn med Google** på en ekstern nettside.
- Når en **API-gateway** sjekker et Access Token før et kall.
- Når en **bedrift håndterer roller og rettigheter** i Microsoft Entra ID.
- Når **GitHub** bestemmer om du kan "push" til et repository.

Dette gjør IAM fundamentalt for både sikkerhet, brukervennlighet og drift.

### Eksempler

- Inspiser et JWT på [jwt.io](https://jwt.io)  
  → Finn `Header`, `Payload`, `Signature`  
  → Diskuter forskjellen mellom _Claims_ (hva tokenet sier) og _Scopes_ (hva det gir tilgang til)

- I en .NET handler:
  ```csharp
  var token = HttpContext.Request.Headers["Authorization"];
  var handler = new JwtSecurityTokenHandler();
  var jwt = handler.ReadJwtToken(token);
  ```

### Eksterne Lenker

- [JWT.io – Debugger og dokumentasjon](https://jwt.io)
- [Microsoft – System.IdentityModel.Tokens.Jwt](https://learn.microsoft.com/en/dotnet/api/system.identitymodel.tokens.jwt)
- [NIST – Digital Identity Guidelines](https://pages.nist.gov/800-63-3/)

## Videre Lesing

- **OAuth 2.0** – hvordan tillit overføres mellom systemer.
- **OpenID Connect** – hvordan identitet bygges på toppen av OAuth.
- **“The Path to Zero Trust” (Microsoft Learn)** – forstå hvordan identitet blir et kontrollpunkt i moderne arkitektur.

## Referanse Liste

- [RFC 7519 – JSON Web Token (JWT)](https://datatracker.ietf.org/doc/html/rfc7519)
- [RFC 6749 – OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749)
- [NIST SP 800-63-3 – Digital Identity Guidelines](https://pages.nist.gov/800-63-3/)
