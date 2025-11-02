---
synlighet: intern
livsyklus: utkast
tittel: BE03 - IaC - Moduler og Gjenbrukbar Infrastruktur
slug: be03-iac-moduler
---

# Moduler og Gjenbrukbar Infrastruktur

En introduksjon til hvordan man strukturerer infrastrukturkode i gjenbrukbare moduler. Vi ser på hvordan Terraform-moduler brukes for å bygge komponentbasert og vedlikeholdbar IaC.

## Teori

### Hvorfor moduler?

Etter hvert som infrastrukturprosjekter vokser, blir det upraktisk å ha all konfigurasjon i én stor fil.  
Modularisering handler om **gjenbruk**, **abstraksjon** og **ansvarsdeling**.

Ved å pakke sammen relaterte ressurser i en modul kan vi:

- gjenbruke kode mellom prosjekter,
- redusere duplisering,
- standardisere oppsett,
- og gjøre infrastrukturen enklere å vedlikeholde.

### Hva er en Terraform-modul?

En Terraform-modul er en samling av `.tf`-filer i en mappe, med et veldefinert grensesnitt via `variabler` og `outputs`.  
Modulen kan representere alt fra én ressurs (f.eks. “S3 bucket”) til et komplekst system (f.eks. “webapplikasjon med load balancer, database og nettverk”).

**Struktur:**

```plaintext
modules/
app_server/
main.tf
variables.tf
outputs.tf
```

En modul kan brukes fra andre moduler eller fra rotkonfigurasjonen:

```hcl
module "app_server" {
  source = "./modules/app_server"
  server_name = "hetzner-app-1"
}
```

### Variabler og Output

Moduler definerer **input** gjennom `variable`-blokker og **output** gjennom `output`-blokker.
Dette gjør det mulig å styre modulens oppførsel uten å endre intern kode.

Eksempel:

```hcl
# variables.tf
variable "server_name" {
  description = "Navn på serveren"
  type        = string
}

# outputs.tf
output "ip_address" {
  description = "IP-adressen til serveren"
  value       = hcloud_server.main.ipv4_address
}
```

### Dokumentasjon og Sensitivitet

Alle moduler bør dokumenteres, både formål, inputvariabler og outputs.
Terraform støtter automatisk dokumentasjon via `terraform-docs` og flagget `sensitive = true` for verdier som ikke skal eksponeres (f.eks. passord, tokens, private nøkler).

### Komposisjon og Rekonsiliering

Etter at infrastrukturen er modularisert, kan man bygge **komponerte systemer**, moduler som kombinerer flere andre moduler.
Et naturlig neste steg er å legge til et **rekonsilieringsskript** som sørger for kontinuerlig samsvar mellom ønsket og faktisk tilstand (for eksempel med `systemd` på Debian).

Dette illustrerer overgangen fra manuell drift til **systemer som oppdaterer seg selv**.

## Konkretisering

### Hva, hvor, når blir dette brukt?

Modularisering er en modenhetsfase i IaC-prosjekter. Den brukes i alle større organisasjoner og DevOps-team for å standardisere infrastrukturen.

### Eksempler

Bruksområder:

- En modul for "webapp" som inkluderer server, sikkerhetsgruppe, domenenavn og TLS-sertifikat.
- En modul for "database" som oppretter PostgreSQL med backup og brukere.
- En felles "monitoring"-modul som kan plugges inn i alle miljøer.

I økten skal deltakerne:

- Trekke ut sin eksisterende "Hetzner Compose App Server" til en egen modul.
- Definere `variable` og `output`.
- Bruke modulen i sitt hovedprosjekt.
- (Valgfritt) legge til rekonsilieringsskript via `systemd` for å automatisere synkronisering mot et Git-repo.

Dette gir førstehånds erfaring med **strukturert, skalerbar IaC**, en forutsetning for profesjonell drift.

### Eksterne Lenker

- [Terraform Modules Overview](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Hetzner Cloud Provider – Modules Examples](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)
- [terraform-docs – Generating Documentation](https://terraform-docs.io/)
- [systemd Documentation](https://www.freedesktop.org/software/systemd/man/systemd.service.html)

## Videre Lesing

- **Terraform Best Practices** – OpenTofu/Terraform community guide for moduler.
- **“Production-Grade Terraform Modules”** (Gruntwork blog)
- **HashiCorp Learn: Module Composition**
- **Pulumi Components vs Terraform Modules** – sammenligning av modulariseringsstrategier.

## Referanse Liste

- Terraform-dokumentasjon: [https://developer.hashicorp.com/terraform](https://developer.hashicorp.com/terraform)
- Terraform-moduler på Registry: [https://registry.terraform.io/browse/modules](https://registry.terraform.io/browse/modules)
- OpenTofu-dokumentasjon: [https://opentofu.org/docs/](https://opentofu.org/docs/)
- systemd-dokumentasjon: [https://www.freedesktop.org/software/systemd/man](https://www.freedesktop.org/software/systemd/man)
