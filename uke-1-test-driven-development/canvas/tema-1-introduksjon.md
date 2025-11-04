---
synlighet: intern
livsyklus: akseptert
tittel: "C# Advanced - 1-1: Introduksjon til Testdrevet utvikling"
slug: be03-1-1-tdd-introduksjon
---

# Introduksjon til Testdrevet Utvikling (TDD)

TDD (Test-Driven Development) er en metode for programvareutvikling der tester skrives **før** selve koden.  
Hensikten er ikke primært å teste, men å **utforske og forme design** gjennom eksperimenter (forsøk og feil).

## Teori

### Fra vitenskap til utvikling

Testdrevet utvikling bygger på prinsippene fra vitenskapelig metode:
du formulerer en hypotese (test), utfører et eksperiment (implementasjon), og evaluerer resultatet (refaktorering).

I stedet for å starte med en ferdig spesifikasjon, bruker du TDD til å **utforske** løsninger:

- **Observasjon:** Hva er problemet vi forsøker å løse?
- **Hypotese:** Hva bør koden gjøre?
- **Eksperiment:** Skriv en test som feiler → implementer til den passer → refaktorer.

Denne rytmen, kjent som **Red → Green → Refactor**, skaper en kontinuerlig læringssyklus.
Koden blir et svar på spørsmålene utvikleren stiller, ikke et statisk produkt.

### Eksperimentell tenkning i utvikling

Å bruke TDD er å erkjenne at:

- Vi **ikke vet** svaret på forhånd.
- Vi lærer gjennom små, kontrollerte spørsmål (eksperimenter).
- Design vokser frem gjennom interaksjon mellom test og kode.

I likhet med naturvitenskapen har TDD sine begrensninger.  
Filosofiske grenser (Kant), logiske grenser (Gödel), og praktiske grenser (Talebs _Black Swans_) minner oss om at ikke alt kan modelleres eller testes.  
Men innenfor et gitt domene, hjelper TDD oss å utforske det vi faktisk _kan_ vite.

### _Å skrive tester først_

Når du skriver tester først, tvinges du til å:

- Tydeliggjøre hva koden **skal gjøre** (intensjon før implementasjon)
- Skape en **kontrakt** mellom forventning og oppførsel
- Designe kode som er **modulær og testbar**

Kort sagt: å skrive tester først gjør designbeslutningene mer eksplisitte.

## Konkretisering

### Hva, hvor, når blir dette brukt?

TDD brukes der:

- Kompleksiteten er håndterbar (små, isolerte enheter av logikk).
- Man ønsker **høy endringshastighet** uten å ofre stabilitet.
- Designet fortsatt er i flyt – man ønsker å _oppdage_ strukturen, ikke følge en rigid plan.

Eksempel på første TDD-øvelse:

1. Opprett en klasse `Calculator`.
2. Skriv første test: `2 + 2 = 4` → den feiler (Red).
3. Implementer `Add()` til testen passer (Green).
4. Refaktorer koden for klarhet og enkelhet (Refactor).
5. Gjenta for neste test: `2 + (-3) = -1`.
6. Til slutt: utforsk edge cases — overflow, deling på null, osv.

Poenget er ikke at du skal bygge en komplett kalkulator, men at du skal **erfare rytmen** i TDD.

Gjennom rytmen Red → Green → Refactor lærer du:

- Å skrive små, målbare eksperimenter
- Å la testene drive frem designet
- Å observere hvordan feil gir ny innsikt

### Eksterne Lenker

- [Kent Beck – Test-Driven Development: By Example (Addison-Wesley)](https://www.oreilly.com/library/view/test-driven-development/0321146530/)
- [Martin Fowler – The Essence of TDD](https://martinfowler.com/bliki/TestDrivenDevelopment.html)
- [Google Testing Blog: Why We Write Tests First](https://testing.googleblog.com/)
- [James Shore – TDD Video Series](https://www.jamesshore.com/v2/projects/null/project-tdd)

## Videre Lesing

- Kent Beck, _Extreme Programming Explained_
- Robert C. Martin, _Clean Code_ (kapittel om testing)
- Michael Feathers, _Working Effectively with Legacy Code_
- Eric Evans, _Domain-Driven Design_ (for sammenhengen mellom modeller og testbare domener)

## Referanse Liste

- Beck, K. (2003). _Test Driven Development: By Example._ Addison-Wesley.
- Fowler, M. (2006). _Continuous Integration._ martinfowler.com.
- Meszaros, G. (2007). _xUnit Test Patterns: Refactoring Test Code._ Addison-Wesley.
