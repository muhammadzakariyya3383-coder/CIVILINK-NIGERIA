-- CIVILINK NIGERIA: Core database foundation
-- Migration 0002

create extension if not exists pgcrypto;

-- 1. Nigerian geographic structure
create table if not exists public.states (
    id uuid primary key default gen_random_uuid(),
    name text not null unique,
    code text unique,
    created_at timestamptz not null default now()
);

create table if not exists public.lgas (
    id uuid primary key default gen_random_uuid(),
    state_id uuid not null references public.states(id),
    name text not null,
    created_at timestamptz not null default now(),
    unique (state_id, name),
    unique (id, state_id)
);

create table if not exists public.localities (
    id uuid primary key default gen_random_uuid(),
    state_id uuid not null references public.states(id),
    lga_id uuid not null,
    name text not null,
    created_at timestamptz not null default now(),
    foreign key (lga_id, state_id)
        references public.lgas(id, state_id),
    unique (id, lga_id),
    unique (lga_id, name)
);

-- 2. User profiles
create table if not exists public.profiles (
    id uuid primary key references auth.users(id) on delete cascade,
    display_name text,
    phone text,
    preferred_language text not null default 'en'
        check (preferred_language in ('en','ha','yo','ig','pcm')),
    state_id uuid references public.states(id),
    lga_id uuid,
    locality_id uuid,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    foreign key (lga_id, state_id)
        references public.lgas(id, state_id),
    foreign key (locality_id, lga_id)
        references public.localities(id, lga_id)
);

-- 3. Platform roles
create table if not exists public.roles (
    id uuid primary key default gen_random_uuid(),
    code text not null unique,
    description text,
    created_at timestamptz not null default now()
);

insert into public.roles (code, description) values
('USER', 'Ordinary platform user'),
('BUSINESS_OWNER', 'Business account owner'),
('EMPLOYER', 'Employer account'),
('SELLER', 'Marketplace seller'),
('SERVICE_PROVIDER', 'Service provider'),
('MODERATOR', 'Content moderator'),
('STATE_ADMIN', 'State-level administrator'),
('NATIONAL_ADMIN', 'National administrator'),
('SUPER_ADMIN', 'Platform owner administrator')
on conflict (code) do nothing;

-- 4. User role assignments
create table if not exists public.user_roles (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references auth.users(id) on delete cascade,
    role_id uuid not null references public.roles(id),
    scope_state_id uuid references public.states(id),
    assigned_at timestamptz not null default now(),
    unique (user_id, role_id, scope_state_id)
);

create index if not exists idx_lgas_state
    on public.lgas(state_id);

create index if not exists idx_localities_lga
    on public.localities(lga_id);

create index if not exists idx_profiles_state
    on public.profiles(state_id);

create index if not exists idx_user_roles_user
    on public.user_roles(user_id);

-- 5. Automatically create a profile after signup
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
    insert into public.profiles (id, display_name)
    values (
        new.id,
        nullif(new.raw_user_meta_data ->> 'display_name', '')
    )
    on conflict (id) do nothing;

    return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

-- 6. Enable Row Level Security
alter table public.states enable row level security;
alter table public.lgas enable row level security;
alter table public.localities enable row level security;
alter table public.profiles enable row level security;
alter table public.roles enable row level security;
alter table public.user_roles enable row level security;

-- Geographic information is publicly readable
create policy "Geography is publicly readable"
on public.states for select
to anon, authenticated
using (true);

create policy "LGAs are publicly readable"
on public.lgas for select
to anon, authenticated
using (true);

create policy "Localities are publicly readable"
on public.localities for select
to anon, authenticated
using (true);

-- Authenticated users can read platform role definitions
create policy "Authenticated users can read roles"
on public.roles for select
to authenticated
using (true);

-- Users can read and update only their own profile
create policy "Users can read own profile"
on public.profiles for select
to authenticated
using ((select auth.uid()) = id);

create policy "Users can update own profile"
on public.profiles for update
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);

-- Users can read their own role assignments.
-- No client-side role assignment or modification is permitted.
create policy "Users can read own role assignments"
on public.user_roles for select
to authenticated
using ((select auth.uid()) = user_id);

-- 7. Database permissions
grant select on public.states, public.lgas, public.localities
to anon, authenticated;

grant select on public.roles to authenticated;

grant select, update on public.profiles to authenticated;

grant select on public.user_roles to authenticated;

-- 8. Record migration
insert into public.schema_migrations (version)
values ('0002_core_foundation')
on conflict (version) do nothing;
