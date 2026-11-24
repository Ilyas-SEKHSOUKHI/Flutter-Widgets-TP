# TP Flutter – Widgets Icon, CircleAvatar, Card, ListTile

**Module :** Développement Mobile  
**Filière :** 2ACINFO – Université Mundiapolis  
**Enseignant :** Pr. Ayad  

---

## 📱 Présentation générale

Ce projet implémente l'ensemble des travaux pratiques portant sur quatre widgets fondamentaux de Flutter (Material 3) :
1. **Icon** : Pictogrammes vectoriels Material et Cupertino, dimensionnement, accessibilité.
2. **CircleAvatar** : Photos de profil réseau, locales (AssetImage), initiales calculées dynamiquement, bordures et badges de statut.
3. **Card** : Conteneurs surélevés, variantes Material 3 (`filled`, `outlined`), gestion du découpage avec `clipBehavior`, liste dynamique et interaction.
4. **ListTile** : Lignes standardisées selon les spécifications Material Design, gestion d'état (`SwitchListTile`, `CheckboxListTile`), sélection exclusive et dialogue de confirmation.
5. **Mini-projet de synthèse (Annuaire 2ACINFO)** : Application de gestion de contacts intégrant les 4 widgets, recherche en temps réel, favoris, suppression par glissement (`Dismissible`), et vue détaillée avec Hero animation.

---

## 📁 Architecture des fichiers

```text
tpwidgets/
├── assets/
│   └── images/
│       ├── profile.png           # Image locale pour CircleAvatar (AssetImage)
│       └── course.png            # Image locale pour les cartes
├── lib/
│   ├── main.dart                 # Point d'entrée, Menu général et switch Thème Clair/Sombre
│   └── pages/
│       ├── icon_page.dart        # Partie 1 : Widget Icon & Grille universitaire
│       ├── avatar_page.dart      # Partie 2 : CircleAvatar, initiales, bordures & badges
│       ├── card_page.dart        # Partie 3 : Card, variantes M3 & clipBehavior
│       ├── listtile_page.dart    # Partie 4 : ListTile, paramètres & dialogues
│       └── contacts_page.dart    # Partie 5 : Annuaire 2ACINFO (Synthèse & Détails)
├── pubspec.yaml                  # Déclaration des assets et dépendances (cupertino_icons)
└── README.md                     # Réponses aux questions de réflexion & documentation
```

---

## 🧠 Réponses aux Questions de Réflexion

### Question 1 (Partie 1 – Widget Icon)
> **Quelle différence entre `Icon` et `IconButton` ? Pourquoi `Icon` seul ne réagit-il pas au toucher ?**

* **Rôle d'`Icon` :** `Icon` est un widget purement graphique et passif (`LeafRenderObjectWidget`). Son rôle exclusif est de dessiner un glyphe vectoriel issu d'une police d'icônes (`IconData`) dans le canvas de rendu. Il ne dispose d'aucune sémantique de bouton ni de gestionnaire d'événements de pointeur (`PointerEvent`).
* **Rôle d'`IconButton` :** `IconButton` est un widget interactif et composite. Il encapsule un widget `Icon` dans un `InkResponse` / `InkWell`, fournit un callback `onPressed`, gère les états de survol/focus, produit l'effet d'ondulation Material (*ripple effect*), applique une zone tactile minimale recommandée par Material (48x48 dp pour l'accessibilité mobile) et gère le focus clavier.
* **Pourquoi `Icon` ne réagit pas seul :** Respect du principe de responsabilité unique (SRP). Pour rendre un `Icon` réactif, il faut l'encapsuler dans un `GestureDetector`, un `InkWell`, ou utiliser directement `IconButton`.

---

### Question 2 (Partie 2 – Widget CircleAvatar)
> **Que se passe-t-il si l'URL de l'image est invalide et qu'aucun `child` n'est fourni ? Comment prévoir un affichage de secours ?**

* **Comportement par défaut :** Si l'URL de l'image est invalide (erreur 404, absence de réseau, etc.) et qu'aucun `child` n'est spécifié, Flutter déclenche une exception asynchrone (`ImageProvider` throw) visible dans la console de débogage. À l'écran, le `CircleAvatar` affiche un disque vide de la couleur de `backgroundColor` (ou gris par défaut).
* **Comment prévoir un affichage de secours (fallback) :**
  1. **Fournir un `child` par défaut (ex. `Text` d'initiales ou `Icon(Icons.person)`) :** Tant que l'image réseau n'est pas chargée ou si elle échoue, le `child` reste visible au centre.
  2. **Intercepter l'erreur avec `onBackgroundImageError` :**
     ```dart
     CircleAvatar(
       radius: 30,
       backgroundImage: NetworkImage(url),
       onBackgroundImageError: (exception, stackTrace) {
         // Gestion de l'erreur ou mise à jour d'un booléen d'état
       },
       child: const Icon(Icons.person), // Affichage de secours
     )
     ```
  3. **Conditionner l'image de fond :** Vérifier au préalable si l'URL est non nulle et non vide (`photoUrl != null && photoUrl.isNotEmpty ? NetworkImage(...) : null`).

---

### Question 3 (Partie 3 – Widget Card)
> **Pourquoi place-t-on l'`InkWell` à l'intérieur de la `Card` plutôt qu'autour ?**

* **Propagation de l'effet Ripple (Ondulation visuelle) :** Dans Flutter, l'effet d'ondulation créé par `InkWell` est dessiné sur le widget ancêtre `Material` le plus proche. La `Card` fournit ce composant `Material`. En plaçant `InkWell` **à l'intérieur** du `Card`, l'ondulation se dessine directement à la surface de la carte sans masquer les ombres ni dépasser.
* **Respect des arrondis et `clipBehavior` :** Si `InkWell` entoure la `Card`, la zone de clic et l'effet de ripple forment un rectangle englobant brut qui déborde sur les coins arrondis et annule l'esthétique de la carte.
* **Intégrité de l'ombre portée (`elevation`) :** Placer un widget interactif autour d'une Card peut interférer avec le calcul de projection de l'ombre portée de la carte.

---

### Question 4 (Partie 4 – Widget ListTile)
> **Quels avantages apporte `ListTile` par rapport à un `Row` construit à la main ?**

1. **Standardisation Material Design :** `ListTile` applique strictement les métriques officielles de Material (hauteur standardisée de 56 dp pour une ligne, 72 dp pour deux lignes, alignements typographiques automatiques, paddings horizontaux de 16 dp).
2. **Gestion native des états interactifs :** Prise en charge intégrée de `selected`, `selectedColor`, `onTap`, `onLongPress`, `hoverColor` et `focusColor` sans code additionnel.
3. **Gestion automatique du layout complexe :** Positionnement automatique de `leading`, `title`, `subtitle`, `trailing`, avec support des textes multilignes grâce à `isThreeLine: true` sans risque d'overflow `RenderFlex` fréquent avec des `Row`.
4. **Accessibilité intégrée (`Semantics`) :** `ListTile` configure automatiquement les étiquettes et traits d'accessibilité pour les lecteurs d'écran (TalkBack sur Android, VoiceOver sur iOS).
5. **Composants spécialisés dérivés :** Permet une cohérence immédiate avec `SwitchListTile`, `CheckboxListTile`, et `RadioListTile`.

---

## 🚀 Fonctionnalités Bonus implémentées

- [x] **Barre de recherche interactive** : Filtrage en temps réel des étudiants par nom, prénom et email.
- [x] **Filtre rapide des favoris** : Bouton étoile dans l'AppBar permettant d'afficher uniquement les contacts favoris.
- [x] **Suppression par glissement (`Dismissible`)** : Avec icône corbeille, fond rouge et bouton **Annuler** (*Undo*) dans le SnackBar.
- [x] **Page de détails étudiée (`DetailEtudiantPage`)** : Navigation fluide avec `Hero` animation, grand CircleAvatar (rayon 60), actions rapides d'appel et de copie d'email.
- [x] **Support du Thème Sombre & Clair** : Bouton dans la barre de titre du menu principal basculant dynamiquement le mode de l'application.

---

## 🎤 Guide pour la Présentation Orale (Partie 6)

| Widget | Rôle & Définition | Propriétés clés | Cas d'usage réels | Bonnes pratiques |
|---|---|---|---|---|
| **Icon** | Dessine un pictogramme vectoriel issu d'une police de caractères (`IconData`). | `icon`, `size`, `color`, `semanticLabel`, `shadows` | Boutons d'action, indicateurs d'état, barres de navigation. | Toujours renseigner `semanticLabel` pour les lecteurs d'écran. |
| **CircleAvatar** | Affiche un cercle destiné aux photos de profil, initiales ou icônes. | `radius`, `backgroundColor`, `backgroundImage`, `child`, `onBackgroundImageError` | WhatsApp (photos de contacts), Gmail (initiales de profil), Slack. | Toujours fournir un `child` en fallback en cas d'échec de chargement réseau. |
| **Card** | Conteneur Material aux angles arrondis avec élévation et ombrage. | `elevation`, `shape`, `color`, `clipBehavior`, `margin` | Cartes produits (Amazon), flux d'actualités (LinkedIn), fiches de cours. | Utiliser `clipBehavior: Clip.antiAlias` lorsque la carte contient une image aux extrémités. |
| **ListTile** | Ligne de liste haut niveau avec emplacements prédéfinis (`leading`, `title`, etc.). | `leading`, `title`, `subtitle`, `trailing`, `isThreeLine`, `selected` | Menus de paramètres iOS/Android, historiques d'appels, explorateur de fichiers. | Préférer `ListTile` à un `Row` pour respecter les guidelines Material et l'accessibilité. |

---

## 🛠️ Lancement du projet

```bash
# Récupération des dépendances
flutter pub get

# Lancement sur votre périphérique connecté ou émulateur
flutter run
```
