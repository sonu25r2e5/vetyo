# Vetyo - Project Structure & Architecture Documentation

## Project Overview

**Vetyo** is a Flutter mobile application designed as a multi-platform agricultural and veterinary services platform. It enables users to connect with veterinarians, manage livestock/pet health cases, and access community features for agricultural support.

- **Language**: Dart (Flutter Framework)
- **Architecture Pattern**: Clean Architecture with BLoC (Business Logic Component)
- **State Management**: BLoC & Cubit
- **Supported Platforms**: Android, iOS, Linux, macOS, Web, Windows
- **Min SDK**: Dart 3.7.2+

---

## Directory Structure Overview

```
vetyo/
├── lib/                          # Main application source code
│   ├── main.dart                 # App entry point
│   ├── constants/                # Global constants and configuration
│   ├── core/                     # Core utilities and infrastructure
│   ├── features/                 # Feature modules (organized by domain)
│   └── generated/                # Auto-generated files (localization, etc.)
├── android/                      # Android native code & build configuration
├── ios/                          # iOS native code & build configuration
├── web/                          # Web platform files
├── linux/                        # Linux platform files
├── macos/                        # macOS platform files
├── windows/                      # Windows platform files
├── test/                         # Unit and widget tests
├── assets/                       # Static assets (images, fonts, localization)
├── pubspec.yaml                  # Flutter dependencies and project config
└── build/                        # Generated build artifacts
```

---

## Detailed Directory Breakdown

### 1. **lib/main.dart** - Application Entry Point

The main entry point that:
- Initializes SystemChrome settings (portrait orientation only)
- Sets up dependency injection via `setUpDi()`
- Initializes SharedPreferences
- Configures BLoC providers for global state management
- Sets up app theming, localization, and routing
- Enables debugging tools (Chucker for network monitoring)

**Key Providers Initialized:**
- `LanguageCubit` - Multi-language support (English, Japanese, Nepali)
- `SignupBloc` - User registration flow
- `LoginBloc` - User authentication
- `ResetPasswordBloc` - Password recovery
- `OtpVerificationBloc` - OTP verification during auth
- `ProfileBloc` - User profile management

### 2. **lib/constants/** - Global Constants

Centralized configuration and constants used throughout the app:

| File | Purpose |
|------|---------|
| `api_urls.dart` | API endpoints configuration |
| `app_colors.dart` | Color palette and theme colors |
| `app_fonts.dart` | Font family definitions |
| `app_icons.dart` | Icon asset paths |
| `app_images.dart` | Image asset paths |
| `app_padding.dart` | Standard padding/spacing values |
| `app_text_style.dart` | Pre-defined text styles |
| `font_size.dart` | Font size constants |
| `font_weight.dart` | Font weight constants |
| `key_string.dart` | String keys for storage/preferences |
| `res_string.dart` | UI text strings (should be in localization) |

### 3. **lib/core/** - Infrastructure & Utilities Layer

Contains shared services, configuration, and utilities:

#### **config/**
- `themes.dart` - Application theming (Material Design configuration)

#### **di/** - Dependency Injection
- `injector.dart` - Service locator setup using `get_it`
- Registers singleton and lazy-singleton services:
  - DioClient (HTTP client)
  - ImageUploadService
  - SignupService, LoginService, ProfileService, etc.

#### **routes/** - Navigation & Routing
- `route_handler.dart` - Route generation logic
- `route_helpers.dart` - Navigation helper functions
- `route_paths.dart` - Defined route paths for the app

#### **network/** - API Communication
- `dio_client.dart` - Configured Dio HTTP client with interceptors
- Handles API requests with base URL configuration

#### **language/** - Internationalization (i18n)
- `cubit/language_cubit.dart` - Language state management
- `l10n.dart` - Localization configuration
- Supports: English, Japanese, Nepali

#### **localization/** - Localized Strings
- Auto-generated localization files from ARB files

#### **services/** - Business Services
- `image_upload_service.dart` - Image upload functionality
- `splash/splash_screen.dart` - Initial splash screen

#### **navigation_service/**
- `navigation_service.dart` - Global navigation management using Navigator key

#### **common/** - Reusable Components
- `loading_overlay/` - Global loading indicator widget

#### **utils/** - Helper Functions
- `shared_pref.dart` - SharedPreferences wrapper for local storage
- Various utility functions and extensions

#### **extention/** - Dart Extensions
- Extension methods on built-in types (String, int, etc.)

#### **errors/** - Error Handling
- Exception models and error handling utilities

#### **helpers/** - Helper Classes
- General-purpose helper functions

#### **providers/** - Additional State Management
- Provider-based state management setup (if using provider pattern)

#### **typography/** - Text Styling
- Typography constants and text widget builders

---

## 4. **lib/features/** - Feature Modules

Features are organized by domain/business logic, following the **Clean Architecture** pattern:

### Feature Structure Pattern
Each feature typically contains:
```
feature_name/
├── bloc/              # BLoC for state management
├── screens/           # Full screen widgets
├── widgets/           # Reusable UI components
└── services/          # Feature-specific business logic
```

### Available Features:

#### **Authentication Features:**
- **login/** - User login screen and BLoC
- **sign_up/** - User registration and BLoC
- **otp_verification/** - OTP verification with timer Cubit
- **reset_password/** - Password reset functionality
- **onboarding/** - First-time user onboarding flow

#### **User Management:**
- **profile/** - User profile management with BLoC
- **notification/** - Push notifications and alerts

#### **Core Features:**
- **home/** - Main home/dashboard screen
- **appointments/** - Appointment booking and management
- **doctor_chat_case/** - Chat functionality for specific cases

#### **Domain-Specific Features:**

**Veterinary Services:**
- **vets/** - Veterinarian directory and services
  - `screens/` - Vet listing, details, search screens
  - `widgets/` - UI components like environment status, health cards
  - `services/` - Vet API communication

- **doctors/** - Doctor/specialist profiles
  - `screens/` - Doctor listing and details
  - `vet_details_screen.dart` - Detailed vet information
  - `doctor_case/` - Doctor-specific case management
  - `doctor_details_example.dart` - Example implementation

**Animal/Livestock Management:**
- **pet/** - Pet management (dogs, cats, etc.)
- **livestocks/** - Livestock management (cattle, goats, etc.)
- **poultry/** - Poultry farm management
- **vegetable_farming/** - Crop and vegetable farming

**Utility Features:**
- **category_profile/** - Category and profile information
- **community/** - Community discussion and support forum
- **aqua/** - Aquaculture/fish farming

---

## Architecture Pattern: Clean Architecture with BLoC

### Layer Separation:

```
┌─────────────────────────────────────┐
│     Presentation Layer (UI)         │
│  screens/widgets + BLoC/Cubit       │
├─────────────────────────────────────┤
│    Business Logic Layer (BLoC)      │
│  Event handling & State management  │
├─────────────────────────────────────┤
│     Repository/Service Layer        │
│  Data handling & API calls          │
├─────────────────────────────────────┤
│     Infrastructure Layer            │
│  Network, Storage, DI, Utils        │
└─────────────────────────────────────┘
```

### BLoC Pattern:
- **Events**: User actions (e.g., `LoginRequested`)
- **States**: UI states (e.g., `LoginLoading`, `LoginSuccess`)
- **BLoC**: Transforms events to states
- **Cubits**: Simplified state management for simple logic

Example: LoginBloc
```dart
// Event triggered by UI
loginBloc.add(LoginRequested(email, password));

// BLoC processes event
// Service makes API call
// BLoC emits state

// UI listens and responds
BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) {
      // Navigate to home
    }
  }
)
```

---

## Key Dependencies & Their Roles

| Dependency | Version | Purpose |
|------------|---------|---------|
| `flutter_bloc` | 9.1.1 | State management pattern |
| `bloc` | 9.2.0 | BLoC core library |
| `get_it` | 9.2.0 | Service locator (Dependency Injection) |
| `dio` | 5.9.0 | HTTP client for API calls |
| `logger` | 2.6.2 | Debug logging |
| `chucker_flutter` | 1.9.1 | Network request interceptor/debugger |
| `flutter_screenutil` | 5.9.3 | Responsive UI scaling |
| `equatable` | 2.0.8 | Value object equality |
| `dartz` | 0.10.1 | Either/Option types (functional programming) |
| `shared_preferences` | 2.3.5 | Local storage |
| `flutter_localizations` | - | Internationalization support |
| `intl` | 0.20.2 | i18n and formatting |
| `google_sign_in` | 7.2.0 | Google authentication |
| `flutter_facebook_auth` | 7.1.5 | Facebook authentication |
| `carousel_slider` | 5.0.0 | Image carousels |
| `file_picker` | 8.0.0 | File selection |
| `image_picker` | 1.2.1 | Image/photo selection |
| `pinput` | 6.0.1 | OTP input field |
| `device_preview` | 1.2.0 | Multi-device preview |
| `url_launcher` | 6.3.2 | Deep linking & URL handling |
| `flutter_native_splash` | 2.4.4 | App splash screen |

---

## How the Application Flows

### Startup Flow:
1. `main()` function executes
2. SystemChrome settings configured
3. SharedPreferences initialized
4. Dependency Injection setup via `setUpDi()`
5. BLoC providers initialized globally
6. `MyApp` widget built
7. `SplashScreen` shown initially
8. Routes directed by `RouteHandler`

### Authentication Flow:
1. User lands on onboarding/login
2. Enters credentials
3. BLoC emits `LoginLoading` state
4. LoginService calls API via DioClient
5. On success: `LoginSuccess` state → navigate to home
6. On failure: `LoginError` state → show error message

### Navigation:
- **Generated Routes**: `RouteHandler.generateRoute()` handles navigation
- **Named Routes**: Defined in `route_paths.dart`
- **NavigatorKey**: Global navigation via `NavigationService`

### State Management Flow:
```
User Action
    ↓
Widget triggers Event
    ↓
BLoC receives Event
    ↓
BLoC calls Service
    ↓
Service makes API call
    ↓
BLoC emits State
    ↓
BlocListener/BlocBuilder updates UI
```

---

## Localization (Multi-Language Support)

**Supported Languages:**
- English (en)
- Japanese (ja)
- Nepali (ne)

**Files:**
- `assets/l10n/en.arb` - English strings
- `assets/l10n/ja.arb` - Japanese strings
- `assets/l10n/ne.arb` - Nepali strings

**Configuration:** `l10n.yaml` defines localization setup

**Usage:** Language switched via `LanguageCubit` and stored in SharedPreferences

---

## Asset Organization

### **assets/fonts/**
- Custom font files for typography

### **assets/images/**
- App images and illustrations
- Organized by feature or category

### **assets/l10n/**
- Localization files (.arb format)
- Defines translatable strings

---

## Build Configuration

### **Android** (`android/`)
- Gradle configuration (`build.gradle.kts`)
- App-level build settings
- Gradle wrapper

### **iOS** (`ios/`)
- Xcode project (`Runner.xcodeproj`)
- CocoaPods workspace
- iOS-specific configuration

### **Web** (`web/`)
- HTML entry point (`index.html`)
- Web manifest
- App icons for web

### **Linux/macOS/Windows**
- Platform-specific desktop build configuration
- CMake files for native compilation

---

## Development Tools & Debugging

1. **Chucker**: Network request/response monitoring
   - Accessible via notification
   - View all HTTP calls made by the app

2. **Device Preview**: Test UI on multiple device sizes
   - Accessed via device icon in MaterialApp

3. **Logger**: Console logging with color-coded output

4. **Flutter DevTools**: Standard Flutter debugging tools

---

## Project Configuration Files

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Flutter dependencies and project metadata |
| `analysis_options.yaml` | Dart linter configuration |
| `l10n.yaml` | Localization/i18n configuration |
| `devtools_options.yaml` | DevTools settings |
| `firebase_setup.md` | Firebase integration guide |
| `IOS_BUILD_GUIDE.md` | iOS build instructions |
| `setup.md` | Development setup instructions |

---

## Best Practices Used in This Project

1. **Separation of Concerns**: Features are isolated modules
2. **Dependency Injection**: Services injected via GetIt
3. **State Management**: BLoC for complex logic, Cubit for simple state
4. **Error Handling**: Structured error responses via dartz
5. **Localization**: Multi-language support from ground up
6. **Responsive Design**: ScreenUtil for device-adaptive UI
7. **Code Organization**: Clear feature-based folder structure
8. **Network Debugging**: Chucker interceptor for API monitoring

---

## Getting Started for Development

1. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate Localization Files:**
   ```bash
   flutter gen-l10n
   ```

3. **Run the App:**
   ```bash
   flutter run
   ```

4. **Build for Production:**
   ```bash
   flutter build apk    # Android
   flutter build ipa    # iOS
   ```

---

## Summary

Vetyo is a well-structured Flutter application following Clean Architecture principles. It separates concerns into features, uses BLoC for state management, and maintains centralized configuration. The modular design allows easy feature addition and maintenance, while the infrastructure layer provides reusable services for networking, storage, and UI utilities.
