-- Run this in your Supabase SQL Editor to create the guests table

create table if not exists public.guests (
  id          bigint generated always as identity primary key,
  name        text not null,
  attending   boolean not null,
  message     text,
  created_at  timestamptz default now() not null
);

-- Allow anyone to insert (anon key is public-facing)
alter table public.guests enable row level security;

create policy "Allow anonymous inserts"
  on public.guests
  for insert
  to anon
  with check (true);

-- Optional: so you can read your own RSVPs (keep anon insert for guests)
create policy "Allow authenticated reads"
  on public.guests
  for select
  to authenticated
  using (true);
