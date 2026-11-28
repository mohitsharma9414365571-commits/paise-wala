-- Initial schema foundation. Review before production deployment.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  referral_code text unique,
  created_at timestamptz not null default now()
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  category text not null check (category in ('task','offer','game','survey')),
  points integer not null check (points >= 0),
  is_active boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.reward_ledger (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  event_type text not null check (event_type in ('task_reward','daily_bonus','referral_reward','adjustment','redemption')),
  points integer not null,
  description text not null,
  status text not null default 'pending' check (status in ('pending','verified','rejected')),
  provider_reference text,
  created_at timestamptz not null default now()
);

create table if not exists public.referrals (
  id uuid primary key default gen_random_uuid(),
  referrer_user_id uuid not null references auth.users(id) on delete cascade,
  referred_user_id uuid unique references auth.users(id) on delete set null,
  status text not null default 'pending' check (status in ('pending','qualified','rejected')),
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.tasks enable row level security;
alter table public.reward_ledger enable row level security;
alter table public.referrals enable row level security;

drop policy if exists "Read own profile" on public.profiles;
create policy "Read own profile" on public.profiles
  for select to authenticated using (auth.uid() = id);

drop policy if exists "Update own profile" on public.profiles;
create policy "Update own profile" on public.profiles
  for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "Read active tasks" on public.tasks;
create policy "Read active tasks" on public.tasks
  for select to authenticated using (is_active = true);

drop policy if exists "Read own ledger" on public.reward_ledger;
create policy "Read own ledger" on public.reward_ledger
  for select to authenticated using (auth.uid() = user_id);

drop policy if exists "Read own referrals" on public.referrals;
create policy "Read own referrals" on public.referrals
  for select to authenticated
  using (auth.uid() = referrer_user_id or auth.uid() = referred_user_id);

-- Intentionally no client insert/update policies for reward_ledger or referrals.
-- Trusted Edge Functions must validate all reward events and write ledger entries.
