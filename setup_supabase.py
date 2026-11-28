from pathlib import Path
import re
import sys

# 1. Add Supabase dependency
p = Path("pubspec.yaml")
if not p.exists():
    sys.exit("ERROR: pubspec.yaml nahi mila. Project folder check karo.")

s = p.read_text()

if "supabase_flutter:" not in s:
    if not re.search(r"(?m)^dependencies:\s*$", s):
        sys.exit("ERROR: dependencies section nahi mila.")
    s = re.sub(
        r"(?m)^dependencies:\s*$",
        "dependencies:\n  supabase_flutter: ^2.8.4",
        s,
        count=1
    )
    p.write_text(s)
    print("OK: Supabase dependency added.")
else:
    print("OK: Supabase dependency already present.")

# 2. Create Supabase config
Path("lib").mkdir(exist_ok=True)

config = """import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url =
      'https://vrqbduutxihfaoewmnwj.supabase.co';

  static const String publishableKey =
      'sb_publishable_YcR-gxjBQU83Z0sMLafNMQ_gZ9xQUSm';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      publishableKey: publishableKey,
    );
  }
}
"""

Path("lib/supabase_config.dart").write_text(config)
print("OK: Supabase config created.")

# 3. Initialize Supabase before app starts
p = Path("lib/main.dart")
if not p.exists():
    sys.exit("ERROR: lib/main.dart nahi mila.")

s = p.read_text()

if "supabase_config.dart" not in s:
    s = "import 'supabase_config.dart';\n" + s

if "SupabaseConfig.initialize()" not in s:
    if not re.search(r"(?m)^void main\s*\(\s*\)", s):
        sys.exit("STOP: main() ka expected format nahi mila. File unchanged rakhi; manually inspect required.")

    s = re.sub(
        r"(?m)^void main\s*\(\s*\)",
        "Future<void> main() async",
        s,
        count=1
    )

    if "runApp(" not in s:
        sys.exit("STOP: runApp() nahi mila. File update nahi ki.")
    
    s = s.replace(
        "runApp(",
        "await SupabaseConfig.initialize();\n  runApp(",
        1
    )

p.write_text(s)
print("OK: Supabase initialization added to main.dart.")
print("\nSETUP COMPLETE")
