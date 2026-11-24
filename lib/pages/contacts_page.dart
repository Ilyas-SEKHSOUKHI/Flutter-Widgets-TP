import 'package:flutter/material.dart';

/// Classe modèle représentant un étudiant
class Etudiant {
  final String id;
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final String filiere;
  final String? photoUrl;
  bool favori;

  Etudiant({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.telephone,
    this.filiere = '2ACINFO - Ingénierie Logicielle',
    this.photoUrl,
    this.favori = false,
  });

  /// Getter retournant les initiales (ex: Sara El Amrani -> SE)
  String get initiales =>
      '${prenom.isNotEmpty ? prenom[0] : ''}${nom.isNotEmpty ? nom[0] : ''}'.toUpperCase();
}

/// Écran principal de l'annuaire
class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // 8 étudiants fictifs (certains avec photo, d'autres sans pour tester les initiales)
  final List<Etudiant> _etudiants = [
    Etudiant(
      id: '1',
      prenom: 'Sara',
      nom: 'El Amrani',
      email: 'sara.elamrani@mundiapolis.ma',
      telephone: '+212 6 11 22 33 44',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
      favori: true,
    ),
    Etudiant(
      id: '2',
      prenom: 'Mehdi',
      nom: 'Benjelloun',
      email: 'mehdi.benjelloun@mundiapolis.ma',
      telephone: '+212 6 22 33 44 55',
      photoUrl: 'https://i.pravatar.cc/150?img=12',
      favori: false,
    ),
    Etudiant(
      id: '3',
      prenom: 'Salma',
      nom: 'Alaoui',
      email: 'salma.alaoui@mundiapolis.ma',
      telephone: '+212 6 33 44 55 66',
      photoUrl: null, // Test avec initiales
      favori: true,
    ),
    Etudiant(
      id: '4',
      prenom: 'Omar',
      nom: 'Tazi',
      email: 'omar.tazi@mundiapolis.ma',
      telephone: '+212 6 44 55 66 77',
      photoUrl: 'https://i.pravatar.cc/150?img=60',
      favori: false,
    ),
    Etudiant(
      id: '5',
      prenom: 'Kenza',
      nom: 'Chraibi',
      email: 'kenza.chraibi@mundiapolis.ma',
      telephone: '+212 6 55 66 77 88',
      photoUrl: null, // Test avec initiales
      favori: false,
    ),
    Etudiant(
      id: '6',
      prenom: 'Hamza',
      nom: 'Berrada',
      email: 'hamza.berrada@mundiapolis.ma',
      telephone: '+212 6 66 77 88 99',
      photoUrl: 'https://i.pravatar.cc/150?img=68',
      favori: true,
    ),
    Etudiant(
      id: '7',
      prenom: 'Nour',
      nom: 'Idrissi',
      email: 'nour.idrissi@mundiapolis.ma',
      telephone: '+212 6 77 88 99 00',
      photoUrl: null, // Test avec initiales
      favori: false,
    ),
    Etudiant(
      id: '8',
      prenom: 'Yassine',
      nom: 'Daoudi',
      email: 'yassine.daoudi@mundiapolis.ma',
      telephone: '+212 6 88 99 00 11',
      photoUrl: 'https://i.pravatar.cc/150?img=33',
      favori: false,
    ),
  ];

  // Filtre de recherche (Bonus)
  String _termeRecherche = '';
  bool _filtreFavorisSeulement = false;

  Color _obtenirCouleurAvatar(String initiales) {
    final code = initiales.codeUnits.fold(0, (prev, curr) => prev + curr);
    return Colors.primaries[code % Colors.primaries.length];
  }

  @override
  Widget build(BuildContext context) {
    // Calcul du nombre de favoris en temps réel
    final int nbFavoris = _etudiants.where((e) => e.favori).length;

    // Filtrage dynamique
    final listeFiltree = _etudiants.where((e) {
      final correspondRecherche = '${e.prenom} ${e.nom}'
              .toLowerCase()
              .contains(_termeRecherche.toLowerCase()) ||
          e.email.toLowerCase().contains(_termeRecherche.toLowerCase());
      final correspondFavoris = !_filtreFavorisSeulement || e.favori;
      return correspondRecherche && correspondFavoris;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Annuaire 2ACINFO ($nbFavoris ★)'),
        actions: [
          IconButton(
            tooltip: _filtreFavorisSeulement ? 'Voir tous les étudiants' : 'Voir les favoris seulement',
            icon: Icon(
              _filtreFavorisSeulement ? Icons.star : Icons.star_border,
              color: _filtreFavorisSeulement ? Colors.amber : null,
            ),
            onPressed: () {
              setState(() {
                _filtreFavorisSeulement = !_filtreFavorisSeulement;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Bonus : Barre de recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un étudiant par nom, prénom ou email...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _termeRecherche.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _termeRecherche = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (val) {
                setState(() {
                  _termeRecherche = val;
                });
              },
            ),
          ),

          // Message d'information
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${listeFiltree.length} étudiant(s) affiché(s)',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  'Glisser pour supprimer (Dismissible)',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          // Liste des étudiants
          Expanded(
            child: listeFiltree.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'Aucun étudiant trouvé',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: listeFiltree.length,
                    itemBuilder: (context, i) {
                      final e = listeFiltree[i];

                      // Bonus : Dismissible pour supprimer un étudiant avec confirmation / annulation
                      return Dismissible(
                        key: ValueKey(e.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red.shade600,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Supprimer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.delete, color: Colors.white),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          final indexSupprime = _etudiants.indexOf(e);
                          setState(() {
                            _etudiants.remove(e);
                          });

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${e.prenom} ${e.nom} supprimé(e)'),
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                label: 'Annuler',
                                onPressed: () {
                                  setState(() {
                                    _etudiants.insert(indexSupprime, e);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            // Leading : CircleAvatar photo ou initiales
                            leading: Hero(
                              tag: 'avatar-${e.id}',
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: _obtenirCouleurAvatar(e.initiales),
                                backgroundImage: (e.photoUrl != null && e.photoUrl!.isNotEmpty)
                                    ? NetworkImage(e.photoUrl!)
                                    : null,
                                child: (e.photoUrl == null || e.photoUrl!.isEmpty)
                                    ? Text(
                                        e.initiales,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : null,
                              ),
                            ),

                            // Title : prénom et nom
                            title: Text(
                              '${e.prenom} ${e.nom}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),

                            // Subtitle : email
                            subtitle: Text(e.email),

                            // Trailing : étoile cliquable pour basculer l'état favori
                            trailing: IconButton(
                              icon: Icon(
                                e.favori ? Icons.star : Icons.star_border,
                                color: e.favori ? Colors.amber : Colors.grey,
                              ),
                              tooltip: e.favori ? 'Retirer des favoris' : 'Ajouter aux favoris',
                              onPressed: () {
                                setState(() {
                                  e.favori = !e.favori;
                                });
                              },
                            ),

                            // Clic pour ouvrir la page de détail
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailEtudiantPage(
                                    etudiant: e,
                                    onFavoriChanged: (nouveauFavori) {
                                      setState(() {
                                        e.favori = nouveauFavori;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Page de détail d'un étudiant avec grand CircleAvatar (rayon 60) et ListTiles
class DetailEtudiantPage extends StatefulWidget {
  final Etudiant etudiant;
  final ValueChanged<bool> onFavoriChanged;

  const DetailEtudiantPage({
    super.key,
    required this.etudiant,
    required this.onFavoriChanged,
  });

  @override
  State<DetailEtudiantPage> createState() => _DetailEtudiantPageState();
}

class _DetailEtudiantPageState extends State<DetailEtudiantPage> {
  late bool _estFavori;

  @override
  void initState() {
    super.initState();
    _estFavori = widget.etudiant.favori;
  }

  Color _obtenirCouleurAvatar(String initiales) {
    final code = initiales.codeUnits.fold(0, (prev, curr) => prev + curr);
    return Colors.primaries[code % Colors.primaries.length];
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.etudiant;

    return Scaffold(
      appBar: AppBar(
        title: Text('${e.prenom} ${e.nom}'),
        actions: [
          IconButton(
            icon: Icon(
              _estFavori ? Icons.star : Icons.star_border,
              color: _estFavori ? Colors.amber : null,
            ),
            tooltip: _estFavori ? 'Retirer des favoris' : 'Marquer comme favori',
            onPressed: () {
              setState(() {
                _estFavori = !_estFavori;
              });
              widget.onFavoriChanged(_estFavori);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Grand CircleAvatar (rayon 60) avec bordure
            Center(
              child: Hero(
                tag: 'avatar-${e.id}',
                child: CircleAvatar(
                  radius: 64, // Bordure extérieure
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: CircleAvatar(
                    radius: 60, // Rayon 60 demandé
                    backgroundColor: _obtenirCouleurAvatar(e.initiales),
                    backgroundImage: (e.photoUrl != null && e.photoUrl!.isNotEmpty)
                        ? NetworkImage(e.photoUrl!)
                        : null,
                    child: (e.photoUrl == null || e.photoUrl!.isEmpty)
                        ? Text(
                            e.initiales,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Nom et prénom en grand
            Text(
              '${e.prenom} ${e.nom}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              e.filiere,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            // Carte regroupant les informations de contact avec ListTile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // ListTile Email
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.indigo),
                      title: const Text('Adresse email institutionnelle'),
                      subtitle: Text(e.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        tooltip: 'Copier l\'adresse',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email copié dans le presse-papier'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),

                    // ListTile Téléphone
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.green),
                      title: const Text('Numéro de téléphone'),
                      subtitle: Text(e.telephone),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, size: 20),
                        tooltip: 'Appeler',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Appel vers ${e.telephone}...'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),

                    // ListTile Filière
                    ListTile(
                      leading: const Icon(Icons.school, color: Colors.purple),
                      title: const Text('Filière / Niveau'),
                      subtitle: Text(e.filiere),
                      trailing: const Icon(Icons.verified, color: Colors.blue, size: 20),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
