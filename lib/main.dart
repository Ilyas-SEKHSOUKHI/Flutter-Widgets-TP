import 'package:flutter/material.dart';
import 'package:tpwidgets/pages/avatar_page.dart';
import 'package:tpwidgets/pages/card_page.dart';
import 'package:tpwidgets/pages/contacts_page.dart';
import 'package:tpwidgets/pages/icon_page.dart';
import 'package:tpwidgets/pages/listtile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Support du thème sombre (Bonus)
  ThemeMode _themeMode = ThemeMode.system;

  void _basculerTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP Widgets 2ACINFO',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: MenuPage(
        onToggleTheme: _basculerTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const MenuPage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP Widgets – Menu 2ACINFO'),
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Passer au mode clair' : 'Passer au mode sombre',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // En-tête informatif
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Université Mundiapolis · 2ACINFO',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'TP Flutter : Icon, CircleAvatar, Card, ListTile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Explorez chaque partie du TP ou lancez le projet de synthèse.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),

          // Partie 1 : Icon
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              child: Icon(Icons.palette),
            ),
            title: const Text('Partie 1 – Widget Icon'),
            subtitle: const Text('Tailles, CupertinoIcons, semanticLabel & grille'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IconPage()),
              );
            },
          ),
          const Divider(height: 1, indent: 72),

          // Partie 2 : CircleAvatar
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              child: Icon(Icons.account_circle),
            ),
            title: const Text('Partie 2 – Widget CircleAvatar'),
            subtitle: const Text('Initiales, réseau, AssetImage, bordure & badge'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AvatarPage()),
              );
            },
          ),
          const Divider(height: 1, indent: 72),

          // Partie 3 : Card
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              child: Icon(Icons.view_agenda),
            ),
            title: const Text('Partie 3 – Widget Card'),
            subtitle: const Text('Elevated, Filled, Outlined, clipBehavior & ListView'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardPage()),
              );
            },
          ),
          const Divider(height: 1, indent: 72),

          // Partie 4 : ListTile
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              child: Icon(Icons.list_alt),
            ),
            title: const Text('Partie 4 – Widget ListTile'),
            subtitle: const Text('Écran paramètres, Switch, Checkbox & AlertDialog'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListTilePage()),
              );
            },
          ),
          const Divider(height: 1, indent: 72),

          // Partie 5 : Synthèse Annuaire
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              child: Icon(Icons.contacts),
            ),
            title: const Text(
              'Partie 5 – Annuaire 2ACINFO',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Mini-projet combinant les 4 widgets + recherche & favoris'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
