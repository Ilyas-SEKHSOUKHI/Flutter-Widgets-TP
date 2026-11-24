import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des 8 services universitaires
    final List<Map<String, dynamic>> services = [
      {
        'icon': Icons.calendar_month,
        'label': 'Emploi du temps',
        'semanticLabel': 'Accéder à l\'emploi du temps',
        'isCupertino': false,
      },
      {
        'icon': Icons.grade,
        'label': 'Notes',
        'semanticLabel': 'Consulter les relevés de notes',
        'isCupertino': false,
      },
      {
        'icon': CupertinoIcons.book_fill, // Utilisation de CupertinoIcons
        'label': 'Bibliothèque',
        'semanticLabel': 'Catalogue de la bibliothèque universitaire',
        'isCupertino': true,
      },
      {
        'icon': CupertinoIcons.chat_bubble_2_fill, // CupertinoIcons
        'label': 'Messagerie',
        'semanticLabel': 'Boîte de messagerie étudiante',
        'isCupertino': true,
      },
      {
        'icon': Icons.restaurant,
        'label': 'Restaurant',
        'semanticLabel': 'Menu du restaurant universitaire',
        'isCupertino': false,
      },
      {
        'icon': Icons.sports_soccer,
        'label': 'Activités sportives',
        'semanticLabel': 'Inscriptions et activités sportives',
        'isCupertino': false,
      },
      {
        'icon': Icons.newspaper,
        'label': 'Actualités',
        'semanticLabel': 'Actualités et événements du campus',
        'isCupertino': false,
      },
      {
        'icon': Icons.account_balance,
        'label': 'Administration',
        'semanticLabel': 'Services administratifs et scolarité',
        'isCupertino': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Partie 1 – Widget Icon'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ligne de 3 icônes de tailles 24, 40 et 64
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Tailles d\'icônes (24, 40, 64)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.home, size: 24, color: Colors.indigo, semanticLabel: 'Accueil 24px'),
                            SizedBox(height: 4),
                            Text('24 px'),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.favorite, size: 40, color: Colors.red, semanticLabel: 'Favori 40px'),
                            SizedBox(height: 4),
                            Text('40 px'),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.school, size: 64, color: Colors.green, semanticLabel: 'École 64px'),
                            SizedBox(height: 4),
                            Text('64 px'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 5. Icône cliquable avec IconButton + SnackBar
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 36,
                      color: Colors.amber.shade800,
                      icon: const Icon(Icons.notifications_active),
                      tooltip: 'Notifications',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Icône cliquée : Vous avez 3 nouvelles notifications !'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Cliquez sur la cloche pour déclencher un SnackBar (IconButton)',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 2, 3, 4. Grille de 8 icônes (Services universitaires) avec semanticLabel et CupertinoIcons
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2. Grille des services universitaires (8 icônes)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Comprend des icônes Material, CupertinoIcons (import package:flutter/cupertino.dart), '
                      'et un semanticLabel pour l\'accessibilité.',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Service sélectionné : ${service['label']}'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  service['icon'] as IconData,
                                  size: 28,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  semanticLabel: service['semanticLabel'] as String,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                service['label'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
