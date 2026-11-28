import 'package:flutter/material.dart';

void main() => runApp(const PaiseWalaApp());

const navy = Color(0xFF102B59);
const blue = Color(0xFF0879E8);
const pale = Color(0xFFE8F4FF);
const bg = Color(0xFFF4F9FF);
const muted = Color(0xFF687B96);
const green = Color(0xFF159B62);

class PaiseWalaApp extends StatelessWidget {
  const PaiseWalaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Paise Wala', debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true, scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: blue, primary: blue),
      appBarTheme: const AppBarTheme(backgroundColor: bg, foregroundColor: navy,
        centerTitle: true, elevation: 0),
      cardTheme: CardTheme(
        color: Colors.white, elevation: 0, margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFE4EDF7))),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white, indicatorColor: pale),
    ),
    home: const MainShell(),
  );
}

void note(BuildContext context, [String msg = 'Preview only. Backend will be connected later.']) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [HomePage(), EarnPage(), WalletPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: index, children: pages),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (v) => setState(() => index = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.card_giftcard_outlined), selectedIcon: Icon(Icons.card_giftcard), label: 'Earn'),
        NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ],
    ),
  );
}

class Heading extends StatelessWidget {
  final String title, subtitle;
  const Heading(this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)),
  ]);
}

class BalanceCard extends StatelessWidget {
  final VoidCallback onRedeem;
  const BalanceCard({super.key, required this.onRedeem});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF1599F5), Color(0xFF0756C8)]),
      borderRadius: BorderRadius.circular(23),
      boxShadow: [BoxShadow(color: blue.withOpacity(.18), blurRadius: 18, offset: const Offset(0, 8))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Total Demo Balance', style: TextStyle(color: Colors.white70)),
      const SizedBox(height: 5),
      Row(children: [
        const Expanded(child: Text('₹125.50', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900))),
        FilledButton.tonal(
          onPressed: onRedeem,
          style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: blue),
          child: const Text('Redeem')),
      ]),
      const SizedBox(height: 14),
      Row(children: const [
        Expanded(child: Metric(icon: Icons.monetization_on, label: 'Coins', value: '2,510')),
        SizedBox(width: 9),
        Expanded(child: Metric(icon: Icons.trending_up, label: 'Today earned', value: '₹20.00')),
      ]),
      const SizedBox(height: 8),
      const Text('Sample values • Preview mode only', style: TextStyle(color: Colors.white70, fontSize: 10)),
    ]),
  );
}

class Metric extends StatelessWidget {
  final IconData icon; final String label, value;
  const Metric({super.key, required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      Icon(icon, color: blue), const SizedBox(width: 7),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: muted, fontSize: 10)),
        Text(value, style: const TextStyle(color: navy, fontWeight: FontWeight.w900)),
      ])),
    ]),
  );
}

class QuickTile extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap;
  const QuickTile({super.key, required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white, borderRadius: BorderRadius.circular(18),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE4EDF7))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(backgroundColor: pale, child: Icon(icon, color: blue)),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: navy, fontSize: 11, fontWeight: FontWeight.w700)),
        ]),
      )),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void open(BuildContext c, Widget page) => Navigator.push(c, MaterialPageRoute(builder: (_) => page));
  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(17, 10, 17, 24), children: [
    Row(children: [
      const CircleAvatar(backgroundColor: blue, child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22))),
      const SizedBox(width: 10),
      const Text('Paise Wala', style: TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 21)),
      const Spacer(),
      IconButton(onPressed: () => note(context, 'No new notifications.'), icon: const Icon(Icons.notifications_none, color: navy)),
    ]),
    const SizedBox(height: 15),
    const Text('Hi, welcome! 👋', style: TextStyle(color: navy, fontSize: 22, fontWeight: FontWeight.w900)),
    const Text('Explore tasks and rewards at your own pace.', style: TextStyle(color: muted)),
    const SizedBox(height: 17),
    BalanceCard(onRedeem: () => open(context, const RedeemPage())),
    const SizedBox(height: 20),
    const Text('Quick actions', style: TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 17)),
    const SizedBox(height: 10),
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.02,
      children: [
        QuickTile(icon: Icons.calendar_month, label: 'Daily Bonus', onTap: () => note(context)),
        QuickTile(icon: Icons.task_alt, label: 'Tasks', onTap: () => open(context, const EarnPage())),
        QuickTile(icon: Icons.local_offer, label: 'Offers', onTap: () => open(context, const EarnPage())),
        QuickTile(icon: Icons.sports_esports, label: 'Games', onTap: () => open(context, const EarnPage())),
        QuickTile(icon: Icons.poll, label: 'Surveys', onTap: () => open(context, const EarnPage())),
        QuickTile(icon: Icons.people_alt, label: 'Refer & Earn', onTap: () => open(context, const ReferralPage())),
      ]),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(20)),
      child: const Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Discover rewards', style: TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 16)),
          SizedBox(height: 4), Text('Browse sample activities in the Earn section.', style: TextStyle(color: muted, fontSize: 12)),
        ])),
        Icon(Icons.card_giftcard, color: blue, size: 42),
      ])),
    const SizedBox(height: 14),
    const Text('All balances and rewards shown are sample data, not real money.', style: TextStyle(color: muted, fontSize: 11)),
  ]));
}

class EarnPage extends StatefulWidget {
  const EarnPage({super.key});
  @override
  State<EarnPage> createState() => _EarnPageState();
}
class _EarnPageState extends State<EarnPage> {
  String filter = 'All';
  final filters = const ['All', 'Tasks', 'Offers', 'Games', 'Surveys'];
  final tasks = const [
    ('Explore a learning app', 'Sample task • Preview only', '25 coins', 'Tasks', Icons.phone_android),
    ('Try a casual game', 'Sample activity • Preview only', '50 coins', 'Games', Icons.sports_esports),
    ('Complete a sample survey', 'Sample survey • Preview only', '100 coins', 'Surveys', Icons.assignment_outlined),
    ('Discover a partner offer', 'Sample offer • Preview only', '20 coins', 'Offers', Icons.local_offer_outlined),
    ('Watch a sample video', 'Sample activity • Preview only', '10 coins', 'Tasks', Icons.play_circle_outline),
  ];
  @override
  Widget build(BuildContext context) {
    final visible = tasks.where((t) => filter == 'All' || t.$4 == filter).toList();
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(17, 18, 17, 22), children: [
      const Heading('Earn Rewards', 'Explore activities and sample reward cards'),
      const SizedBox(height: 15),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: filters.map((f) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(label: Text(f), selected: filter == f, selectedColor: pale,
          onSelected: (_) => setState(() => filter = f)),
      )).toList())),
      const SizedBox(height: 12),
      ...visible.map((t) => Padding(padding: const EdgeInsets.only(bottom: 10),
        child: Card(child: ListTile(
          leading: CircleAvatar(backgroundColor: pale, child: Icon(t.$5, color: blue)),
          title: Text(t.$1, style: const TextStyle(color: navy, fontWeight: FontWeight.w800, fontSize: 13)),
          subtitle: Text('${t.$2}\n${t.$3}', style: const TextStyle(color: green, fontSize: 11, height: 1.5)),
          isThreeLine: true,
          trailing: FilledButton(onPressed: () => note(context, 'Preview only. No task was started or reward credited.'), child: const Text('View')),
        )))),
      const Text('Partner offers, surveys and reward verification are not connected.', style: TextStyle(color: muted, fontSize: 11)),
    ]));
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(17, 18, 17, 22), children: [
    const Heading('Wallet', 'Your demo rewards overview'),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(21), decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF1599F5), Color(0xFF0756C8)]),
      borderRadius: BorderRadius.circular(22)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Available Demo Balance', style: TextStyle(color: Colors.white70)),
        SizedBox(height: 6), Text('₹125.50', style: TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w900)),
        Text('Sample balance • Not redeemable', style: TextStyle(color: Colors.white70, fontSize: 11)),
      ])),
    const SizedBox(height: 12),
    Card(child: ListTile(leading: const Icon(Icons.monetization_on, color: blue),
      title: const Text('Coins balance'), subtitle: const Text('2,510 sample coins'),
      trailing: TextButton(onPressed: () => note(context, 'Coin conversion is not active.'), child: const Text('Convert')))),
    const SizedBox(height: 10),
    Card(child: ListTile(leading: const Icon(Icons.redeem, color: blue),
      title: const Text('Redeem preview'), subtitle: const Text('No real payout available'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RedeemPage())))),
    const SizedBox(height: 20),
    const Text('Recent transactions', style: TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 17)),
    const SizedBox(height: 8),
    const TransactionRow(icon: Icons.add_circle_outline, title: 'Sample task reward', subtitle: 'Today • Demo entry', amount: '+ 10 coins', positive: true),
    const TransactionRow(icon: Icons.card_giftcard, title: 'Daily bonus preview', subtitle: 'Today • Demo entry', amount: '+ 5 coins', positive: true),
    const TransactionRow(icon: Icons.info_outline, title: 'Redemption preview', subtitle: 'No payout created', amount: '—', positive: false),
  ]));
}

class TransactionRow extends StatelessWidget {
  final IconData icon; final String title, subtitle, amount; final bool positive;
  const TransactionRow({super.key, required this.icon, required this.title, required this.subtitle, required this.amount, required this.positive});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 8),
    child: Card(child: ListTile(
      leading: CircleAvatar(backgroundColor: pale, child: Icon(icon, color: blue)),
      title: Text(title, style: const TextStyle(color: navy, fontWeight: FontWeight.w700, fontSize: 13)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
      trailing: Text(amount, style: TextStyle(color: positive ? green : muted, fontWeight: FontWeight.w900, fontSize: 12)),
    )));
}

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Refer & Earn')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const SizedBox(height: 20), const Icon(Icons.card_giftcard, size: 84, color: blue),
      const SizedBox(height: 15), const Text('Invite friends', textAlign: TextAlign.center,
        style: TextStyle(color: navy, fontSize: 24, fontWeight: FontWeight.w900)),
      const SizedBox(height: 8), const Text('Share your demo referral code. Tracking will be added with backend setup.',
        textAlign: TextAlign.center, style: TextStyle(color: muted)),
      const SizedBox(height: 22),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: const [
        Text('Your demo referral code', style: TextStyle(color: muted)),
        SizedBox(height: 8), Text('PAISE123', style: TextStyle(color: navy, fontSize: 25, fontWeight: FontWeight.w900)),
      ]))),
      const SizedBox(height: 15), FilledButton.icon(onPressed: () => note(context, 'Invite sharing will be enabled later.'),
        icon: const Icon(Icons.share), label: const Text('Invite friends')),
      const SizedBox(height: 20), const Text('How it will work', style: TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 17)),
      const ListTile(leading: CircleAvatar(backgroundColor: pale, child: Text('1')), title: Text('Share your referral code')),
      const ListTile(leading: CircleAvatar(backgroundColor: pale, child: Text('2')), title: Text('Friend joins and completes eligible steps')),
      const ListTile(leading: CircleAvatar(backgroundColor: pale, child: Text('3')), title: Text('Server verifies eligibility')),
    ]));
}

class RedeemPage extends StatefulWidget {
  const RedeemPage({super.key});
  @override
  State<RedeemPage> createState() => _RedeemPageState();
}
class _RedeemPageState extends State<RedeemPage> {
  String choice = 'Gift card preview';
  final amount = TextEditingController(text: '50');
  @override
  void dispose() { amount.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Redeem Rewards')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Choose a preview option', style: TextStyle(color: navy, fontSize: 19, fontWeight: FontWeight.w900)),
      const SizedBox(height: 5), const Text('UI prototype only. No payment or payout is created.', style: TextStyle(color: muted, fontSize: 12)),
      const SizedBox(height: 14),
      ...['Gift card preview', 'UPI flow preview (disabled)', 'Bank transfer preview (disabled)'].map((v) => Card(child: RadioListTile<String>(
        value: v, groupValue: choice, onChanged: v.contains('disabled') ? null : (n) => setState(() => choice = n!),
        title: Text(v, style: const TextStyle(color: navy, fontSize: 13, fontWeight: FontWeight.w700)),
        secondary: const Icon(Icons.redeem, color: blue),
      ))),
      const SizedBox(height: 14),
      TextField(controller: amount, keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Sample amount', prefixText: '₹')),
      const SizedBox(height: 17),
      FilledButton(onPressed: () => note(context, 'Preview only. No redemption request or payment was created.'),
        child: const Text('Preview redemption')),
      const SizedBox(height: 10),
      const Text('No UPI ID, bank account or card details are collected.', style: TextStyle(color: muted, fontSize: 11)),
    ]));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final rows = const [
      ('Reward history', Icons.history), ('Redemption history', Icons.account_balance_wallet_outlined),
      ('Refer & Earn', Icons.people_outline), ('Help & Support', Icons.support_agent),
      ('About Paise Wala', Icons.info_outline), ('Settings', Icons.settings_outlined),
    ];
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(17, 18, 17, 22), children: [
      const Heading('Profile', 'Manage your Paise Wala preview'),
      const SizedBox(height: 18),
      const Card(child: ListTile(contentPadding: EdgeInsets.all(13),
        leading: CircleAvatar(backgroundColor: pale, child: Icon(Icons.person, color: blue, size: 30)),
        title: Text('Demo User', style: TextStyle(color: navy, fontWeight: FontWeight.w900)),
        subtitle: Text('demo@paisewala.app'), trailing: Icon(Icons.edit_outlined, color: blue))),
      const SizedBox(height: 12),
      ...rows.map((r) => Padding(padding: const EdgeInsets.only(bottom: 8),
        child: Card(child: ListTile(leading: Icon(r.$2, color: blue), title: Text(r.$1),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            if (r.$1 == 'Refer & Earn') {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferralPage()));
            } else { note(context, '${r.$1} will be connected later.'); }
          })))),
      OutlinedButton.icon(onPressed: () => note(context, 'Demo profile: no account signed in.'),
        icon: const Icon(Icons.logout), label: const Text('Sign out (demo)')),
    ]));
  }
}
