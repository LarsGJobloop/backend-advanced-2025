---
synlighet: intern
livsyklus: utkast
tittel: BE03 - IAM - Introduksjon til Identitet og Tilgangsstyring
slug: be03-iam-introduksjon
---

# IAM - Introduksjon til Identitet og Tilgangsstyring

En introduksjon til hvordan identitet og tilgang håndteres i både den fysiske og digitale verdenen. Økten legger grunnlaget for å forstå hvordan digitale systemer bruker identitet og autorisasjon for å gi riktig tilgang til riktige brukere, på riktig tidspunkt.

## Teori

### Hva er Identitet og Tilgangsstyring?

**Identity and Access Management (IAM)** handler om å kontrollere _hvem_ som har _tilgang til hva_. Dette skjer både i fysiske og digitale kontekster. Målet er å sikre at rett person får rett tilgang, og at feil personer ikke gjør det.

IAM består av tre hovedkomponenter:

- **Identifikasjon:** Hvem hevder du å være?  
  Eksempel: Du viser førerkortet ditt.
- **Autentisering:** Hvordan beviser du at du er den du sier du er?  
  Eksempel: Politiet kontrollerer førerkortet mot Statens Vegvesen.
- **Autorisasjon:** Hva får du lov til å gjøre?  
  Eksempel: Du har førerkort for klasse B, ikke lastebil (C).

### Analogt eksempel - Trafikkontroll

For å forstå IAM er trafikkontroll et godt bilde:

1. Du blir stoppet av politiet (tilgangskontroll).
2. Du viser **førerkort** og **vognkort** – dette er _credentials_.
3. Politiet verifiserer dokumentene mot en _sentral autoritet_ (CA) — Statens Vegvesen.
4. Vegvesenet er igjen underlagt en overordnet autoritet — Den Norske Stat.

Dette eksempelet illustrerer hvordan tillit og identitet bygges i lag, et hierarki av autoriteter.

### Digitale paralleller

| Fysisk                             | Digitalt                                                |
| ---------------------------------- | ------------------------------------------------------- |
| Førerkort / Pass                   | JSON Web Token (JWT)                                    |
| Statens Vegvesen / Den Norske Stat | Sertifikatutsteder (Certificate Authority / CA)         |
| Politiet                           | Applikasjonen som kontrollerer tilgang                  |
| Legitimasjon                       | Autentiseringsdata (brukernavn, passord, nøkkel, token) |

Digitale systemer bruker det samme prinsippet: man får _digitale legitimasjonsdata_ utstedt, og signert, av en _autoritet_ (CA), som så kan verifiseres av systemet man prøver å få tilgang til.

Eksempler:

- **Private CA-er:** Facebook, Google, Microsoft Entra (Azure AD)
- **Offentlige CA-er:** BankID, eID, ID-porten.no
- **DNSSEC:** Et eksempel på autoritet og signering brukt for å sikre, verifisert, rettigheter til et domenenavn.

### Legitimasjonstyper

- Fødselsattest (grunnleggende identitet)
- Pass (offisiell identitet)
- Bankkort / BankID (verifisering av identitet i finansielle systemer)
- Førerkort (autorisasjon til spesifikke handlinger)
- Pengesedler (verifisering av identitet og tillit fra statlige autoriteter)

### JSON Web Tokens (JWT)

Et **JWT** er en digital legitimasjon som inneholder informasjon (_claims_) om brukeren, utstedt av en autoritet.  
Eksempel:

- `iss` – hvem utstedte tokenet (issuer)
- `sub` – hvem tokenet gjelder for (subject)
- `exp` – utløpstid (expiration time)
- `aud` – hvilket system tokenet er ment for (intended audience)

JWT-er kan inspiseres på [https://jwt.io](https://jwt.io) for å se struktur og innhold.

## Konkretisering

### Hva, hvor, når blir dette brukt?

IAM brukes i alt fra nettsider til nasjonale infrastrukturer:

- **Nettsider:** Pålogging med Google eller GitHub (OAuth2)
- **Bedriftssystemer:** Microsoft Entra / Azure AD for brukerkontroll
- **Bank og offentlig sektor:** BankID, eID
- **API-er:** Token-basert autentisering (JWT, OAuth)

Dette er fundamentalt for sikkerhet, personvern og drift av digitale systemer. Uten IAM vet ikke systemet _hvem du er_ eller _hva du får lov til å gjøre_.

### Eksempler på praksis

- En webserver mottar en HTTP request med et JWT i headeren og validerer det før tilgang gis.
- Et API kaller et annet API, men må først autentiseres via OAuth2.
- En GitHub OAuth App brukes for å hente brukerdata med samtykke.

### Eksterne Lenker

- [JSON Web Token (jwt.io)](https://jwt.io/)
- [OpenID Foundation](https://openid.net/)
- [OAuth 2.0 Framework (IETF RFC 6749)](https://datatracker.ietf.org/doc/html/rfc6749)
- [Microsoft Entra ID (Azure AD)](https://learn.microsoft.com/en-us/entra/)
- [BankID Norge](https://www.bankid.no/)

## Videre Lesing

- [NIST Digital Identity Guidelines (SP 800-63)](https://pages.nist.gov/800-63-3/)
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [OAuth 2 Simplified – Aaron Parecki](https://aaronparecki.com/oauth-2-simplified/)
- [Auth0 Blog – JWT Best Practices](https://auth0.com/blog/a-look-at-the-jwt-handbook/)

## Referanse Liste

- RFC 6749 - _The OAuth 2.0 Authorization Framework_
- RFC 7519 - _JSON Web Token (JWT)_
- NIST SP 800-63 - _Digital Identity Guidelines_
- Microsoft Entra ID Documentation
- BankID.no og ID-porten.no
