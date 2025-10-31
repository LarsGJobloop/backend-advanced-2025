---
synlighet: intern
godkjent: usant
tittel: BE03 - IAM - Timeplan
slug: be03-iam-timeplan
---

# Timeplan

Undervisnings øktene er delt opp i Teori med Praksis ca 50/50. Mink andelen teori, ikke praksis. For noen deler kan det være nok med 30 minutter teori/bakgrunn og 90 minutter praksis, legg inn 3-4 pauser.

## Identity and Access Management

### 1. IAM - Intro

> [!NOTE]
>
> Dette kan fort bli veldig abstrakt og komplekst. Eksemplet jeg har benyttet er Trafikk Kontrol, siden det favner bredt. Viss gruppen ikke er kjent med bilkjøring, så link det opp mot noe annet (eks. Ferie/Utenlandsreise).
>
> Det er viktig at de har noen konkrete erfaringer å koble disse konseptene mot. Så bruk mer tid på Teori her om nødvendig.

#### Teori

- Hvordan virker dette? Gå igjennom eks:

  1. Blir stoppet i trafikk kontroll
  2. Blir bedt om Førerkort (credential) og Vognkort (credential)
  3. Vognkort -> Statens Vegvesen (CA)
  4. Førerkort -> Statens Vegvesen -> Den Norske Stat (CA)

- Legitimasjon:

  - Fødsels Attest
  - Pass
  - Bank Kort
  - BankID
  - Penge Sedler
  - Førerkort

- Autoriteter:

  - Statens Vegevesen
  - Den Norske Stat
  - Politiet

- Digitale varianter

  - Legitimasjon -> JSON Web Token
  - Autoriteter (Central Authority/CA):
    - Private -> Facebook, GMail, Microsoft Entra
    - Offentlige -> BankID, eID
  - DNS med DNSSEC

#### Implementasjon

- Kort, Gå igjennom hvordan JSON Web Tokens ser, hva de innholder (https://jwt.io/).
- Les av i en Web Server, Request

### 2. IAM - Credentials and Tokens

#### Teori

- Open Authentication 2.0
- GitHub OAuth Apps

#### Implementasjon

- Registrer en GitHub OAuth App
- Sett opp en CLI for GitHub OAuth autentisering (ikke lagre token vi får tilbake)
- Se på claims og scopes for hva du kan spørre om
- Gå igjennom Consent skjermen til GitHub (vis gjerne Android/Chrome sine)

### 3. IAM - Tilgangsstyrings Modeller

> [!NOTE]
>
> Igjen mye teori. Dra inn andre eksempler (ex. Discord, GitHub) som kan vise et eksisterend systemer

#### Teori

- Tilgangstyring i virkeligheten (Førerkort, Flyplass, Kontor)

#### Implementasjon
