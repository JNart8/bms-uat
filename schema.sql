create table if not exists uat_results (
  test_id text primary key,
  status text not null default 'not-run' check (status in ('not-run','pass','fail','partial')),
  remarks text not null default '',
  updated_at timestamptz not null default now()
);

alter table uat_results enable row level security;

create policy "public read" on uat_results for select using (true);
create policy "public insert" on uat_results for insert with check (true);
create policy "public update" on uat_results for update using (true) with check (true);

alter publication supabase_realtime add table uat_results;
