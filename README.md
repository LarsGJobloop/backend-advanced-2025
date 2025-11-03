# BE03 - Backend Advanced

Dette er et repository for å holde orden i undervisnings-og læringsmateriale for BE03 - Backend Advanced. Repositoryet inneholder kursinnhold organisert i fire uker (TDD, SOA, IaC, IAM) samt infrastruktur for å publisere til Canvas LMS.

## Prosjektstruktur

```
backend-advanced/
├── uke-1-test-driven-development/        # Uke 1: TDD-basert Web API
├── uke-2-service-oriented-systems/       # Uke 2: Docker Compose-applikasjon
├── uke-3-infrastructure-as-code/         # Uke 3: Terraform og Cloud-init
├── uke-4-identity-and-access-managment/  # Uke 4: .NET CLI med OAuth
├── internal/canvas/                      # Canvas-sidemetadata og tidsplaner
├── internal/templates/                   # Maler for temaer og oppgaver
├── project/                              # Terraform-konfigurasjon for repo
├── docs/                                 # Dokumentasjon og skisser
└── out/canvas-pages/                     # Genererte HTML-sider
```

## Publiseringsprosess

### Lokal utvikling

Prosjektet bruker Nix for reproduserbare miljøer:

```bash
# Aktiver utviklingsmiljøet
nix develop

# Eller med direkte kommandoer
nix run . just --list
```

### Publisering til Canvas

1. Skriv innhold i markdown-filer under hver ukes `canvas/`-mappe.
2. Kjør `just generate-canvas-manifest` for å generere en manifest-fil.
3. Kjør `just render-canvas-pages` for å generere HTML-filer.
4. Kjør `just update-canvas-page-mapping` for å oppdatere title-to-id-mapping.

#### Sikkerhet og automatisk opplasting

Opplastingsfunksjonaliteten er implementert med flere sikkerhetslag:

- **Dry-run som standard**: `just upload-canvas-pages` kjører i dry-run modus og viser kun hva som ville blitt oppdatert. Ingen endringer gjøres med mindre du eksplisitt kaller `just upload-canvas-pages apply`.
- **Eierskapsverifisering**: Systemet verifiserer at hver side sist ble redigert av `CONTENT_RESPONSIBLE` før opplasting. Sider redigert av andre brukere blir automatisk hoppet over.
- **Interaktiv bekreftelse**: I apply-modus må du eksplisitt bekrefte hver oppdatering (yes/no) før den utføres.
- **Ingen sideopprettelse**: Systemet støtter kun oppdatering av eksisterende sider. Opprettelse av nye sider må gjøres manuelt i Canvas.

> [!NOTE]
>
> **Nåværende status**: Inntil videre er potensiell destruktive mutasjon fjernet. Anbefaling er å sikre at alle ressurser i Canvas kursnummer er versjonert og har mulighet for å bli gjennskapt. [Kommentert ut API kall i canvas.just#update-page](/canvas.just) for å unngå uhell.

5. For å teste opplasting (dry-run): `just upload-canvas-pages`
6. For å faktisk oppdatere (krever eksplisitt bekreftelse): `just upload-canvas-pages apply`

## Skisse over systemet

![Utviklingsystem Skisse](/docs/assets/utvikling-av-fagmaterial.excalidraw.png)

## Commit Message Konvensjoner

Dette prosjektet følger strukturerte commit message konvensjoner. Se [docs/COMMIT_CONVENTIONS.md](docs/COMMIT_CONVENTIONS.md) for detaljer.

For å bruke git commit-malen:

```bash
git config --local commit.template .gitmessage
```

## Verktøy og avhengigheter

Prosjektet bruker:

- **Nix + Flakes**: Reproduserbare utviklingsmiljøer
- **Just**: Kommandolinjenverktøy for automatisering
- **Pandoc**: Markdown til HTML-konvertering
- **OpenTofu**: Infrastruktur som kode for GitHub-repo
- **SOPS**: Sikker lagring av hemmeligheter

## Help Wanted

Publisering til Canvas bruker i dag Canvas REST API via `curl`-kommandoer. Vi søker bidragsytere til følgende verktøy som kan forbedre opplevelsen:

### Canvas CLI Client

En CLI-klient for Canvas LMS som kan:

- Integrere med moderne autentiseringsmetoder (OAuth2, Device Flow)
- Tilby type-safe operasjoner for Canvas-ressurser
- Være enkel å bruke i CI/CD-pipeliner
- Egne seg for automatisering og GitOps

### Canvas Terraform Provider

En [Terraform Provider](https://developer.hashicorp.com/terraform/registry/providers/publishing) for Canvas LMS som kan:

- Deklarativt definere kursinnhold, sider, oppgaver og moduler
- Støtte state management og drift av Canvas-resurser
- Integrere med eksisterende IaC-verktøykjede
- Sørge for versjonering og reproduserbarhet

Disse verktøyene ville gjøre det enklere å ha Canvas-ressurser som infrastruktur som kode.

## Referanser

- [Canvas Developer Documentation](https://developerdocs.instructure.com/)
- [Just Command Runner](https://github.com/casey/just)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
