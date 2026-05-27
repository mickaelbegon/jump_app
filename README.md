# S2M Jump App

S2M Jump App est un outil pédagogique qui permet d'explorer l'effet de
paramètres biomécaniques sur la performance d'un saut aérien. L'application
présente les phases du saut et met à jour les résultats de translation et de
rotation lorsque les paramètres sont modifiés.

## Fonctionnalités

- visualisation des phases de propulsion, de vol et d'atterrissage;
- comparaison des paramètres de translation et de rotation;
- calcul de la vitesse de décollage, de la hauteur maximale, du temps de vol
  et de la rotation;
- ajustement des paramètres par curseurs ou par saisie numérique.

## Modifier Une Valeur

Les valeurs visibles et les valeurs utilisées par les calculs ont la même
précision :

- les temps affichés en `ms` sont calculés au milliseconde près;
- les valeurs affichées avec deux décimales sont calculées avec ces deux
  décimales;
- `Fmax` est exprimée en poids corporel (`BW`) en fonction de la masse du sujet.

Pour entrer une valeur précise, appuyer sur le libellé d'un paramètre, par
exemple `T : 300 ms` ou `omega0 : 1.50 rev/s`. Une fenêtre permet de saisir
une valeur comprise dans l'intervalle autorisé. Le séparateur décimal `,` ou
`.` est accepté.

Maintenir l'appui sur un paramètre éditable pour afficher son explication.

## Prérequis

- Flutter `3.44.0` ou une version compatible récente;
- Dart `^3.10.0` (inclus avec Flutter);
- pour iOS/macOS : Xcode et CocoaPods;
- pour Android : un SDK Android compatible avec la version Flutter installée.

## Développement

Installer les dépendances :

```bash
flutter pub get
```

Lancer l'application :

```bash
flutter run
```

Vérifier le code et exécuter les tests :

```bash
flutter analyze
flutter test
```

Les tests couvrent notamment :

- l'arrondi et les bornes des valeurs affichées;
- la cohérence des unités utilisées pour les calculs biomécaniques;
- l'entrée numérique, y compris la virgule décimale et les valeurs hors plage.

## Publication

### Android

Pour générer un Android App Bundle :

```bash
flutter build appbundle
```

La signature nécessite un fichier `android/key.properties` contenant :

```properties
storeFile=...
storePassword=...
keyAlias=s2mjumpapp
keyPassword=...
```

Le fichier référencé par `storeFile` doit être obtenu auprès d'un membre de
l'équipe.

### iOS

Pour préparer un fichier IPA :

```bash
flutter build ipa
```

La distribution finale se poursuit dans Xcode avec un certificat de
distribution et un profil Apple valides, puis avec Transporter pour envoyer
le build à App Store Connect.

## Contact

Pour communiquer avec l'équipe : `s2mlab@gmail.com`.
