# BE03 - Backend Advanced

Dette er et repository for å holde orden i undervisnings-og læringsmateriale for BE03 - Backend Advanced.

## Etablert publiseringsprosess

1. Skriv innhold i markdown-filer i `canvas/`-mappen.
2. Kjør `just generate-canvas-manifest` for å generere en manifest-fil.
3. Kjør `just render-canvas-pages` for å generere HTML-filer.
4. Kjør publiseringskommandoen for å oppdatere eksternt innhold:
   - `just publish-canvas-pages` For å oppdatere Canvas-sider

## Skisse over systemet

![Uviklings System Skisse](/docs/assets/utvikling-av-fagmaterial.excalidraw.png)

## Commit Message Konvensjoner

Dette prosjektet følger strukturerte commit message konvensjoner. Se [docs/COMMIT_CONVENTIONS.md](docs/COMMIT_CONVENTIONS.md) for detaljer.

For å bruke git commit malen:

```bash
git config --local commit.template .gitmessage
```

## Referanse Liste

- [Canvas Developer Documentation](https://developerdocs.instructure.com/)
