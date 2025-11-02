---
synlighet: intern
livsyklus: utkast
tittel: BE03 - TDD - Grensesnittskontrakter
slug: be03-tdd-grensesnittskontrakter
---

# TDD og Grensesnittskontrakter

Tredje økt utforsker hvordan TDD hjelper oss å bygge **stabile grensesnitt**, og hvordan vi kan bruke tester til å uttrykke og håndheve kontrakter mellom deler av et system.

## Teori

### Programmer i kontekst

Ingen programvare eksisterer i et vakuum.  
Hver modul, tjeneste eller funksjon samhandler med andre, direkte eller indirekte, gjennom **grensesnitt**.  
Det er disse grensesnittene som gir **stabilitet** i systemet, ikke detaljene i implementasjonen.

Når man endrer interne detaljer, men bevarer grensesnittet og dets oppførsel, kan resten av systemet fortsette å fungere uforstyrret.  
TDD hjelper oss å oppnå dette ved å uttrykke forventninger som **kontrakter** i form av tester.

### Testene som kontrakter

En test kan sees som en kontrakt mellom to parter:

- _Hvis du gir meg dette inputet, lover jeg å gi deg dette resultatet._
- Brudd på kontrakten indikerer at noe vesentlig har endret seg i oppførselen.

Ved å skrive tester for grensesnittet – ikke bare for interne detaljer – oppnår vi:

- Robusthet mot endringer i implementasjon.
- Klare forventninger til hvordan komponenter skal samhandle.
- Dokumentasjon som faktisk verifiseres maskinelt.

Eksempel:

```csharp
class ApiTests
{
  private readonly WebApplicationFactory<Program> _factory;
  private readonly HttpClient _client;

  public ApiTests()
  {
    _factory = new WebApplicationFactory<Program>();
    _client = _factory.CreateClient();
  }

  [Test]
  public async Task ApiReturns_NotFound_WhenUserIsUnknown()
  {
    // Arrange & Act
    var response = await _client.GetAsync("/users/unknown");
    // Assert
    Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
  }
}
```

Denne testen sier ingenting om hvordan API-et er bygget, bare at **kontrakten** _ukjent bruker → 404_ skal holdes.

### Arkitektur gjennom TDD

Når vi bruker TDD på grensesnittnivå, får vi naturlig frem spørsmål som:

- Hvordan håndterer vi feil og eksterne avhengigheter?
- Hva skal skje når en tjeneste ikke svarer?
- Hvor går grensen mellom _vårt ansvar_ og _andres ansvar_?

Ved å la testene drive frem svarene på disse spørsmålene, utvikler vi **arkitektur gjennom erfaring**, ikke antagelser.
Testene hjelper oss å utforske og formalisere grensene i systemet.

## Konkretisering

### Hva, hvor, når blir dette brukt?

Dette brukes særlig i:

- **Distribuerte systemer** hvor flere tjenester samarbeider over nettverk.
- **API-design** for å sikre konsistente svar og feilmeldinger.
- **Integrasjonstesting** der kontrakter mellom systemer må valideres kontinuerlig.

### Eksempler

Et eksempel på øving:

1. Definer et REST-API med operasjonene _GET /users_ og _POST /users_.
2. Skriv tester for de forventede kontraktene:

   - _GET /users_ skal returnere 200 OK og en liste.
   - _POST /users_ skal validere input og returnere 400 ved ugyldige data.

3. Utforsk edge cases:

   - Hva skjer når serveren restartes?
   - Hva skjer når en ekstern API ikke svarer?
   - Hva skal skje når du mottar ugyldige data fra en tredjepart?

Testene fungerer her som **kontrakter** som må holdes, uavhengig av hvordan tjenesten implementeres internt.

### Eksterne Lenker

- [Martin Fowler – IntegrationContractTests](https://martinfowler.com/bliki/IntegrationContractTest.html)
- [ThoughtWorks – Consumer-Driven Contracts Explained](https://www.thoughtworks.com/insights/blog/consumer-driven-contracts)
- [Pact – Open Source Contract Testing Tool](https://pact.io)
- [Roy Fielding – Architectural Styles and the Design of Network-based Software Architectures (REST)](https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)

## Videre Lesing

- Freeman & Pryce – _Growing Object-Oriented Software, Guided by Tests_
- Newman, S. – _Building Microservices_
- Evans, E. – _Domain-Driven Design_
- Meszaros, G. – _xUnit Test Patterns_

## Referanse Liste

- Fowler, M. (2011). _Integration Contract Tests._ martinfowler.com.
- Fielding, R. (2000). _Architectural Styles and the Design of Network-based Software Architectures._ PhD Thesis, UC Irvine.
- Freeman, S. & Pryce, N. (2009). _Growing Object-Oriented Software, Guided by Tests._ Addison-Wesley.
