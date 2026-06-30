-- ============================================================
--  BITÁCORA DE GUÍAS — Configuración de Supabase
--  Pega TODO esto en: Supabase → SQL Editor → New query → Run
--  Es seguro ejecutarlo más de una vez.
-- ============================================================

-- 1) Tabla de guías (el repositorio común) -------------------
create table if not exists public.guias (
  id          uuid primary key default gen_random_uuid(),
  guia        text not null,
  origen      text,
  destino     text,
  conductor   text,
  camion      text,
  acoplado    text,
  cliente     text default '',
  foto1_path  text,
  foto2_path  text,
  created_by  uuid references auth.users(id),
  created_at  timestamptz default now()
);

alter table public.guias enable row level security;

-- Reglas de acceso: cualquier usuario con cuenta ve y trabaja todo el repositorio.
drop policy if exists "guias_select" on public.guias;
create policy "guias_select" on public.guias
  for select to authenticated using (true);

drop policy if exists "guias_insert" on public.guias;
create policy "guias_insert" on public.guias
  for insert to authenticated with check (auth.uid() = created_by);

drop policy if exists "guias_update" on public.guias;
create policy "guias_update" on public.guias
  for update to authenticated using (true) with check (true);

drop policy if exists "guias_delete" on public.guias;
create policy "guias_delete" on public.guias
  for delete to authenticated using (true);

-- 2) Bucket privado para las fotos ---------------------------
insert into storage.buckets (id, name, public)
values ('respaldos', 'respaldos', false)
on conflict (id) do nothing;

-- Reglas del bucket: usuarios con cuenta pueden subir, ver y borrar fotos.
drop policy if exists "respaldos_insert" on storage.objects;
create policy "respaldos_insert" on storage.objects
  for insert to authenticated with check (bucket_id = 'respaldos');

drop policy if exists "respaldos_select" on storage.objects;
create policy "respaldos_select" on storage.objects
  for select to authenticated using (bucket_id = 'respaldos');

drop policy if exists "respaldos_delete" on storage.objects;
create policy "respaldos_delete" on storage.objects
  for delete to authenticated using (bucket_id = 'respaldos');

-- Listo. Ahora crea los usuarios en Authentication → Users → Add user.
