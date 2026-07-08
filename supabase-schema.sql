-- Doze v2 schema — run this once in Supabase → SQL Editor

create table public.doze_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  start_ms bigint not null,
  end_ms bigint,          -- null = currently sleeping
  created_at timestamptz default now()
);

create table public.doze_settings (
  user_id uuid primary key references auth.users(id) on delete cascade default auth.uid(),
  age text not null default 'toddler'
);

-- Row-level security: each account can only ever see its own data
alter table public.doze_sessions enable row level security;
alter table public.doze_settings enable row level security;

create policy "own sessions" on public.doze_sessions
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own settings" on public.doze_settings
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index doze_sessions_user_start on public.doze_sessions (user_id, start_ms desc);
