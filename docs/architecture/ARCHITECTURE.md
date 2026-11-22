# Architecture

Start with a modular monolith and a versioned API. Keep business domains separated in code and database design. Avoid microservices until scale and operational needs justify them.

- Web/PWA: Next.js
- Android: React Native / Expo (planned)
- Data: PostgreSQL through a dedicated Supabase project
- Auth: managed authentication; never store plaintext passwords
- Sensitive operations: server-side only
- API: `/api/v1/...`
