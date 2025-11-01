---
synlighet: intern
livsyklus: utkast
tittel: BE03 - TDD - Eksperimenter for kartlegging av behov
slug: be03-tdd-eksperimenter
---

# Eksperimenter for kartlegging av behov

Andre økt handler om å bruke TDD som **utforskende metode** for å finne løsninger, ikke for å validere ferdige ideer.  
Deltakerne lærer å la testene avdekke hvordan systemet _bør_ oppføre seg, heller enn å følge en på forhånd gitt spesifikasjon.

## Teori

### TDD som utforskende design

Tradisjonelt bygges systemer _top–down_: man definerer krav og deretter implementerer.  
Med TDD snus dette på hodet — man begynner i det små, observerer hvordan koden responderer, og lar designet vokse **bottom–up**.

Nøkkelidéen er å bruke testene som **mikro-eksperimenter**:

- Hver test uttrykker en hypotese: _hvis jeg sender inn dette, forventer jeg dette utfallet._
- Implementasjonen blir forsøket som tester hypotesen.
- Refaktoreringen destillerer læringen tilbake i strukturen.

TDD blir da ikke et mål om testdekning, men et **designverktøy** for å forme kode gjennom observasjon.

### Fra kravspesifikasjon til eksperiment

I praksis starter økta med en enkel kravbeskrivelse, for eksempel:

> _Lag et system som håndterer brukere med innlogging og poengscore._

Start med _spørsmålene_: Hva bør systemet gjøre først? Hvordan vet vi at det fungerer? Og ikke prøv å dekke over alt, men start med det første viktigste spørsmålet og bygg videre fra der.

Gjennom testene blir kravene omsatt til **observerbar oppførsel**:

- Første test definerer grensesnittet (_hva vil vi kunne spørre koden om?_ ).
- Implementasjonen formes deretter av behovet til testen.

Dette er en eksperimentell og iterativ prosess, ikke en lineær implementasjon.

## Konkretisering

### Hva, hvor, når blir dette brukt?

Denne fasen er typisk brukt når:

- Løsningen ikke er kjent, men må **utforskes**.
- Man ønsker å bygge forståelse for et domene gjennom kode.
- Arkitekturen skal **emerge**, ikke defineres på forhånd.

Eksempel på arbeidsflyt:

1. Deltakerne får et vagt problem: _Lag et system som kan registrere brukere og gi poeng._
2. Første test kan være:

   ```csharp
   [Test]
   public void UserCanGainPoints()
   {
       var user = new User();
       user.GainPoints(10);
       Assert.Equal(10, user.Points);
   }
   ```

3. Koden implementeres minimalt for å få grønt lys.
4. Neste test introduserer et nytt spørsmål – f.eks. _Hva skjer om poengsummen blir negativ?_
5. Gjennom små steg formes både domenet og modellene.

Poenget er ikke å _løse oppgaven_, men å **observere hvordan testene former strukturen**.

### Eksterne lenker

- [Growing Object-Oriented Software, Guided by Tests – Freeman & Pryce](https://www.oreilly.com/library/view/growing-object-oriented-software/9780321612136/)
- [Martin Fowler – Mocks Aren’t Stubs](https://martinfowler.com/articles/mocksArentStubs.html)
- [Kent Beck – Programmering som Hypoteseprøving (foredrag, Agile2008)](https://www.youtube.com/watch?v=JjXcVzBRF_M)
- [Uncle Bob – Transformation Priority Premise](https://blog.cleancoder.com/uncle-bob/2013/05/27/TheTransformationPriorityPremise.html)

## Videre lesing

- Freeman & Pryce – _Growing Object-Oriented Software, Guided by Tests_
- Beck & Andres – _Extreme Programming Explained: Embrace Change_
- Meszaros – _xUnit Test Patterns: Refactoring Test Code_
- Feathers – _Working Effectively with Legacy Code_ (for TDD i praksis mot eksisterende kode)

## Referanse liste

- Beck, K. (2003). _Test-Driven Development: By Example._ Addison-Wesley.
- Freeman, S. & Pryce, N. (2009). _Growing Object-Oriented Software, Guided by Tests._ Addison-Wesley.
- Fowler, M. (2014). _Mocks Aren’t Stubs._ martinfowler.com.
