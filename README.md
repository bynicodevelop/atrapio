# Installation

```
git clone git@github.com:bynicodevelop/atrapio.git
```

# IOS Configuration

Intégré le fichier de configuration fourni par firebase dans le cadre de la création d'une nouvelle application dans la console Firebase.

Place le ficher :

```
ios > Runner > GoogleService-Info.plist
```

# Android Configuration

Intégré le fichier de configuration fourni par firebase dans le cadre de la création d'une nouvelle application dans la console Firebase.

Place le ficher :

```
android > app > google-services.json
```

# Web Configuration

Intégré les données de configuration fourni par firebase dans le cadre de la création d'une nouvelle application dans la console Firebase.

Créez un fichier `app.js` dans

```
web > scripts > app.js
```

Et ajoutez les données de configuration donné par Firebase :

```
var firebaseConfig = {
  apiKey: "XXX",
  authDomain: "XXX.firebaseapp.com",
  projectId: "XXX",
  storageBucket: "XXX.appspot.com",
  messagingSenderId: "XXX",
  appId: "X",
};

firebase.initializeApp(firebaseConfig);

firebase.firestore().useEmulator("localhost", 8080); // Juste pour le développement
firebase.functions().useEmulator("localhost", 5001); // Juste pour le développement
firebase.auth().useEmulator("http://localhost:9099"); // Juste pour le développement
```