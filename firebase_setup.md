# Configure Flutter Firebase Using CLI

The recommended modern way is using the official FlutterFire CLI.

This automatically generates the Firebase configuration for Android, iOS, web, macOS, etc.

---

# 1. Install Firebase CLI

## Install Node.js first (if not installed)

Verify:

```bash
node --version
npm --version
```

---

## Install Firebase CLI globally

```bash
npm install -g firebase-tools
```

Verify:

```bash
firebase --version
```

---

# 2. Login to Firebase

```bash
firebase login
```

This opens browser authentication.

---

# 3. Install FlutterFire CLI

Activate globally:

```bash
dart pub global activate flutterfire_cli
```

Add pub cache to PATH if needed:

### Linux/macOS

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

### zsh

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

Verify:

```bash
flutterfire --version
```

---

# 4. Configure Firebase in Flutter Project

Go inside project:

```bash
cd your_flutter_project
```

Run configuration:

```bash
flutterfire configure
```

This will:

* Detect Firebase projects
* Ask platform selections
* Generate `firebase_options.dart`
* Configure Android/iOS/Web automatically

---

# 5. Select Platforms

Typical selection:

```text
✔ android
✔ ios
✔ web
```

---

# 6. Generated Files

The CLI automatically creates:

## Android

```text
android/app/google-services.json
```

## iOS

```text
ios/Runner/GoogleService-Info.plist
```

## Flutter

```text
lib/firebase_options.dart
```

---

# 7. Install Firebase Packages

Example core package:

```bash
flutter pub add firebase_core
```

Additional packages:

```bash
flutter pub add firebase_auth
flutter pub add cloud_firestore
flutter pub add firebase_messaging
flutter pub add firebase_storage
flutter pub add firebase_crashlytics
```

---

# 8. Initialize Firebase

Inside `main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
```

---

# 9. Android Configuration

Inside:

```text
android/build.gradle
```

Ensure:

```gradle
classpath 'com.google.gms:google-services:4.4.1'
```

Inside:

```text
android/app/build.gradle
```

Add:

```gradle
apply plugin: 'com.google.gms.google-services'
```

---

# 10. iOS Configuration

Install pods:

```bash
cd ios
pod install
cd ..
```

---

# 11. Verify Firebase Works

Run app:

```bash
flutter run
```

Check logs for:

```text
Firebase initialized successfully
```

---

# 12. Reconfigure Firebase Later

If adding new platforms:

```bash
flutterfire configure
```

If switching projects:

```bash
flutterfire configure --project=<firebase-project-id>
```

---

# 13. Recommended for Team/Handover

Document these clearly:

* Firebase project name
* Firebase project ID
* Enabled Firebase services
* SHA-1/SHA-256 keys
* APNs configuration
* FCM setup
* Environment separation (dev/staging/prod)

Also transfer:

* Firebase console ownership
* Billing ownership
* Crashlytics access
* Cloud Messaging access

---

# Useful Commands

## List Firebase projects

```bash
firebase projects:list
```

## Login again

```bash
firebase login
```

## Logout

```bash
firebase logout
```

## Upgrade FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```
