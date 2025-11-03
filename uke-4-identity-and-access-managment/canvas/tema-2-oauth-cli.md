---
synlighet: intern
livsyklus: utkast
tittel: "C# Advanced - 4-2: OAuth 2.0 og GitHub CLI-autentisering"
slug: be03-4-2-iam-oauth-github
---

# OAuth 2.0 og GitHub CLI-autentisering

Denne økten utforsker hvordan applikasjoner kan **representere deg** overfor andre systemer, uten å gi bort passordet ditt.  
OAuth 2.0 gir en sikker, standardisert måte å gi og begrense tilgang mellom tjenester.

## Teori

### Grunnideen bak OAuth 2.0

OAuth 2.0 er et **delegasjonsrammeverk** for tilgang.  
Det lar én part (brukeren) gi en annen part (applikasjonen) midlertidig tilgang til en ressurs (f.eks. GitHub-data), uten å utlevere adgangsnøkkelen din.

Systemet består av fire roller:

| Rolle                    | Forklaring                                      | Eksempel                 |
| ------------------------ | ----------------------------------------------- | ------------------------ |
| **Resource Owner**       | Den som eier dataene                            | GitHub-brukeren          |
| **Client**               | Applikasjonen som ber om tilgang                | CLI-verktøy eller webapp |
| **Authorization Server** | Den som autentiserer brukeren og utsteder token | GitHub OAuth-server      |
| **Resource Server**      | API-et som beskytter dataene                    | api.github.com           |

### Flyten - Authorization Code Flow

1. **Brukeren** blir sendt til GitHub for å godkjenne appen.
2. GitHub viser et **samtykkevindu** (_Consent Screen_) med _Scopes_ (tilganger).
3. Etter godkjenning sendes brukeren tilbake til appen med en **authorization code**.
4. Appen bruker denne koden (sammen med sin **Client ID** og **Client Secret**) til å få et **Access Token**.
5. Tokenet brukes i HTTP-kall til API-et, som nå kan stole på at brukeren har gitt samtykke.

### Consent og Scopes

- **Scopes** definerer _hva_ applikasjonen får lov til å gjøre (`read:user`, `repo`, `gist`, osv.)
- **Consent** sikrer at brukeren eksplisitt samtykker til hver type tilgang.
- Dette gir et lag av både **sikkerhet** og **gjennomsiktighet**.

### OAuth ≠ Identitet

OAuth 2.0 sier _ingenting_ om hvem brukeren er, bare at noen har gitt tilgang.  
For å legge til identitetsinformasjon brukes **OpenID Connect**, som bygger videre på OAuth og introduserer et _Id Token_ med brukerdata.

## Konkretisering

### Hva, hvor, når blir dette brukt?

OAuth brukes overalt hvor tjenester trenger å representere brukere:

- Når du **logger inn med GitHub** i et tredjepartsverktøy.
- Når et **CLI-verktøy henter repositories** uten å lagre adgangsnøkkelen din.
- Når **mobilapper kobler seg til API-er** på dine vegne.

### Eksempler

Bruksområder:

- GitHub CLI (`gh auth login`)
- VS Code-integrasjoner
- Google Workspace API, Microsoft Graph, Discord OAuth

**Demo - GitHub CLI i .NET:**

1. **Registrer en OAuth App** på GitHub:

   - Fyll inn `Redirect URI` (f.eks. `http://localhost:5000/callback`)
   - Noter _Client ID_ og _Client Secret_

2. **Bygg flyten i CLI:**

   ```csharp
   var authUrl = $"https://github.com/login/oauth/authorize?client_id={clientId}&scope=repo%20read:user";
   Process.Start(new ProcessStartInfo(authUrl) { UseShellExecute = true });

   // Motta callback med Authorization Code
   var tokenResponse = await httpClient.PostAsync("https://github.com/login/oauth/access_token", content);
   ```

3. **Kall GitHub API med tokenet:**

   ```csharp
   httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
   var repos = await httpClient.GetAsync("https://api.github.com/user/repos");
   ```

4. **Diskuter**: Hvem stoler på hvem i denne flyten?
   → GitHub stoler på deg (via login), du stoler på GitHub (til å beskytte dataen din), og CLI-en får midlertidig tillit via tokenet.

### Eksterne Lenker

- [GitHub OAuth Apps Documentation](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps)
- [.NET HttpClient og OAuth flows (Microsoft Docs)](https://learn.microsoft.com/en/dotnet/api/system.net.http.httpclient)
- [OAuth 2.0 Playground (Google)](https://developers.google.com/oauthplayground)

## Videre Lesing

- [RFC 6749 – The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749)
- [OpenID Connect Core Specification](https://openid.net/specs/openid-connect-core-1_0.html)
- [“OAuth 2 Simplified” – Aaron Parecki](https://aaronparecki.com/oauth-2-simplified/)

## Referanse Liste

- GitHub Docs – [Creating an OAuth App](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app)
- Microsoft Docs – [Secure Web APIs with OAuth 2.0](https://learn.microsoft.com/en/azure/active-directory/develop/v2-oauth2-auth-code-flow)
- IETF – [RFC 8252 – OAuth 2.0 for Native Apps](https://datatracker.ietf.org/doc/html/rfc8252)
