---
synlighet: intern
livsyklus: utkast
tittel: BE03 - TDD - Introduksjon til Test Dreven Utvikling
---

# Introduksjon til Test Dreven Utvikling (TDD)

Test Dreven Utvikling (TDD) kommer fra problemet at når vi starter å utvikle en løsning så vet vi ikke egentlig hva den trenger å gjøre.

Så når vi driver med utvikling så er det egentlig en kartlegging av hva løsningen vår trenger å gjøre eller ikke skal gjøre, det som skal være sant eller usant.

TDD er praksis hvor vi skriver/kodefiserer disse kravene, før vi så endrer koden/løsningen vår for å tilfredstille disse.

## Teori

TDD deler aner med Vitensakplig Metode og du vil se mye overlapp med hvordan vi emperiske går fram for å kartlegge hvordan verden fungerer.

Hele konseptet følger en ganske stram rytme:

1. Formuler noe som løsningen eller en del av løsningen skal tilfredstille.
   1. Verifiser at spørsmålet ditt er av god nok kvalitet
2. Endre programmet så det tilfredstiller spørsmålet du stilte
3. Rydd opp i koden så det er letter å jobbe med den videre, mens testene fremdeles passerer
4. Start med neste spørsmål.

Dette er det som blir betegnet som "Red" -> "Green" -> "Refactor" syklusen.

For C# og .NET så kommer vi til å benytte oss av et rammeverk for å skrive disse testen kalt [xUnit](https://xunit.net/).

## Konkretisering

### Hva, hvor, når blir dette brukt?

TDD har blitt mer og mer vidspredd, tidligere så var det i hovedsak krevd for kritiske systemer, mens i dag så blir dette brukt selv for små

### Eksempler

#### Arrange -> Act -> Assert

Standard struktur for å skrive en enkelt test.

```csharp
// Arrange
var calculator = new Calculator();

// Act
var result = calculator.Add(2, 2)

// Assert
Assert.Equal(4, result);
```

### Eksterne Lenker

- [TODO! Lenk til GitHub Repository]()
- [xUnit Dokumentasjon](https://xunit.net/)

## Videre Lesing

- [Martin Fowler's Blog](https://martinfowler.com/bliki/TestDrivenDevelopment.html)

> [!NOTE]
> Mye av logikk baserer seg i filosofien, så for dypere forståelse av hvordan stille gode spørsmål og hvilken spørsmål som i det hele tatt gir mening krever et dykk ned i litt mer abstrakte emner

- [Immanuel Kant - Critique of Pure Reason](https://en.wikipedia.org/wiki/Critique_of_Pure_Reason)
- [Kurt Gödel's Incompleteness Theorem](https://en.wikipedia.org/wiki/G%C3%B6del%27s_incompleteness_theorems)
- [Nassim Nicholas Taleb - The Black Swan](https://en.wikipedia.org/wiki/The_Black_Swan:_The_Impact_of_the_Highly_Improbable)

## Referanse Liste

- [Wikipedia Artikkel](https://en.wikipedia.org/wiki/Test-driven_development)
