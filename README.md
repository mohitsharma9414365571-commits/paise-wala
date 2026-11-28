# Paise Wala Flutter Frontend

This is the mobile-first Flutter frontend starter matching the approved light-blue / white design reference.

## Included screens
- Home dashboard
- Earn Rewards with category filters
- Wallet and sample transaction history
- Refer & Earn
- Redeem preview
- Profile and settings placeholders

## Demo-mode safety
All balances, coins, tasks, referral codes and transactions are sample UI data.
No real money is earned, stored, transferred or paid out. The redeem page is a preview only.
It does not collect UPI IDs, bank details, card data or initiate payments.

## Run
Install Flutter stable, then:
```bash
flutter pub get
flutter run
```

## Backend preparation
See `supabase/schema.sql` and `supabase/README.md`.
The Flutter app is intentionally frontend-only for this milestone. Later backend work should use
Supabase Auth, Postgres with Row Level Security, and server-side Edge Functions for reward
verification. Never trust reward amounts supplied by the client. Never put service-role keys
or payment secrets in the Flutter app or GitHub.
