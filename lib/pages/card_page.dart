import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // Toggle interactif pour tester l'effet de clipBehavior (Question 3)
  bool _enableAntiAlias = true;

  // 4. Liste de 4 cours fictifs
  final List<Map<String, String>> coursList = [
    {
      'titre': 'Développement Mobile Flutter',
      'code': '2ACINFO-DEV301',
      'description': 'Maîtrisez les widgets Material 3, l\'architecture stateful et la création d\'applications cross-platform.',
      'image': 'https://images.unsplash.com/photo-1551650975-87deedd944c3?w=500&auto=format&fit=crop&q=60',
    },
    {
      'titre': 'Architectures Cloud & DevOps',
      'code': '2ACINFO-CLD302',
      'description': 'Déploiement continu, conteneurisation Docker/Kubernetes et gestion d\'infrastructures scalables.',
      'image': 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500&auto=format&fit=crop&q=60',
    },
    {
      'titre': 'Intelligence Artificielle & Data',
      'code': '2ACINFO-IA303',
      'description': 'Fondements du Machine Learning, réseaux de neurones profonds et analyse prédictive de données.',
      'image': 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=500&auto=format&fit=crop&q=60',
    },
    {
      'titre': 'Cybersécurité des Réseaux',
      'code': '2ACINFO-SEC304',
      'description': 'Cryptographie moderne, audit de sécurité logicielle et protection avancée des systèmes.',
      'image': 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=500&auto=format&fit=crop&q=60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partie 3 – Widget Card'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Comparaison des 3 types de Card en Material 3
              Text(
                '1. Les 3 variantes de Card Material 3',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // Card standard (élévation 4)
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Icon(Icons.layers, color: Colors.indigo),
                            SizedBox(height: 6),
                            Text('Elevated (4)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text('Ombre portée', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Card.filled
                  Expanded(
                    child: Card.filled(
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Icon(Icons.format_paint, color: Colors.deepPurple),
                            SizedBox(height: 6),
                            Text('Filled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text('Fond teinté', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Card.outlined
                  Expanded(
                    child: Card.outlined(
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Icon(Icons.check_box_outline_blank, color: Colors.teal),
                            SizedBox(height: 6),
                            Text('Outlined', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text('Bordure fine', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 2 & 3. Carte modèle avec Toggle ClipAntiAlias
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2 & 3. Démonstration clipBehavior',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        _enableAntiAlias ? 'Clip.antiAlias' : 'Clip.none',
                        style: TextStyle(
                          fontSize: 12,
                          color: _enableAntiAlias ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: _enableAntiAlias,
                        onChanged: (val) {
                          setState(() {
                            _enableAntiAlias = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                _enableAntiAlias
                    ? '✓ Avec Clip.antiAlias : les coins de l\'image sont découpés selon l\'arrondi de la carte.'
                    : '✗ Sans Clip (Clip.none) : l\'image rectangulaire déborde sur les coins arrondis.',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // 4 & 5. Liste de 4 cartes de cours générées avec ListView.builder
              Text(
                '4 & 5. Liste de 4 cours (ListView.builder & InkWell cliquable)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: coursList.length,
                itemBuilder: (context, index) {
                  final cours = coursList[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: _enableAntiAlias ? Clip.antiAlias : Clip.none,
                    child: InkWell(
                      // 5. Clic sur la carte avec SnackBar
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Cours sélectionné : ${cours['titre']}'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 2. Image en haut (hauteur 150, fit: BoxFit.cover)
                          Image.network(
                            cours['image']!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
                                color: Colors.indigo.shade100,
                                child: Center(
                                  child: Icon(Icons.school, size: 50, color: Colors.indigo.shade400),
                                ),
                              );
                            },
                          ),

                          // Contenu texte et actions
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        cours['titre']!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      label: Text(
                                        cours['code']!,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cours['description']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // 2. Rangée de deux boutons : TextButton « Détails », FilledButton « S'inscrire »
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Détails du module : ${cours['titre']}'),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      child: const Text('Détails'),
                                    ),
                                    const SizedBox(width: 8),
                                    FilledButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Inscription confirmée pour ${cours['titre']} !'),
                                            backgroundColor: Colors.green.shade700,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      child: const Text('S\'inscrire'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
