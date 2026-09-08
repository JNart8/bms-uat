# IBS UAT Tracker

An 85-case end-to-end User Acceptance Test script for the IBS Business
Management System, grouped by functional area (Login, Users & Roles,
Categories & Products, Suppliers, Purchasing, Customers, Sales/POS,
Inventory, Financial Accounts, Expenses, Multi-Branch, Stock Transfers,
Customer Credit Settlement, Reports, Import/Export, Audit Trail,
Settings).

It's a single static page (`index.html`) backed by a
[Supabase](https://supabase.com) Postgres table for shared, live-synced
results — anyone with the page's URL can set a Pass / Fail / Partial
Passed result and a remark per test case, and everyone else viewing the
page sees it update live via Supabase Realtime. No login is required;
access is gated only by knowing the URL.

## Hosting

Served as a static site via GitHub Pages from this repo's `main`
branch, root folder. Enable it under **Settings → Pages → Source:
Deploy from a branch → `main` / `(root)`**.

## Backend setup

The Supabase table this page reads/writes is defined in
[`schema.sql`](schema.sql). To (re)create it in a new or existing
Supabase project, open the project's **SQL Editor** and run that file.
It creates the `uat_results` table, enables Row Level Security with
public read/insert/update policies (no auth — anyone with the anon key
can write), and adds the table to the `supabase_realtime` publication
so changes push live to every open tab.

The page's Supabase **Project URL** and **anon/public API key** are
hardcoded near the top of `index.html`'s `<script>` block (`SUPABASE_URL`,
`SUPABASE_ANON_KEY`). The anon key is meant to be public — it's exactly
what Supabase expects to ship in client-side code — but it does mean
row-level security is the only thing standing between "anyone with the
URL" and read/write access to this table. If the project's anon key is
ever rotated, update those two constants and re-push.

## Editing the test cases

The test cases themselves live in the `GROUPS` array near the top of
`index.html`'s script — each entry is `[id, instruction text, optional
plan tag]` grouped under a `[code, name, cases]` section. Add, edit or
reorder cases there directly; no build step, just edit and push.
