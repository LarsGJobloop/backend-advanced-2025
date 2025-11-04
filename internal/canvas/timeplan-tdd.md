---
synlighet: intern
godkjent: sant
tittel: "C# Advanced - 1-0: Timeplan"
slug: be03-1-0-tdd-timeplan
---

# Timeplan — Testdrevet utvikling (TDD)

> For instruktører: Undervisningsøktene er delt opp i teori og praksis (ca. 50/50). Prioriter praksis fremfor teori – det er bedre med 30 minutter teori og 90 minutter praksis enn motsatt. Legg inn 3–4 korte pauser. Total tid per økt: ca. 120 minutter.

> For instruktører: Økta handler om å la deltakerne _oppleve_ TDD som metode, ikke forklare den. Det er viktig å la dem snuble litt — ikke gi løsningen for tidlig.

Denne uken arbeider du med testdrevet utvikling gjennom en kombinasjon av teori og praksis.

## Økt 1 — Introduksjon til TDD

**Varighet:** ~2 timer  
**Formål:** Du skal forstå TDD som en eksperimentell metode for å drive frem design.

### Teori (30–40 min)

Du vil lære om:

- Vitenskapelig metodikk - hva er det og hvordan kan vi anvende den i utvikling
- Eksperimenter for ingeniører:
  - Kartlegging og innsnevring av problem- og løsningsdomenet
- Grenser for kunnskap og eksperimenter (Gödel, Kant, Taleb)
- Hva betyr "å skrive tester først"? Hvorfor er det nyttig?

### Praksis (80–90 min)

Du skal arbeide med:

- **Rytme:** Red → Green → Refactor → Commit
- Liste opp forventede avhengigheter
- Starte med et **enkelt og kjent problem** (eks. _Calculator_)
- Implementere happy path først
- Utforske deretter edge cases

**Eksempelsekvens:**

1. Opprett en klasse: `Calculator`
2. Definer en metode: `Calculator.Add`
3. Skriv en test for et kjent utfall: `2 + 2 = 4`
4. Lag neste test. Formuler spørsmålene som driver neste steg
5. Utforsk edge cases:
   - Underflow / overflow
   - Division by zero
6. Diskuter hvordan maskinvarebegrensninger påvirker hva som faktisk _kan_ testes

## Økt 2 — Eksperimenter med TDD

**Varighet:** ~2 timer  
**Formål:** Du skal bruke TDD til å oppdage løsninger fremfor å bygge etter spesifikasjon.

### Teori (30 min)

Du skal:

- Lage en enkel kravspesifikasjon
- Skissere en flyt, med fokus på _grensesnittet_
- Ikke definere implementasjonen – det er det TDD skal avdekke

> For instruktører: Oppmuntre deltakerne til å være "naive" i denne fasen.

### Praksis (90 min)

Du skal arbeide med:

- **Rytme:** Red → Green → Refactor → Commit
- Diskutere hva som er viktigst å verifisere
- Skrive første test _før_ du lager programmet
- Jobbe deg iterativt videre, med små steg og hyppige commits

## Økt 3 — TDD og grensesnittskontrakter

**Varighet:** ~2 timer  
**Formål:** Du skal forstå verdien av stabile grensesnitt og hvordan TDD hjelper med det.

### Teori (30 min)

Du vil lære at:

- Programmene dine er bare små deler av et større system
- Det er **grensesnittene** som skaper stabilitet – ikke intern implementasjon
- Interne detaljer testes bare for å støtte forståelsen, ikke som mål i seg selv

### Praksis (90 min)

Du skal arbeide med:

- **Rytme:** Red → Green → Refactor → Commit
- Definere et RESTful API-grensesnitt
- Skrive tester for kontraktene, bryte dem opp etter behov
- Utforske edge cases for å drive frem arkitekturspørsmål:
  - Hva skjer ved server-restart?
  - Hva skjer når en ekstern API ikke svarer?
  - Hvordan bør feilhåndtering eksponeres?

## Oppsummering

> For instruktører: **Evalueringstemaer:**
>
> - Deltakeren følger rytmen (Red–Green–Refactor)
> - De tester _før_ de koder
> - De kan reflektere over hvordan TDD påvirker designvalg
> - De kan forklare hvorfor visse tester eksisterer
>
> **Tips for fasilitering:**
>
> - Bruk tid på refleksjon gjennom praksisøktene
> - Oppmuntre til å _snakke høyt_ om hva de forventer før de skriver tester
> - Ikke la øktene ende i "produksjonskode" – målet er læring, ikke ferdig produkt
