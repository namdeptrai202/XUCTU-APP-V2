# Architecture

## Repository and deployment direction

Xuctu is a monorepo and will use a modular monolith. The future backend will be one ASP.NET Core Web API application using Entity Framework Core and SQL Server, organized by business feature rather than by many technical layers. PDF files and images will later be stored in MinIO.

The admin client will be React, TypeScript, and Vite. The mobile client is Flutter for Android and iOS. These clients will consume the same backend when backend integration is introduced.

## Current mobile prototype

Phase 1 is deliberately local and content-first. Screens consume a small `ResourceRepository` interface whose current implementation returns realistic in-memory data. Replacing it with an API-backed implementation later should not require rebuilding the UI. Resource progress is normalized from `0.0` (not started) to `1.0` (complete). The selected grade is the only persisted value.

State is kept close to the widgets that own it. No state-management framework, service locator, generated architecture, or speculative domain layer is used.

## Agreed domain direction

- A resource is either a document (`1`) or video (`2`).
- Grades are numeric values from 6 through 12, not database entities.
- Each resource belongs to one category through `CategoryId`.
- Premium resource access will later be represented by `UserResourceAccess`.
- End-user authentication will eventually support Google and Facebook only.

Courses, lessons, articles, chats, friends, classrooms, quizzes, AI, subscriptions, recommendations, home-section entities, banners, and generic entitlement systems are outside the agreed scope.
