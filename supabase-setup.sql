-- Run this in the Supabase SQL Editor (Project > SQL Editor > New query)
-- to set up the table the contact form writes to.

create table if not exists public.contact_submissions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  company text,
  service text,
  message text not null,
  created_at timestamptz not null default now()
);

-- Enable Row Level Security
alter table public.contact_submissions enable row level security;

-- Allow anyone (including the anon/public key used in the browser)
-- to INSERT new rows, but not read, update, or delete them.
create policy "Allow public inserts"
  on public.contact_submissions
  for insert
  to anon
  with check (true);

-- (No SELECT/UPDATE/DELETE policy is created, so submissions are
-- only readable from the Supabase dashboard or with the service role key.)
