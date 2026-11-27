-- Tabelle per la lista della spesa condivisa dell'app Pasti
create table if not exists spunte (
  id text primary key,
  fatto boolean default true,
  aggiornato timestamptz default now()
);
create table if not exists extra (
  id uuid primary key default gen_random_uuid(),
  nome text not null check (char_length(nome) <= 80),
  fatto boolean default false,
  creato timestamptz default now()
);
alter table spunte enable row level security;
alter table extra enable row level security;
create policy "app pasti" on spunte for all to anon using (true) with check (true);
create policy "app pasti" on extra for all to anon using (true) with check (true);
alter publication supabase_realtime add table spunte, extra;
