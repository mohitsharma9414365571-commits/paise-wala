from pathlib import Path

# 1. Update pubspec.yaml
p = Path("pubspec.yaml")
s = p.read_text()

if "material_ui:" not in s:
    old = """dependencies:
  flutter:
    sdk: flutter
"""
    new = """dependencies:
  flutter:
    sdk: flutter
  material_ui: ^1.0.0
"""
    if s.count(old) != 1:
        raise SystemExit("STOP: pubspec dependencies block mismatch")
    p.write_text(s.replace(old, new))

# 2. Update main.dart
p = Path("lib/main.dart")
s = p.read_text()

if "package:flutter/material.dart" in s:
    s = s.replace(
        "package:flutter/material.dart",
        "package:material_ui/material_ui.dart"
    )

s = s.replace(
    "pwBlue.withOpacity(.18)",
    "pwBlue.withValues(alpha: .18)"
)

old = """          ...['Gift card preview', 'UPI flow preview (disabled)', 'Bank transfer preview (disabled)'].map((option) => Card(
            child: RadioListTile<String>(
              value: option,
              groupValue: selectedOption,
              onChanged: option.contains('disabled') ? null : (value) => setState(() => selectedOption = value!),
              title: Text(option, style: const TextStyle(color: pwNavy, fontSize: 13, fontWeight: FontWeight.w700)),
              secondary: const Icon(Icons.redeem, color: pwBlue),
            ),
          )),
"""

new = """          RadioGroup<String>(
            groupValue: selectedOption,
            onChanged: (value) {
              if (value != null && !value.contains('disabled')) {
                setState(() => selectedOption = value);
              }
            },
            child: Column(
              children: ['Gift card preview', 'UPI flow preview (disabled)', 'Bank transfer preview (disabled)']
                  .map((option) => Card(
                        child: RadioListTile<String>(
                          value: option,
                          enabled: !option.contains('disabled'),
                          title: Text(
                            option,
                            style: const TextStyle(
                              color: pwNavy,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          secondary: const Icon(Icons.redeem, color: pwBlue),
                        ),
                      ))
                  .toList(),
            ),
          ),
"""

if old in s:
    s = s.replace(old, new)
elif "RadioGroup<String>(" not in s:
    raise SystemExit("STOP: Radio block did not match. No radio replacement made.")

p.write_text(s)
print("SUCCESS: Source files patched.")
