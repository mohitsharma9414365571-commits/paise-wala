# Paise Wala — Complete Flutter Starter

Light-blue / white mobile rewards-app frontend with a GitHub Actions Android APK build pipeline.

## Screens included
- Home dashboard with demo balance and quick actions
- Earn Rewards with category filters
- Wallet and sample transaction history
- Referral screen
- Redemption preview
- Profile screen

## Build APK automatically on GitHub
1. Push this repository to the `main` branch.
2. Open the repository's **Actions** tab.
3. Open the latest **Build Paise Wala Android APK** run.
4. Wait for the workflow to finish successfully.
5. Download the `paise-wala-debug-apk` artifact.

The workflow creates Android platform scaffolding in the GitHub runner if the `android/` folder is absent, then runs `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter build apk --debug`.

You can also trigger it manually from Actions using **Run workflow**.

## Run locally
Install Flutter stable, then:
```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Important current status
This is a complete buildable Flutter starter and demo-mode frontend. It is **not yet a live earning/payment app**. Balance, coins, tasks, referral code and transactions are sample UI data. No real money is earned, stored, transferred or paid out. The app does not collect UPI IDs, bank details, or card information.

## Backend
See `supabase/README.md` and `supabase/schema.sql`. Supabase credentials and provider integrations must be configured separately. Keep service-role keys, webhook secrets, payment secrets, and Android signing keys out of the app and Git repository.

## Android release
The included workflow builds a debug APK for testing. A Play Store-ready release requires a properly secured signing key, release configuration, privacy policy, compliance checks and store setup.
