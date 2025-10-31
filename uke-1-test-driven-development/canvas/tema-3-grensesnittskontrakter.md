---
synlighet: intern
livsyklus: utkast
tittel: BE03 - TDD - Grensesnittskontrakter
slug: be03-tdd-grensesnittskontrakter
---

# Grensesnittskontrakter

Når det kommer til utvikling av løsninger så er det vi lager i dag altfor komplekst til å kunne håndteres av enkelt individer, men koordinasjon er kostbart og ofte så er det vanskelig å ha flere personer som arbeider med det samme sammtidig (mange kokker, mye søl).

Med bakgrunn i det så prøver vi å snevre inn problemer til noe som kan utvikles av små team, og så kommuniserer disse bitene av løsningen igjennom veldefinerte grensesnitt og protokoller.

## Teori

Siden programmene våre kommuniserere i gjennom veldefinerte grensesnitt og protokoller så er dette en grense vi legger ned mye energi i for å verifisere.

For Web APIer så vil da første og viktigste sett med oppførsel vi ønsker å kartlegge være dette settet med endepunkt.

Her er en grov liste over det som du kan komme bort i:

- REST endepunkt og ressurser
- gRPC protokollen (server-til-server kommunikasjon)
- IPC protokoller (prosess-til-prosses)

Disse vil være utgangspunktet for der du starter med å skrive spørsmålene dine, og drive eventuelt andre spørsmål som du måtte trenge som del for å tilfredstille disse.

Disse grensesnittene som du definere here, mellom det som du kontrollerer, og omverdene, er og det som vi versjonerer og publiserer til andre.

Noe av det som kan være vanskelig er at selv om du gjerne har full kontroll over det grensesnittet du eksponerer, så har du ikke full kontrol over de komponentene du er avhengig av (eksterne Databaser, Harddisk, OS, etc). Det er forskjellige måter å tilnærme seg de avhengighetene på, og hvilken du velger vil være avhengig av prosjektet du arbeider med og tilhørende økonomi.

- Sette opp en dedikert test instans som du bruker (koster penger)
- Lage/Hente inn en "Mock" instanse som du bruker (kan være forskjeller fra "ekte vare")

Dette blir fort komplisert, og det er ingen løsning som dekker alt, så her må du reflektere rundt kostnad/tidsbruk/nytteverdi for å kunne lande på noe fornuftig.

## Konkretisering

### Hva, hvor, når blir dette brukt?

Grensesetting er noe som vil være en del av alle løsninger du lager. Det nærmeste unntaket du kommer er viss du hadde laget alt fra bunnen av (CPU, RAM, etc) til sluttprodukt, som ikke er tilfellet utenfor laboratorium.

### Eksempel Kode

Eksempel for å teste en REST Server

```csharp
public class BlogApiTests : IClassFixture<WebApplicationFactory<Program>>
{
  private readonly Mock<IBlogPostRepository> _repoMock;
  private readonly HttpClient _client;

  public BlogApiTests(WebApplicationFactory<Program> factory)
  {
    _client = factory.CreateClient();
  }

  [Fact]
  public async Task GetPosts_ShouldReturnOk()
  {
    // Arrange & Act
    var response = _client.GetAsync("/posts");

    // Assert
    response.EnsureSuccessStatusCode();
  }
}
```

### Eksterne Lenker

- [TODO! Lenk til GitHub Repository]()

## Videre Lesing

- [Microsoft Docs - RESTful API Design](https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design)

## Referanse Liste

- [Microsoft Docs - API Testing](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis/test-min-api)
