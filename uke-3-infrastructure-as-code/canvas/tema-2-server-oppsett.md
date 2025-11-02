---
synlighet: intern
livsyklus: utkast
tittel: BE03 - IaC - Cloud Init og Automatisert Bootstrap
slug: be03-iac-cloud-init
---

# Cloud Init og Automatisert Bootstrap

Et dypdykk i hvordan servere kan konfigureres automatisk ved oppstart, uten manuelle SSH-kommandoer. Vi introduserer Cloud Init som standardverktøyet for deklarativ “bootstrap” av servere.

## Teori

### Reproduserbarhet og Imperative Installasjoner

I forrige økt opprettet vi en server manuelt, logget inn via SSH og installerte programvare steg for steg. Det fungerer — men det **er ikke reproduserbart**.  
Hver gang man gjør endringer manuelt, introduseres risiko for variasjon og feil.

IaC handler om å **beskrive ønsket tilstand**, ikke gjenta manuelle handlinger.  
For at en server skal kunne konfigureres uten menneskelig innblanding, må selve oppstarten være deklarativ. Det er her **Cloud Init** kommer inn.

### Hva er Cloud Init?

Cloud Init er en standard mekanisme brukt av de fleste moderne skyleverandører (Hetzner, AWS, Azure, GCP, m.fl.) for å konfigurere en ny virtuell maskin **ved første oppstart**.

Man leverer et YAML- eller shell-skript til serveren som beskriver:

- hvilke pakker som skal installeres,
- hvilke filer som skal opprettes,
- hvilke kommandoer som skal kjøres,
- og hvordan systemet skal konfigureres.

Dette skriptet kjører **automatisk** når serveren starter første gang.

Eksempel (forkortet):

```yaml
#cloud-config
packages:
  - git
runcmd:
  - git clone https://github.com/my-org/app.git /opt/app
```

### Deklarativ Bootstrap

Cloud Init gjør den første konfigurasjonen deklarativ — du beskriver ønsket tilstand, ikke prosedyren for å nå den.
Dette danner overgangen fra manuell til **helhetlig deklarativ IaC**, der Terraform definerer selve ressursen (VM-en), mens Cloud Init definerer hvordan den skal **sette seg selv opp**.

### Samspill med Terraform

Terraform og Cloud Init utfyller hverandre:

- Terraform: Oppretter infrastrukturen (server, nettverk, IP, osv.).
- Cloud Init: Konfigurerer innholdet på serveren ved oppstart.

I Terraform defineres Cloud Init vanligvis gjennom en “template” eller inline YAML-struktur som sendes som `user_data` til ressursen.
Hver gang du kjører `terraform apply`, sørger Terraform for at riktig Cloud Init-konfigurasjon blir levert.

> Dette gjør det mulig å **slette og gjenopprette hele miljøet** med ett tastetrykk (`terraform destroy` → `terraform apply`).

## Konkretisering

### Hva, hvor, når blir dette brukt?

Cloud Init brukes i nesten alle moderne skymiljøer for å sikre at servere starter med riktig konfigurasjon, uten manuell SSH-tilgang.

Eksempler:

- **Automatisk installasjon** av Git, Docker, .NET og avhengigheter.
- **Bootstrap av applikasjoner:** Klone et Git-repo og starte Docker Compose ved oppstart.
- **Reproduserbare miljøer:** Ødelegg og gjenopprett hele testmiljøet med `terraform apply`.

Under økten:

- Deltakerne lager et Cloud Init-skript for å installere Git og Docker Compose.
- De legger inn kommandoer for å klone et repo og starte et Docker Compose-manifest automatisk.
- De tester gjenoppbygging ved å kjøre `terraform destroy` og `terraform apply`.

> Poenget er å vise **iterasjon og validering**: små steg, test ofte, og tenk “reproduserbart fra dag 1”.

### Eksterne Lenker

- [Cloud Init Documentation](https://cloudinit.readthedocs.io/en/latest/)
- [Hetzner Cloud Init Support](https://docs.hetzner.cloud/#cloud-init)
- [Terraform: Hetzner Cloud Provider](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)

## Videre Lesing

- **HashiCorp Learn: Using Cloud Init with Terraform**
- **The Twelve-Factor App – Config as Code** (spesielt faktor 10: Dev/prod parity)
- **GitHub - cloud-init examples**: Samling av eksempler fra praksisfeltet.

## Referanse Liste

- Cloud Init-spesifikasjonen: [https://cloudinit.readthedocs.io](https://cloudinit.readthedocs.io)
- Terraform dokumentasjon: [https://developer.hashicorp.com/terraform](https://developer.hashicorp.com/terraform)
- Hetzner API Cloud Config: [https://docs.hetzner.cloud](https://docs.hetzner.cloud)
