-- CIVILINK NIGERIA database foundation
-- This migration intentionally creates no public-facing business tables yet.
-- Confirm the dedicated Supabase project and review security requirements first.

create extension if not exists pgcrypto;

create table if not exists public.schema_migrations (
  version text primary key,
  applied_at timestamptz not null default now()
);

insert into public.schema_migrations (version)
values ('0001_initial_setup')
on conflict (version) do nothing;

-- IMPORTANT:
-- Enable Row Level Security on every user-data table when those tables are added.
-- Do not expose candidate documents, identity documents, audit logs, or admin data publicly.
