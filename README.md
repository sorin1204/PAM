# GemStore — Flutter, REST API și Clean Architecture

Aplicația păstrează interfața magazinului GemStore și încarcă feed-ul și detaliile din serviciul REST:

- `GET https://test-api-jlbn.onrender.com/lab2026/v1/feed`
- `GET https://test-api-jlbn.onrender.com/lab2026/v1/feed/details`

Aplicația GemStore folosește v1, schema de magazin de modă care corespunde designului păstrat. Endpoint-urile v2, v3 și v4 returnează feed-uri pentru alte tipuri de aplicații și nu au aceeași structură de date.

## Organizare

- `lib/features/feed/domain`: contractul repository-ului și use case-urile `GetFeed` / `GetFeedDetails`.
- `lib/features/feed/data`: sursa HTTP și implementarea repository-ului.
- `lib/core/network`: client HTTP, decodarea JSON și tratarea răspunsurilor/erorilor.
- `lib/models`: serializarea și deserializarea modelelor pentru feed și produse.
- `lib/cubit`, `lib/screens`, `lib/widgets`: Presentation — starea și interfața reutilizabilă.

## Fluxul datelor

UI → `GemStoreCubit.loadData()` → `JsonService` → use case → repository → remote data source → `ApiClient` → REST API. Răspunsul HTTP este decodat din JSON în `HomePageData`/`Product`, apoi Cubit emite starea de succes către UI. Erorile de rețea, status HTTP și JSON invalid sunt transformate în mesaje afișate de ecranul reutilizabil de eroare, cu opțiune de reîncercare.

Imaginile locale existente sunt păstrate; pentru URL-uri HTTP/HTTPS interfața folosește încărcare de rețea.

## Rulare

```sh
flutter pub get
flutter run
```
