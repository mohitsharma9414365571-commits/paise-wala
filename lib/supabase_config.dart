import 'package:supabase_flutter/supabase_flutter.dart';

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
