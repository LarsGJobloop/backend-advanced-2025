---
synlighet: intern
livsyklus: utkast
tittel: BE03 - SOA - Vanlige Tjenestesammensetninger
slug: be03-soa-vanlige-sammensettninger
---

# Vanlige Tjenestesammensetninger

Når det kommer til tjenestesammensetning i digitale systemer, har det dukket opp et sett med mer eller mindre standardiserte løsninger som de fleste vil benytte seg av. Disse vil ligne på det dere allerede har vært innom i MVC-mønstret og ellers i ASP.NET APIene. Hvis du har fulgt med og notert deg, vil du se at flere av de samme tankene repeteres på flere nivåer – de er det vi kaller fraktale.

Her kommer vi til å dra inn to sett av disse, og peke på et par andre.

- **Ruting/Ingress**: En spesialisert tjeneste for å videresende inkommende meldinger til konkrete tjenester. Kan utvides til å kreve autentisering og terminere TLS-kjeder og benyttes for bevisføring av domeneeierskap (DNS-sertifikater). Eks: Nginx, Traefik, Kong
- **Databaser**: Dedikerte tjenester for lagring og organisering av informasjon. Eks: PostgreSQL, MongoDB, Redis

- **Identity and Access Management (IAM)**: Produksjonssystemer i dag benytter seg av identitetsbaserte autentiseringsløsninger, disse blir fasilitert av IAM-tjenester. Eks: Keycloak, Dex, Ory
- **Object Storage**: Filsystemet er mindre brukt i dag til å ivareta kritisk informasjon. Object Storage er dedikerte løsninger for lagring. Eks: S3, Blob Storage
- **Event Streams**: Hendelsesdrevne systemer krever måter å definere kanaler på og publisere og lytte etter meldinger som kommer inn. Eks: Kafka, NATS, RabbitMQ
- **ML (AI) Inference**: Ny ML/AI-tjenestetype for å kjøre spørringer mot (inference) ML-modeller. Eks: Ollama

## Teori

### Ingress

Ingress-tjenester er et lite program som er det første eksterne brukere treffer på når de sender meldinger til ditt system. I sin enkleste konfigurasjon leser disse kun av inkommende meldinger og videresender disse til konkrete tjenester. I denne konfigurasjonen kaller en det gjerne en reverse proxy, og fungerer mer som en byport som alle meldinger må igjennom.

Dette legger til et ekstra hopp inn i kommunikasjonskanalen. I Docker Compose blir dette fra en prosess til en annen, så i tilfeller hvor en har applikasjoner som er veldig _latency_-sensitive (spill og streaming), vil den typen kommunikasjon potensielt tas via dedikerte kanaler.

Det første en benytter Traefik til er for å ha en stabil fasade, hvor vi bakenfor kan drive å oppdatere tjenesteimplementasjonene våre individuelt, uten at det påvirker resten av tjenestene vi har.

Det er langt mer disse ingress/gateway-tjenestene kan ta ansvar for, så her er en liten liste av muligheter:

- Retry
- Authentication
- Trafic Splitting
- A/B Testing
- TLS Termination
- DNS Certificate handling

### Databaser

Databaser er et annet sett med tjenester som har vært standardisert og som vi benytter oss av til langtidslagring av strukturert data. Disse er som regel splitet i to biter: en databasetjeneste og et databaseadministrasjonsgrensesnitt.

Databaser er potensielt veldig tunge og kompliserte å operere, spesielt med tanke på varig lagring av data. Her må en tenke på backupplaner, oppetid, hvor mye data som skal lagres, forholdet mellom spørringer/lesninger og muteringer/skrivinger til database samt hvordan disse er gruppert, per bruker, på tvers av alle, etc.

Så når det kommer til outsourcing av tjenester så er det operative ansvaret for databaser sannsynligvis det første du ønsker å si ifra deg.

### Mellom tjenestelig kommunikasjon

Docker Compose benytter seg av et internt nettverk som kan brukes når en trenger å snakke mellom de forskjellige tjenestene. Med dette nettverket hører det til en enkel DNS-tjeneste som kan benyttes, som bruker tjenestenavnet, som definert i Docker Compose-manifestet, som domene en kan gjøre spørringer mot internt. Det er mulig å isolere tjenester ved å sette opp flere nettverk, men siden dette er en enkelt node vi kjører det på, blir dette i hovedsak brukt for simulering av systemer, og ikke som nyttverktøy til faktiske produksjonsløsninger.

### Deklarativ lagring

Containere er stateless av design. Det vil si at når du starter en container, bruker den kun det som var definert i containerbildet, og hvis du prøver å skrive noe til disken mens den kjører, vil det forsvinne når containeren stopper. Dette er gjort for å lettere gjøre resonnement rundt og horisontal skalering (kjøre flere containere av samme slag).

Så hvis du trenger å lagre noe utenom livssyklusen til containeren, har du to alternativer:

1. Du kan sende dataen til en dedikert tjeneste som håndterer dette (database, Object Storage, loggingtjeneste). Dette fungerer helt fint og er ofte det vi gjør, selv om det vil gjøre applikasjonen vår tregere. Motivasjonen her er ofte basert på økonomi og tjenestegarantier.
2. Du kan, eksplisitt, sette inn (mounte) en del av filsystemet fra verten, som applikasjonen i containeren kan skrive til. Vi kommer til å bruke dette for databaser og andre tjenester som trenger harddisklagring. Hvis du bruker en skyleverandør, vil dette enten være harddisken til noden eller Block Storage (NAS-variant).

## Konkretisering

### Hva, hvor, når blir dette brukt?

Moderne produksjonssystemer i dag er sammensatt av flere tjenester. Det som gjerne vil være aktuelt for din praksis/jobb er at du kommer ikke til å sitte med Docker Compose og konfigurere alt sammen selv. Ofte benytter en dedikerte tjenester med egne web-GUIer eller APIer for å konfigurere disse. Så Docker Compose er mer en løsning for å kunne eksperimentere lokalt og få innsikt i hvordan disse fungerer. Men du vil finne mye konseptuell overlapp mellom det som du kan kjøre lokalt av open source-løsninger og de tjenestene som tilbyes, selv om du betaler deg ut av en del av ansvaret med driften og konfigureringen av systemene.

Når det er sagt, kan enklere løsninger, ofte interne, fremdeles benytte seg av Docker Compose til oppsett. Og det er et nyttig verktøy som du kan bruke når du setter opp dine egne servere.

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
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
  - [PostgreSQL Container](https://hub.docker.com/r/bitnami/postgresql)

## Videre Lesing

- [Docker Compose Networking](https://docs.docker.com/compose/how-tos/networking/)
- [Docker Compose Volumes](https://docs.docker.com/reference/compose-file/volumes/)

- Andre vanlige tjeneste typer med eksempler:
  - [Identity and Access Management - Authentik](https://goauthentik.io/)
  - [Object Storage - MinIO](https://www.min.io/)
  - [Event Streaming - Kafka](https://kafka.apache.org/)
  - [ML (AI) Inference - Ollama](https://ollama.com/)
    > Merk at ML inference kan kreve enorme compute-ressurser for å levere kjappe svar. Så ikke vær overrasket hvis dette går særdeles tregt på laptopen din.

## Referanse Liste

- [Docker Compose Reference](https://docs.docker.com/reference/compose-file/)
