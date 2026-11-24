import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  /// 3. Fonction qui extrait les initiales d'un nom complet
  /// Ex: "Sara El Amrani" -> "SE", "Yassine Daoudi" -> "YD"
  String initiales(String nomComplet) {
    final parties = nomComplet.trim().split(RegExp(r'\s+'));
    if (parties.isEmpty || parties[0].isEmpty) return '';
    if (parties.length == 1) {
      return parties[0].substring(0, parties[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    // Première lettre du premier prénom + première lettre du dernier nom
    return '${parties.first[0]}${parties.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // 5 étudiants pour tester les initiales et les couleurs
    final List<String> etudiants = [
      'Sara El Amrani',
      'Mehdi Benjelloun',
      'Salma Alaoui',
      'Omar Tazi',
      'Kenza Chraibi',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Partie 2 – Widget CircleAvatar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1 & 2. Les variantes : Initiales, Réseau, Icône, et Image Locale (AssetImage)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1 & 2. Les 4 variantes d\'avatars',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Variante 1: Initiales
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              child: Text(
                                'AB',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text('Initiales', style: TextStyle(fontSize: 12)),
                          ],
                        ),

                        // Variante 2: Image Réseau (avec gestion d'erreur / fallback)
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
                              onBackgroundImageError: (exception, stackTrace) {
                                debugPrint('Erreur de chargement d\'image réseau : $exception');
                              },
                              // Child affiché en cas de fallback ou pendant le chargement
                              child: const Text('NR', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ),
                            const SizedBox(height: 6),
                            const Text('Réseau', style: TextStyle(fontSize: 12)),
                          ],
                        ),

                        // Variante 3: Icône
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.teal.shade100,
                              foregroundColor: Colors.teal.shade900,
                              child: const Icon(Icons.person, size: 32),
                            ),
                            const SizedBox(height: 6),
                            const Text('Icône', style: TextStyle(fontSize: 12)),
                          ],
                        ),

                        // Variante 4: Image locale AssetImage (ex. 2)
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.amber.shade100,
                              backgroundImage: const AssetImage('assets/images/profile.png'),
                              child: const Icon(Icons.person_pin, size: 32, color: Colors.orange),
                            ),
                            const SizedBox(height: 6),
                            const Text('AssetImage', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3 & 4. 5 Avatars générés avec initiales() et Colors.primaries
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3 & 4. Avatars dynamiques (initiales() + Colors.primaries)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Initiales calculées par fonction et couleurs piochées dans Colors.primaries',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: List.generate(etudiants.length, (index) {
                        final nom = etudiants[index];
                        final couleurFond = Colors.primaries[(index * 3) % Colors.primaries.length];
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: couleurFond,
                              foregroundColor: Colors.white,
                              child: Text(
                                initiales(nom),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              nom.split(' ').first,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 5 & 6. Avatar avec bordure (44/40) + Badge « En ligne » (Stack + Positioned)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5 & 6. Avatar avec bordure & Badge statut (Stack + Positioned)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Avatar avec bordure simple
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 44, // Rayon extérieur blanc (bordure)
                              backgroundColor: Colors.indigo,
                              child: CircleAvatar(
                                radius: 40, // Rayon intérieur
                                backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=33'),
                                child: const Text('MB'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Bordure simple (44/40)'),
                          ],
                        ),

                        // Avatar avec bordure + Badge statut vert "en ligne"
                        Column(
                          children: [
                            Stack(
                              children: [
                                // Avatar avec double cercle pour bordure
                                CircleAvatar(
                                  radius: 44,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  child: const CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
                                    child: Text('SA'),
                                  ),
                                ),
                                // Badge statut en bas à droite
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('Bordure + Badge « En ligne »'),
                          ],
                        ),
                      ],
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
