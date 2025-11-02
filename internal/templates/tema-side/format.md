---
status: akseptert
---

# Tema Side Format

Vi trenger et format for å presentere undervisnings tema på.

Dette er noe som ikke blir endelig avgjort her, men vi trenger noe som fungerer til det formelle er på plass. Dette dokumentet er en arbeidsmal basert på de beste eksemplene fra eksisterende sider, og kan brukes som referanse inntil en autoritativ kilde er etablert.

## Front Matter (Metadata)

Alle tema-sider skal ha front matter i YAML-format øverst i filen:

```yaml
---
synlighet: intern | åpen
livsyklus: utkast | høring | akseptert
tittel: <Kurs kode> - <Tema kortnavn> - <Full tittel>
slug: <url-slug-for-siden>
---
```

**Felt beskrivelse:**

- `synlighet`: `intern` for kun interne sider, `åpen` for åpne/publiserte sider
- `livsyklus`: `utkast` (work in progress), `høring` (klar for review), `akseptert` (ferdig)
- `tittel`: Full tittel som vises i Canvas, følg formatet: `<Kurs kode> - <Tema kortnavn> - <Full tittel>`
- `slug`: URL-vennlig identifikator, bruk formatet: `<kurskode>-<tema>-<kortnavn>`

## Dokument Struktur

### 1. Hovedtittel

Bruk en `#` H1-overskrift med temaets navn som første element etter front matter.

### 2. Inledning (valgfritt)

En kort introduksjon som gir kontekst og mål for temaet. Ikke mer enn 1-2 avsnitt.

### 3. Teori

Dette er hovedseksjonen for den teoretiske bakgrunnen. Strukturer innholdet med underseksjoner (`###`) for bedre lesbarhet.

**Innhold:**

- Grunnleggende konsepter og prinsipper
- Teoretisk bakgrunn og inspirasjonskilder
- Relasjoner og sammenhenger (bruk tegninger/kart der det er nyttig)
- Lenk til autoritative kilder der relevant

**Tips:**

- Del opp i logiske underseksjoner med `###`-overskrifter
- Bruk eksempler og analogier for å illustrere komplekse konsepter
- Legg til lenker direkte i teksten eller i en dedikert "Eksterne lenker"-seksjon

### 4. Konkretisering

Beskriv hvordan temaet brukes i praksis.

**Underseksjoner:**

#### Hva, hvor, når blir dette brukt?

Beskriv konkrete bruksområder og scenarioer.

#### Eksempler (valgfritt)

- Kodeeksempler med forklaringer
- Praktiske øvelser
- Git repositories fra undervisning
- Eksterne eksempler

#### Eksterne Lenker

- Linker til relevante dokumentasjoner, verktøy, eller ressurser
- Organiser som en punktliste med beskrivende tekst

### 5. Videre Lesing

Anbefalinger for utdypende lesestoff:

- Bøker
- Artikler
- Online ressurser
- Kurs eller opplæringsprogrammer

Format: Punktliste med forfatter/tittel og eventuelt lenker.

### 6. Referanse Liste

Formelle referanser i akademisk stil:

- Bøker med forfatter, år, tittel, utgiver
- RFC-er med nummer og tittel
- Standarder med organisasjon og navn
- Artikler med fullt citat

## Mal og Eksempel

Se [mal-tema-side.md](./mal-tema-side.md) for en komplett mal som kan brukes som utgangspunkt når du lager nye tema-sider.
