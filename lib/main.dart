import 'supabase_config.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const PaiseWalaApp());
}

const Color pwBlue = Color(0xFF0879E8);
const Color pwDeepBlue = Color(0xFF0756C8);
const Color pwNavy = Color(0xFF102B59);
const Color pwPaleBlue = Color(0xFFE8F4FF);
const Color pwBackground = Color(0xFFF4F9FF);
const Color pwMuted = Color(0xFF687B96);
const Color pwGreen = Color(0xFF159B62);

class PaiseWalaApp extends StatelessWidget {
  const PaiseWalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paise Wala',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pwBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: pwBlue,
          primary: pwBlue,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: pwBackground,
          foregroundColor: pwNavy,
          centerTitle: false,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4EDF7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4EDF7)),
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

void showInfo(BuildContext context, [String message = 'This feature will be connected during backend setup.']) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  static const pages = <Widget>[
    HomePage(),
    EarnPage(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.card_giftcard_outlined), selectedIcon: Icon(Icons.card_giftcard), label: 'Earn'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class PageHeading extends StatelessWidget {
  const PageHeading(this.title, this.subtitle, {super.key});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: pwNavy)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: pwMuted, fontSize: 13)),
      ],
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 42});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: pwBlue,
        borderRadius: BorderRadius.circular(size * .30),
      ),
      alignment: Alignment.center,
      child: Text('P', style: TextStyle(color: Colors.white, fontSize: size * .58, fontWeight: FontWeight.w900)),
    );
  }
}

class DemoBalanceCard extends StatelessWidget {
  const DemoBalanceCard({super.key, required this.onRedeem});
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1599F5), pwDeepBlue]),
        borderRadius: BorderRadius.circular(23),
        boxShadow: [BoxShadow(color: pwBlue.withValues(alpha: .18), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Demo Balance', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 5),
          Row(
            children: [
              const Expanded(child: Text('₹125.50', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900))),
              FilledButton.tonal(
                onPressed: onRedeem,
                style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: pwBlue),
                child: const Text('Redeem'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Expanded(child: _BalanceMetric(icon: Icons.monetization_on, label: 'Coins', value: '2,510')),
              SizedBox(width: 9),
              Expanded(child: _BalanceMetric(icon: Icons.trending_up, label: 'Today earned', value: '₹20.00')),
            ],
          ),
          const SizedBox(height: 9),
          const Text('Sample values • Preview mode only', style: TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}

class _BalanceMetric extends StatelessWidget {
  const _BalanceMetric({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: pwBlue),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: pwMuted, fontSize: 10)),
                Text(value, style: const TextStyle(color: pwNavy, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(17, 10, 17, 24),
        children: [
          Row(
            children: [
              const BrandMark(),
              const SizedBox(width: 10),
              const Text('Paise Wala', style: TextStyle(color: pwNavy, fontWeight: FontWeight.w900, fontSize: 21)),
              const Spacer(),
              IconButton(onPressed: () => showInfo(context, 'No new notifications.'), icon: const Icon(Icons.notifications_none, color: pwNavy)),
            ],
          ),
          const SizedBox(height: 15),
          const Text('Hi, welcome! 👋', style: TextStyle(color: pwNavy, fontSize: 22, fontWeight: FontWeight.w900)),
          const Text('Explore activities and rewards at your own pace.', style: TextStyle(color: pwMuted)),
          const SizedBox(height: 17),
          DemoBalanceCard(onRedeem: () => _open(context, const RedeemPage())),
          const SizedBox(height: 20),
          const Text('Quick actions', style: TextStyle(color: pwNavy, fontWeight: FontWeight.w900, fontSize: 17)),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.02,
            children: [
              _QuickTile(icon: Icons.calendar_month, label: 'Daily Bonus', onTap: () => showInfo(context)),
              _QuickTile(icon: Icons.task_alt, label: 'Tasks', onTap: () => _open(context, const EarnPage())),
              _QuickTile(icon: Icons.local_offer, label: 'Offers', onTap: () => _open(context, const EarnPage())),
              _QuickTile(icon: Icons.sports_esports, label: 'Games', onTap: () => _open(context, const EarnPage())),
              _QuickTile(icon: Icons.poll, label: 'Surveys', onTap: () => _open(context, const EarnPage())),
              _QuickTile(icon: Icons.people_alt, label: 'Refer & Earn', onTap: () => _open(context, const ReferralPage())),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(color: pwPaleBlue, borderRadius: BorderRadius.circular(20)),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Discover rewards', style: TextStyle(color: pwNavy, fontWeight: FontWeight.w900, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Browse sample activities in the Earn section.', style: TextStyle(color: pwMuted, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.card_giftcard, color: pwBlue, size: 42),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text('All balances and rewards shown are sample data, not real money.', style: TextStyle(color: pwMuted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4EDF7)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(backgroundColor: pwPaleBlue, child: Icon(icon, color: pwBlue)),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(color: pwNavy, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class EarnPage extends StatefulWidget {
  const EarnPage({super.key});

  @override
  State<EarnPage> createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> {
  String selectedFilter = 'All';

  static const filters = ['All', 'Tasks', 'Offers', 'Games', 'Surveys'];
  static const activities = <_Activity>[
    _Activity('Explore a learning app', 'Sample task • Preview only', '25 coins', 'Tasks', Icons.phone_android),
    _Activity('Try a casual game', 'Sample activity • Preview only', '50 coins', 'Games', Icons.sports_esports),
    _Activity('Complete a sample survey', 'Sample survey • Preview only', '100 coins', 'Surveys', Icons.assignment_outlined),
    _Activity('Discover a partner offer', 'Sample offer • Preview only', '20 coins', 'Offers', Icons.local_offer_outlined),
    _Activity('Watch a sample video', 'Sample activity • Preview only', '10 coins', 'Tasks', Icons.play_circle_outline),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = activities.where((item) => selectedFilter == 'All' || item.category == selectedFilter).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(17, 18, 17, 22),
        children: [
          const PageHeading('Earn Rewards', 'Explore activities and sample reward cards'),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((filter) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: selectedFilter == filter,
                  selectedColor: pwPaleBlue,
                  onSelected: (_) => setState(() => selectedFilter = filter),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 12),
          ...visible.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(backgroundColor: pwPaleBlue, child: Icon(item.icon, color: pwBlue)),
                title: Text(item.title, style: const TextStyle(color: pwNavy, fontWeight: FontWeight.w800, fontSize: 13)),
                subtitle: Text('${item.subtitle}\n${item.reward}', style: const TextStyle(color: pwGreen, fontSize: 11, height: 1.5)),
                isThreeLine: true,
                trailing: FilledButton(onPressed: () => showInfo(context, 'Preview only. No task was started or reward credited.'), child: const Text('View')),
              ),
            ),
          )),
          const Text('Partner offers, surveys and reward verification are not connected.', style: TextStyle(color: pwMuted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _Activity {
  const _Activity(this.title, this.subtitle, this.reward, this.category, this.icon);
  final String title;
  final String subtitle;
  final String reward;
  final String category;
  final IconData icon;
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(17, 18, 17, 22),
        children: [
          const PageHeading('Wallet', 'Your demo rewards overview'),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(21),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1599F5), pwDeepBlue]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Demo Balance', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 6),
                Text('₹125.50', style: TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w900)),
                Text('Sample balance • Not redeemable', style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on, color: pwBlue),
              title: Text('Coins balance'),
              subtitle: Text('2,510 sample coins'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.redeem, color: pwBlue),
              title: const Text('Redemption preview'),
              subtitle: const Text('No real payout available'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const RedeemPage())),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Recent transactions', style: TextStyle(color: pwNavy, fontWeight: FontWeight.w900, fontSize: 17)),
          const SizedBox(height: 8),
          const _TransactionRow(icon: Icons.add_circle_outline, title: 'Sample task reward', subtitle: 'Today • Demo entry', amount: '+ 10 coins', positive: true),
          const _TransactionRow(icon: Icons.card_giftcard, title: 'Daily bonus preview', subtitle: 'Today • Demo entry', amount: '+ 5 coins', positive: true),
          const _TransactionRow(icon: Icons.info_outline, title: 'Redemption preview', subtitle: 'No payout created', amount: '—', positive: false),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.icon, required this.title, required this.subtitle, required this.amount, required this.positive});
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(backgroundColor: pwPaleBlue, child: Icon(icon, color: pwBlue)),
          title: Text(title, style: const TextStyle(color: pwNavy, fontWeight: FontWeight.w700, fontSize: 13)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
          trailing: Text(amount, style: TextStyle(color: positive ? pwGreen : pwMuted, fontWeight: FontWeight.w900, fontSize: 12)),
        ),
      ),
    );
  }
}

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Refer & Earn')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.card_giftcard, size: 84, color: pwBlue),
          const SizedBox(height: 15),
          const Text('Invite friends', textAlign: TextAlign.center, style: TextStyle(color: pwNavy, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text('Share your demo referral code. Tracking will be added with backend setup.', textAlign: TextAlign.center, style: TextStyle(color: pwMuted)),
          const SizedBox(height: 22),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  Text('Your demo referral code', style: TextStyle(color: pwMuted)),
                  SizedBox(height: 8),
                  Text('PAISE123', style: TextStyle(color: pwNavy, fontSize: 25, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          FilledButton.icon(onPressed: () => showInfo(context, 'Invite sharing will be enabled later.'), icon: const Icon(Icons.share), label: const Text('Invite friends')),
          const SizedBox(height: 20),
          const Text('How it will work', style: TextStyle(color: pwNavy, fontWeight: FontWeight.w900, fontSize: 17)),
          const ListTile(leading: CircleAvatar(backgroundColor: pwPaleBlue, child: Text('1')), title: Text('Share your referral code')),
          const ListTile(leading: CircleAvatar(backgroundColor: pwPaleBlue, child: Text('2')), title: Text('Friend joins and completes eligible steps')),
          const ListTile(leading: CircleAvatar(backgroundColor: pwPaleBlue, child: Text('3')), title: Text('Server verifies eligibility')),
        ],
      ),
    );
  }
}

class RedeemPage extends StatefulWidget {
  const RedeemPage({super.key});

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  String selectedOption = 'Gift card preview';
  final amountController = TextEditingController(text: '50');

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redeem Rewards')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text('Choose a preview option', style: TextStyle(color: pwNavy, fontSize: 19, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          const Text('UI prototype only. No payment or payout is created.', style: TextStyle(color: pwMuted, fontSize: 12)),
          const SizedBox(height: 14),
          RadioGroup<String>(
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
          const SizedBox(height: 14),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Sample amount', prefixText: '₹'),
          ),
          const SizedBox(height: 17),
          FilledButton(onPressed: () => showInfo(context, 'Preview only. No redemption request or payment was created.'), child: const Text('Preview redemption')),
          const SizedBox(height: 10),
          const Text('No UPI ID, bank account or card details are collected.', style: TextStyle(color: pwMuted, fontSize: 11)),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const rows = <(String, IconData)>[
    ('Reward history', Icons.history),
    ('Redemption history', Icons.account_balance_wallet_outlined),
    ('Refer & Earn', Icons.people_outline),
    ('Help & Support', Icons.support_agent),
    ('About Paise Wala', Icons.info_outline),
    ('Settings', Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(17, 18, 17, 22),
        children: [
          const PageHeading('Profile', 'Manage your Paise Wala preview'),
          const SizedBox(height: 18),
          const Card(
            child: ListTile(
              contentPadding: EdgeInsets.all(13),
              leading: CircleAvatar(backgroundColor: pwPaleBlue, child: Icon(Icons.person, color: pwBlue, size: 30)),
              title: Text('Demo User', style: TextStyle(color: pwNavy, fontWeight: FontWeight.w900)),
              subtitle: Text('demo@paisewala.app'),
              trailing: Icon(Icons.edit_outlined, color: pwBlue),
            ),
          ),
          const SizedBox(height: 12),
          ...rows.map((row) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: ListTile(
                leading: Icon(row.$2, color: pwBlue),
                title: Text(row.$1),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (row.$1 == 'Refer & Earn') {
                    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ReferralPage()));
                  } else {
                    showInfo(context, '${row.$1} will be connected later.');
                  }
                },
              ),
            ),
          )),
          OutlinedButton.icon(onPressed: () => showInfo(context, 'Demo profile: no account signed in.'), icon: const Icon(Icons.logout), label: const Text('Sign out (demo)')),
        ],
      ),
    );
  }
}
