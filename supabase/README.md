# Backend preparation notes

This folder prepares the project for a future Supabase backend. The current app does not connect
to Supabase and works with local demo data.

Planned modules:
- Supabase Auth for account sessions
- profiles for user profile data
- tasks for active task catalog
- reward_ledger for auditable reward records
- referrals for referral relationships
- Edge Functions for server-side verification and ledger writes

Do not expose service-role keys in Flutter. Keep all secrets in server-side environment settings.
Before enabling real rewards or redemption, complete applicable legal, privacy, age and payment
provider reviews.
