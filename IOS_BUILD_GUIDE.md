# iOS Build Instructions for Vetyo App

## Prerequisites (On macOS)

1. **Install Xcode** (from Mac App Store)
2. **Install Xcode Command Line Tools**:
   ```bash
   xcode-select --install
   ```

3. **Install CocoaPods**:
   ```bash
   sudo gem install cocoapods
   ```

4. **Setup iOS Simulator**:
   ```bash
   open -a Simulator
   ```

## Building for iOS

### 1. **For iOS Simulator**
```bash
# Navigate to project directory
cd /path/to/vetyo

# Get dependencies
flutter pub get

# Build and run on simulator
flutter run -d "iPhone 15 Pro Max (Simulator)"

# Or build without running
flutter build ios --simulator
```

### 2. **For Physical iOS Device**

#### **Development Build (Debug)**
```bash
# Connect iPhone via USB and trust computer
# Enable Developer Mode on iPhone (Settings > Privacy & Security > Developer Mode)

# Check connected devices
flutter devices

# Run on device
flutter run -d "Your iPhone Name"
```

#### **Release Build (Production)**
```bash
# Build release IPA
flutter build ios --release

# Build with specific bundle ID
flutter build ios --release --bundle-id com.vetyo.app
```

### 3. **For App Store Distribution**

#### **Setup Code Signing**
1. **Apple Developer Account** (Required)
   - Sign up at https://developer.apple.com
   - Cost: $99/year

2. **Create App ID**
   - Bundle ID: `com.vetyo.app`
   - App Name: "Vetyo"

3. **Generate Certificates**
   - Development Certificate
   - Distribution Certificate

4. **Create Provisioning Profiles**
   - Development Profile
   - App Store Distribution Profile

#### **Build for App Store**
```bash
# Archive build
flutter build ios --release

# Open in Xcode for upload
open ios/Runner.xcworkspace

# In Xcode:
# Product → Archive
# Upload to App Store Connect
```

## Configuration Files

### **Update Bundle ID**
Edit `ios/Runner.xcodeproj/project.pbxproj`:
```
PRODUCT_BUNDLE_IDENTIFIER = com.vetyo.app
```

### **Update Display Name**
Edit `ios/Runner/Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>Vetyo</string>
```

### **Add Permissions (if needed)**
Add to `ios/Runner/Info.plist`:
```xml
<!-- Camera Permission -->
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos of pets</string>

<!-- Photo Library Permission -->
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select pet images</string>

<!-- Location Permission -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to find nearby veterinarians</string>
```

## Troubleshooting

### **Common Issues**

1. **CocoaPods Issues**:
   ```bash
   cd ios
   pod deintegrate
   pod install
   ```

2. **Build Errors**:
   ```bash
   flutter clean
   flutter pub get
   cd ios && pod install
   ```

3. **Signing Issues**:
   - Check certificate validity
   - Update provisioning profiles
   - Verify bundle ID matches

### **Performance Optimization**

1. **Reduce App Size**:
   ```bash
   flutter build ios --split-per-abi
   ```

2. **Enable Bitcode** (if needed):
   In Xcode → Build Settings → Enable Bitcode: Yes

## Testing

### **Device Testing**
```bash
# Install on connected device
flutter install

# Run tests
flutter test
```

### **TestFlight Distribution**
1. Archive in Xcode
2. Upload to App Store Connect
3. Add testers in TestFlight
4. Send invitations

## Deployment Checklist

- [ ] App icons (all sizes)
- [ ] Launch screens
- [ ] Bundle ID configured
- [ ] Signing certificates
- [ ] Provisioning profiles
- [ ] App Store metadata
- [ ] Privacy policy (if collecting data)
- [ ] Terms of service

## Useful Commands

```bash
# Check iOS setup
flutter doctor

# List iOS simulators
flutter emulators

# Clean project
flutter clean

# Update dependencies
flutter pub upgrade

# Analyze code
flutter analyze
```