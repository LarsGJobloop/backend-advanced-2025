---
synlighet: intern
livsyklus: utkast
tittel: BE03 - SOA - Vanlige Tjenestesammensetninger
---

# Vanlige Tjenestesammensetninger

Når det kommer til tjenestesammensetning i digitale systemer så har det dukket oppe ett sett med mer eller mindre standardiserte løsninger som de fleste vil benytte seg av. Disse vil ligne på det dere allerede har vært innom i MVC mønstret og ellers i ASP .NET APIene. Viss du har følger med og noterer deg, så vil du se at flere av de samme tanken repeteres på flere nivåer, de er det vi kaller fraktale.

Her kommer vi til å dra inn to sett av disse, og peke på ett par andre.

- **Ruting/Ingress**: En spesialisert tjeneste for å videresende inkommende meldinger til konkrete tjenester. Kan utvides til å kreve autentisering og terminere TLS kjeder og benyttes for bevisføring av domene eierskap (DNS Certificates). Eks: Nginx, Traefik, Kong
- **Databaser**: Dedikerte tjenester for lagring og organisering av informasjon. Eks: PostgreSQL, MongoDB, Reddis

- **Identity and Access Management (IAM)**: Produksjons systemer i dag benytter seg av identitets baserte autentisering løsninger, disse blir fasilitert av IAM tjenester. Eks: Keycloak, Dex, Ory
- **Object Storage**: Filsystemet er mindre brukt i dag til å ivareta kritisk informasjon. Object Storage er dedikerte løsninger for lagring. Eks: S3, Blob Storage
- **Event Streams**: Hendelses Drevne Systemer krever måter å definere kanaler på og publisere og lytte etter meldinger som kommer inn. Eks: Kafka, NATS, RabbitMQ
- **ML (AI) Inference**: Ny ML/AI tjeneste type for å kjørre spørringer mot (inference) ML modeller. Eks. Ollama

## Teori

### Ingress

Ingress tjenester er et lite program som er det første eksterne brukere treffer på når de sender meldinger til ditt system. I sin enkleste konfigurasjon så leser disse kun av inkommende meldinger og videresender disse til konkrete tjenester. I denne konfigurasjonen så kaller en det gjerne en Reverse-Proxy, og fungerer mer som en by port som all meldinger må igjennom.

Dette legger til ett ekstra hopp inn i kommunikasjons kanalen, i Docker Compose så blir dette fra en prossess til en annen, så i tilfeller hvor en har applikasjoner som er veldig _latency_ sensitive (Spill og streaming), så vil den typen kommunikasjon potensielt taes via dedikerte kanaler.

Det første en benytter Traefik til er for å ha en stabil fasade, hvor vi bakenfor kan drive å updatere tjeneste implementasjonene våre individuelt, uten at det påvirker resten av tjenestene vi har.

Det er langt mer disse Ingress/Gatewayen kan ta ansvar for, så here er en liten liste av muligheter:

- Retry
- Authentication
- Trafic Splitting
- A/B Testing
- TLS Termination
- DNS Certificate handling

### Databaser

Databaser er et annet sett med tjenester som har vært standardisert og som vi benytter oss av til langtids lagring av strukturert data. Disse er som regel splitet i to biter, en database tjeneste og et database administrasjons grensesnitt.

Databaser er potensielt veldig tunge og kompliserte å operere, spesielt med tanke på varig lagring av data. Her må en tenke på backup planer, oppetid, hvor mye data som skal lagres, forholdet mellom spørringer/lesinger og muteringer/skrivinger til database samt hvordan disse er grupert, per bruker, på tvers av all, etc.

Så når det kommer til outsourcing av tjenester så er det operative ansvaret for databaser sannsynligvis det første du ønsker å si ifra deg.

### Mellom tjenestelig kommunikasjon

Docker Compose benytter seg av et internt nettverk som kan brukes når en trenger å snakke i mellom de forskjellige tjenestene. Med dette nettverket så hører det til en enkel DNS tjeneste for som kan benyttes, som bruker tjeneste navnet, som definert i Docker Compose manifestet, som domene en kan gjøre spørringer i mot internt. Det er mulig å isolere tjenester ved å sett opp flere nettverk, men siden dette er enkelt noder vi kjører det på så blir dette i hovedsak brukt for simulering av systemer, og ikke som nytte verktøy til faktiske produksjons løsninger.

### Deklerative Lagrin

Containere er stateless av design. Det vil si at de når du starter en container så bruker den kun det some var definert i container bildet, og viss du prøver å skrive noe til disken mens den kjøres så vil det forsvinne når containeren stopper. Dette er gjort for å letter gjøre resonering rundt og horisontal skalering (kjøre flere containere av samme slag).

Så viss du trenger å lagre noe utenom livssyklusen til containeren så har du to alternativer:

1. Du kan sende dataen til en dedikert tjeneste som håndterer dette (Database, Object Storage, Logging Tjeneste). Dette fungerer helt fint og er ofte det vi gjør, selv om det vil gjøre applikasjonen vår tregere. Motivasjonen her er ofte basert på økonomi og tjeneste garantier.
2. Du kan, eksplisitt, sette inn (mounte) en del av filsystemet fra verten, som applikasjonen i containeren kan skrive til. Vi kommer til å bruke dette for databaser og andrer tjenester som trenger harddisk lagring. Viss du bruker en skyleverandør så vil dette enten vere harddisken til noden eller Block Storage (NAS variant).

## Konkretisering

### Hva, hvor, når blir dette brukt?

Moderne produksjons systemer i dag er samensatt av flere tjenester. Det som gjerne vil være aktuelt for din praksis/jobb er at du kommer ikke til å sitte med Docker Compose og konfigurere alt sammen selv. Ofte benytter en dedikerte tjenester med egne Web UIer eller APIer for å konfigurere disse. Så Docker Compose er mer en løsning for å kunne eksperimentere lokalt og få innsikt i hvordan disse fungerer. Men du vil finne mye konseptuell overlapp mellom det som du kan kjøre lokalt av Open Source løsninger og de tjenestene som tilbyes, selv om du betaler deg ut av en del av ansvaret med driftene og konfiugreringen av systemene.

Når det er sagt, så kan enklere løsninger, ofte interne, fremdeles benytte seg av Docker Compose til oppsett. Og det er ett nyttig verktøy som du kan bruke når du setter opp dine egne servere.

### Eksempler

**Minimal Docker Compose DNS Example**:
`Compose.yaml`

```yaml
services:
  server-a: # This line set's the service "domain name"
    build:
      dockerfile: Dockerfile
      context: server-a
  server-b: # This line set's the service "domain name"
    build:
      dockerfile: Dockerfile
      context: server-b
```

`server-a`

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
var queries = 0;
app.MapGet("/", () => queries++);
app.Run();
```

`server-b`

```csharp
using System.Net.Http;

var client = new HttpClient();

while (true)
{
    var response = await client.GetAsync("http://server-a/");
    Console.WriteLine($"{DateTime.Now:O} - {(int)response.StatusCode} {response.ReasonPhrase}");
    await Task.Delay(TimeSpan.FromSeconds(10));
}
```

**Docker Compose Volumes alternativer**:

```yaml
services:
  app:
    image: nginx:alpine
    ports:
      - "8080:80"

    volumes:
      # Host directory mount (bind mount)
      - ./html:/usr/share/nginx/html

      # Host file mount (bind mount for a single file, read-only)
      - ./nginx.conf:/etc/nginx/nginx.conf:ro

      # Anonymous volume (Docker-managed, ephemeral)
      - /var/cache/nginx

      # Named volume (declared below; persists beyond container lifecycle)
      - app_data:/data

volumes:
  # Named volume definition — reusable and persistent
  app_data:
```

### Eksterne Lenker

- [Traefik Documentation](https://doc.traefik.io/traefik/contributing/documentation/)
  - [Traefik Container](https://hub.docker.com/_/traefik)
- [PosgreSQL Documentation](https://www.postgresql.org/docs/)
  - [PosgreSQL Container](https://hub.docker.com/r/bitnami/postgresql)

## Videre Lesing

- [Docker Compose Networking](https://docs.docker.com/compose/how-tos/networking/)
- [Docker Compose Volumes](https://docs.docker.com/reference/compose-file/volumes/)

- Andre vanlige tjeneste typer med eksempler:
  - [Identity and Access Management - Authentik](https://goauthentik.io/)
  - [Object Storage - MinIO](https://www.min.io/)
  - [Event Streaming - Kafka](https://kafka.apache.org/)
  - [ML (AI) Inference - Ollama](https://ollama.com/)
    > Merk at ML inference kan kreve enorme compute ressurser for å levere kjappe svar. Så ikke være overrasket viss dette går særdeles tregt på laptopen din.

## Referanse Liste

- [Docker Compose Reference](https://docs.docker.com/reference/compose-file/)
