# Xuctu

Xuctu is a Vietnamese mathematics learning platform. This repository currently contains the repository foundation (Phase 0) and a Flutter UI prototype backed by dummy data (Phase 1).

## Repository layout

- `backend/` — reserved for the future .NET modular monolith; no backend exists yet.
- `admin/` — reserved for the future React administration app.
- `mobile/` — Flutter application for Android and iOS.
- `infrastructure/` — reserved for local infrastructure definitions such as SQL Server and MinIO.
- `docs/` — architecture decisions and phased roadmap.

## Run the prototype

```sh
cd mobile
flutter pub get
flutter run
```

The prototype uses local dummy data and does not require a backend, account, SQL Server, or MinIO.
