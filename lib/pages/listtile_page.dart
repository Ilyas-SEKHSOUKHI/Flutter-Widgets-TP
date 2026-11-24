import 'package:flutter/material.dart';

class ListTilePage extends StatefulWidget {
  const ListTilePage({super.key});

  @override
  State<ListTilePage> createState() => _ListTilePageState();
}

class _ListTilePageState extends State<ListTilePage> {
  // 5. Gestion de la sélection (un seul index sélectionné à la fois)
  int? _selectedIndex = 0;

  // 3. États pour SwitchListTile et CheckboxListTile
  bool _notificationsActives = true;
  bool _synchronisationAuto = false;
  bool _modeSombre = false;

  void _confirmerDeconnexion() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),
          title: const Text('Confirmer la déconnexion'),
          content: const Text(
            'Êtes-vous certain de vouloir vous déconnecter de l\'application Mundiapolis ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Annuler'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session fermée avec succès.'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Déconnexion'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partie 4 – Widget ListTile'),
      ),
      body: ListView(
        children: [
          // En-tête de section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Préférences générales',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          // 3. SwitchListTile fonctionnel
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active),
            title: const Text('Notifications push'),
            subtitle: const Text('Recevoir les alertes d\'emploi du temps'),
            value: _notificationsActives,
            onChanged: (val) {
              setState(() {
                _notificationsActives = val;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // 3. CheckboxListTile fonctionnel
          CheckboxListTile(
            secondary: const Icon(Icons.sync),
            title: const Text('Synchronisation en arrière-plan'),
            subtitle: const Text('Mettre à jour les données hors-ligne'),
            value: _synchronisationAuto,
            onChanged: (val) {
              setState(() {
                _synchronisationAuto = val ?? false;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Mode sombre'),
            subtitle: const Text('Adapter le thème pour la nuit'),
            value: _modeSombre,
            onChanged: (val) {
              setState(() {
                _modeSombre = val;
              });
            },
          ),

          // En-tête des paramètres du compte
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Paramètres du compte (Sélection exclusive & isThreeLine)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          // 1 & 5. Ligne 1 : Compte
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Compte étudiant'),
            subtitle: const Text('Informations personnelles et identifiant Mundiapolis'),
            trailing: const Icon(Icons.chevron_right),
            selected: _selectedIndex == 0,
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // 1 & 5. Ligne 2 : Langue
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue & Région'),
            subtitle: const Text('Français (Maroc)'),
            trailing: const Icon(Icons.chevron_right),
            selected: _selectedIndex == 1,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // 1, 4 & 5. Ligne 3 : Confidentialité avec isThreeLine: true et long sous-titre
          ListTile(
            isThreeLine: true,
            leading: const Icon(Icons.security),
            title: const Text('Confidentialité & Données'),
            subtitle: const Text(
              'Gérez le consentement de vos données personnelles, l\'historique de vos sessions '
              'et l\'accès des services tiers autorisés par l\'université.',
            ),
            trailing: const Icon(Icons.chevron_right),
            selected: _selectedIndex == 2,
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // 1 & 5. Ligne 4 : Aide & Support
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Aide & Support'),
            subtitle: const Text('FAQ, guides d\'utilisation et contact DSI'),
            trailing: const Icon(Icons.chevron_right),
            selected: _selectedIndex == 3,
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // 1 & 5. Ligne 5 : À propos
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('À propos de l\'application'),
            subtitle: const Text('Version 2.4.0 · 2ACINFO'),
            trailing: const Icon(Icons.chevron_right),
            selected: _selectedIndex == 4,
            onTap: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // 1 & 6. Ligne 6 : Déconnexion (texte et icône en rouge + confirmation AlertDialog)
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Déconnexion',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'Fermer la session actuelle sur cet appareil',
              style: TextStyle(color: Colors.redAccent),
            ),
            trailing: const Icon(Icons.exit_to_app, color: Colors.red),
            onTap: _confirmerDeconnexion,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
