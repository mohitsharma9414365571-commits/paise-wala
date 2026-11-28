from pathlib import Path

# Update pubspec.yaml
p = Path("pubspec.yaml")
s = p.read_text()

if "flutter_launcher_icons:" not in s:
    s = s.replace(
        "  flutter_lints: ^4.0.0",
        "  flutter_lints: ^4.0.0\n  flutter_launcher_icons: ^0.14.4"
    )

if "flutter_launcher_icons:" not in s:
    s += """

flutter_launcher_icons:
  android: true
  ios: false
  image_path: assets/icon/app_icon.png
  adaptive_icon_background: "#0879E8"
  adaptive_icon_foreground: assets/icon/app_icon.png
"""

p.write_text(s)

# Update GitHub Actions workflow
p = Path(".github/workflows/build-apk.yml")
s = p.read_text()

label_step = """      - name: Set Android app display name
        run: |
          sed -i 's/android:label="[^"]*"/android:label="Paise Wala"/' android/app/src/main/AndroidManifest.xml

"""

if "Set Android app display name" not in s:
    marker = "      - name: Install dependencies\n"
    if marker not in s:
        raise SystemExit("STOP: Workflow dependency step not found.")
    s = s.replace(marker, label_step + marker, 1)

icon_step = """      - name: Generate launcher icons
        run: dart run flutter_launcher_icons

"""

if "Generate launcher icons" not in s:
    marker = "      - name: Run static analysis\n"
    if marker not in s:
        raise SystemExit("STOP: Static analysis step not found.")
    s = s.replace(marker, icon_step + marker, 1)

p.write_text(s)

print("SUCCESS: Branding configuration updated.")
