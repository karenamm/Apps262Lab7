-- Tablas del Laboratorio 6 (posts y likes), que no estaban en este proyecto.
create table public.posts (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  content text not null,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.posts to authenticated;

create table public.likes (
  post_id uuid not null references public.posts(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, profile_id)
);
grant select, insert, update, delete on public.likes to authenticated;

-- El muro muestra el autor de cada post: quien inició sesión puede leer todos los perfiles.
create policy "profiles_select_authenticated" on public.profiles
  for select to authenticated using (true);
