# ThinkHub

Application de gestion d'idées et de projets pour équipes

## A propos

Projet d'apprentissage Flutter.
Objectif : Apprendre à structurer une application Flutter proprement.

## Stack

- Flutter 3.x
- Riverpod (state management)
- go_router (navigation)
- Supabase (backend)
- Plateformes : Android, iOS, Web

## Architecture

```
lib/
├── main.dart                        # Point d'entrée de l'app
│
├── core/                            # Infrastructure & configuration
│   ├── router/
│   │   └── app_router.dart          # Configuration des routes (GoRouter)
│   ├── navigation/
│   │   ├── navigation_items.dart    # Définition des items de navigation
│   │   └── navigation_menu.dart     # Barre de navigation du bas
│   └── theme/
│       └── app_theme.dart           # Thème complet (couleurs, typo, styles)
│
├── features/                        # Fonctionnalités (par module)
│   │
│   ├── dashboard/                   # Page d'accueil
│   │   ├── screens/
│   │   │   ├── dashboard_screen.dart   # Écran principal avec stats et actions rapides
│   │   │   └── login_screen.dart       # Écran de connexion
│   │   ├── models/
│   │   │   └── user.dart               # Modèle de données utilisateur
│   │   ├── providers/
│   │   │   └── auth_provider.dart      # Gestion d'état authentification
│   │   ├── repositories/
│   │   │   └── auth_repository.dart    # Accès aux données auth
│   │   ├── widgets/
│   │   │   └── stats_card.dart         # Carte de statistiques réutilisable
│   │   ├── auth_routes.dart            # Routes liées à l'auth
│   │   └── dashboard_routes.dart       # Routes du dashboard
│   │
│   ├── ideas/                       # Gestion des idées
│   │   ├── screens/
│   │   │   ├── ideas_screen.dart       # Liste des idées
│   │   │   └── idea_form_screen.dart   # Formulaire créer/modifier une idée
│   │   ├── models/
│   │   │   └── idea.dart               # Modèle Idea (titre, description, statut)
│   │   ├── providers/
│   │   │   └── ideas_provider.dart     # State management des idées (Riverpod)
│   │   ├── repositories/
│   │   │   └── ideas_repository.dart   # Accès aux données des idées
│   │   ├── widgets/
│   │   │   └── idea_card.dart          # Carte d'affichage d'une idée
│   │   └── ideas_routes.dart           # Routes du module ideas
│   │
│   ├── projects/                    # Gestion des projets
│   │   ├── screens/
│   │   │   ├── projects_screen.dart       # Liste des projets
│   │   │   └── project_detail_screen.dart # Détail d'un projet
│   │   ├── models/
│   │   │   └── project.dart               # Modèle Project (titre, dates, statut)
│   │   ├── providers/
│   │   │   └── projects_provider.dart     # State management des projets
│   │   ├── repositories/
│   │   │   └── projects_repository.dart   # Accès aux données des projets
│   │   ├── widgets/
│   │   │   └── project_card.dart          # Carte d'affichage d'un projet
│   │   └── projects_routes.dart           # Routes du module projects
│   │
│   └── auth/                        # Authentification (à implémenter)
│       └── .gitkeep
│
├── services/                        # Services externes
│   ├── api/
│   │   └── supabase_client.dart     # Client Supabase (connexion backend)
│   └── local/
│       └── storage_service.dart     # Stockage local / cache
│
├── widgets/                         # Composants UI réutilisables
│   ├── buttons/
│   │   └── primary_button.dart      # Bouton principal avec état loading
│   ├── cards/
│   │   └── custom_card.dart         # Carte conteneur réutilisable
│   └── inputs/
│       └── custom_text_field.dart   # Champ de texte personnalisé
│
└── utils/                           # Utilitaires partagés
    ├── constants.dart               # Constantes (statuts, limites, nom de l'app)
    ├── formatters.dart              # Formatage dates et nombres
    └── validators.dart              # Validation des entrées utilisateur
```

### Comment lire cette architecture

| Dossier | Rôle |
|---------|------|
| `core/` | Ce qui fait tourner l'app (routes, thème, navigation) |
| `features/` | Chaque fonctionnalité dans son propre dossier isolé |
| `services/` | Communication avec l'extérieur (API, stockage) |
| `widgets/` | Composants UI qu'on réutilise partout |
| `utils/` | Fonctions utilitaires partagées |

### Structure d'une feature

Chaque feature suit le même pattern :

```
feature/
├── screens/        # Les écrans (ce que l'utilisateur voit)
├── models/         # Les modèles de données (classes Dart)
├── providers/      # La logique métier et gestion d'état (Riverpod)
├── repositories/   # L'accès aux données (API, base locale)
├── widgets/        # Les widgets spécifiques à cette feature
└── *_routes.dart   # La définition des routes de cette feature
```

## Installation

```bash
git clone https://github.com/dasoah33/thinkhub.git
cd thinkhub
flutter pub get
flutter run
```

## Auteur

**Maixent Dassoah**

## License

MIT License - Projet éducatif open source
