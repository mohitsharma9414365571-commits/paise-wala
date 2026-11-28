# Supabase backend preparation

The mobile app in this repository currently runs in demo mode and does not connect to Supabase.

## Planned production architecture
- Supabase Auth: user sign-up, sign-in, and session management.
- Postgres: profiles, tasks, reward ledger, referrals.
- Row Level Security: users can read only their own private rows.
- Edge Functions: verify task-provider callbacks and create ledger entries server-side.
- Admin operations: separate trusted server-side role, never embedded in the app.

## Setup later
1. Create a Supabase project.
2. Review `schema.sql` with the intended production rules.
3. Apply the SQL in Supabase SQL Editor.
4. Configure the app with the project URL and public anon/publishable key.
5. Implement Auth and data repositories.
6. Add Edge Functions for reward verification.

Never put the Supabase service-role key, payment secrets, webhook secrets, or signing keys in Flutter code or this repository.
The current UI intentionally does not claim that demo balances are real or redeemable.
