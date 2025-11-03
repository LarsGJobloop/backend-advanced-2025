---
synlighet: intern
livsyklus: utkast
tittel: BE03 - 0-1 - Ekstra temaer
slug: be03-0-1-ekstra-temaer
---

# Ekstra temaer

Denne modulen gir et solid fundament, men backend-utvikling er et stort fagfelt. Her er temaer for videre utforskning når du har mestret grunnleggende konsepter.

## Observabilitet og Monitoring

Viktig for produksjonssystemer, men krevende å lære på kort tid:

- **Presentasjon:** Grafana for dashboards og visualisering av metrikker
- **Aggregering:** Prometheus for metric collection og alerting
- **Traces:** Jäger eller Zipkin for distribuert tracing
- **Logger:** Loki for sentralisert logging
- **Standard format:** OpenTelemetry for vendor-nøytral instrumentering

## Kybernetiske systemer og GitOps

Data-drevne systemer med automatisk rekonsiliasjon:

- **Kubernetes:** Container orchestration på høyt nivå
- **FluxCD:** GitOps for kontinuerlig deployment
- **Flagger:** Progressive delivery og canary releases

## IAM-plattformer

Ferdigbygde løsninger for identitetshåndtering:

- **Dex:** Identitetsvegg for Kubernetes og andre systemer
- **Keycloak:** Fullverdig identity and access management platform
- **Ory:** Mikroservices-basert identitetshåndtering

## Produksjonsklare mønstre

Konsepter som er kritiske for produksjonsmiljøer:

- **Health checks og graceful shutdown:** Håndtering av container-livssyklus
- **Service discovery:** Hvordan tjenester finner hverandre i distribuerte miljøer
- **Config management:** Miljøvariabelhåndtering, hemmelighetshåndtering, multi-miljø
- **Deployment strategies:** Blue-green, rolling updates, canary releases

## Avansert teknisk dybde

Teknologier for komplekse systemer:

- **Service mesh:** Istio, Linkerd for avanserte mikrotjenester-mønstre
- **Event-driven arkitektur:** Kafka, RabbitMQ, pub/sub mønstre
- **GitOps workflows:** FluxCD, ArgoCD som IaC-utvidelse
- **Advanced IaC:** Ekstern tilstandsbehandling, team-samarbeid, kostnadseffektivisering
- **Policy-as-code:** OPA, Sentinel for granulær tilgangsstyring

## Arkitekturelle konsepter

Designmønstre for skalerbare systemer:

- **API gateway mønstre:** Kong, Ambassador beyond simple ingress
- **Circuit breakers og resilience:** Håndtering av feil i distribuerte systemer
- **CQRS og event sourcing:** Pattern for komplekse domener
- **Database migration strategier:** Versjonert skjema, zero-downtime migrasjoner
- **Multi-tenancy:** Ressursisolering på arkitektur-nivå

## Praksisområder for fortsatt læring

**Testing:** Integrasjonstester for mikrotjenester, kontraktstesting
**Performance:** Profiling, load testing, database indexing
**Security:** SAST, DAST, avhengighetsskanning
**Dokumentasjon:** API-dokumentasjon, arkitekturbeslutningsjournaler
**Håndtering av hendelser:** Debugging i distribuerte systemer, logganalyse
