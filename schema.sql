-- Cole e execute no SQL Editor do Supabase.
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  customer_name text not null,
  phone text,
  product text not null,
  product_url text,
  last_price numeric(12,2),
  target_price numeric(12,2),
  status text not null default 'procurando'
    check (status in ('procurando','encontrado','comprado','cancelado')),
  notes text,
  created_at timestamptz not null default now()
);
create index if not exists orders_owner_created_idx on public.orders(owner_id,created_at desc);
alter table public.orders enable row level security;
drop policy if exists "owner select" on public.orders;
create policy "owner select" on public.orders for select to authenticated using (owner_id = (select auth.uid()));
drop policy if exists "owner insert" on public.orders;
create policy "owner insert" on public.orders for insert to authenticated with check (owner_id = (select auth.uid()));
drop policy if exists "owner update" on public.orders;
create policy "owner update" on public.orders for update to authenticated using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));
drop policy if exists "owner delete" on public.orders;
create policy "owner delete" on public.orders for delete to authenticated using (owner_id = (select auth.uid()));
grant select,insert,update,delete on public.orders to authenticated;
