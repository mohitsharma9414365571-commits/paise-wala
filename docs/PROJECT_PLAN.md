# Paise Wala project map

## Included in this repository
- Light-blue Flutter UI: Home, Earn, Wallet, Redeem preview, Referral, Profile.
- Flutter widget tests.
- GitHub Actions workflow to analyze, test, build a debug APK, and publish it as an artifact.
- Supabase starter schema and security notes.
- Environment-variable placeholder file and ignore rules.

## Automatic APK build
Every push to `main` triggers `.github/workflows/build-apk.yml`.
Open GitHub > Actions > Build Paise Wala Android APK > latest successful run > Artifacts > `paise-wala-debug-apk`.
The downloaded artifact is a debug APK for testing, not a Play Store release.

## Not yet live / requires external setup
- Supabase project and credentials.
- Real authentication and persistent user accounts.
- Offerwall / survey / task provider accounts and verified callbacks.
- Server-side reward verification and anti-fraud checks.
- Real redemption provider, compliance review, and secure payout integration.
- Production signing key and Play Store release configuration.

Never trust reward amounts calculated by the mobile client. Do not commit credentials or signing keys.
