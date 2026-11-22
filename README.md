# CIVILINK NIGERIA

**One Platform. Every Nigerian. Endless Opportunities.**

CIVILINK NIGERIA is a planned national digital platform connecting people to jobs, businesses, products, services, education opportunities and useful information. The initial pilot is planned for Sokoto State, with a nationwide-ready foundation.

## Current package status

This ZIP contains the **Stage 1 starter foundation**, not a finished production platform. It provides a structured monorepo, a basic Next.js web/PWA starting point, project documentation, and an initial Supabase database migration placeholder. Authentication, verified geography, role-based access control, moderation, mobile app features and the marketplace modules still need to be implemented and tested in later stages.

## Technology direction

- Web/PWA: Next.js + TypeScript
- Android: React Native / Expo (planned)
- Database and authentication: Supabase / PostgreSQL (planned)
- Architecture: modular monolith, API-first
- Languages planned: English, Hausa, Yoruba, Igbo and Nigerian Pidgin

## Repository structure

```text
apps/
  web/                 Next.js website and PWA starter
  android/             Android app implementation placeholder
  admin/               Admin application placeholder
packages/
  shared-types/
  validation/
  api-client/
  translations/
  design-system/
backend/
  database/
    migrations/
    seeds/
    tests/
  functions/
  integrations/
docs/
  requirements/
  architecture/
  security/
  testing/
  deployment/
```

## Run the web starter

Requirements: Node.js 20.9 or newer and npm.

```bash
cd apps/web
npm install
npm run dev
```

Open http://localhost:3000.

## Environment variables

Copy `apps/web/.env.example` to `apps/web/.env.local` when you are ready to connect a dedicated CIVILINK Supabase project.

Never commit `.env.local`, passwords, API secrets, or Supabase service-role keys. Only a Supabase publishable/anon key intended for browser use may be placed in a client environment, and only after Row Level Security policies are correctly configured.

## Important setup sequence

1. Create and protect the private GitHub repository.
2. Upload this starter source code.
3. Create a separate Supabase project specifically for CIVILINK NIGERIA.
4. Apply reviewed database migrations.
5. Implement authentication, geographic data, roles and Row Level Security.
6. Build and test the first business directory and services modules.
7. Add jobs, marketplace and education modules in later releases.

## Ownership and legal readiness

Keep the GitHub organisation/repository, Supabase project, domain, hosting, Android publishing account and payment-provider accounts under the project owner's control. Before public launch, arrange legal review of the name, privacy notice, terms, Nigerian data-protection obligations and relevant marketplace requirements.
