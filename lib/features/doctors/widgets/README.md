# Doctor Profile Screen - Reusable Components

This implementation provides a complete doctor profile screen matching the Figma design with several reusable components.

## Main Screen
- `DoctorProfileScreen` - Complete profile screen with all sections

## Reusable Components Created

### 1. DoctorProfileAvatar
**File**: `lib/features/doctors/widgets/doctor_profile_avatar.dart`
- Profile avatar with online status indicator
- Supports both network and asset images
- Customizable size and tap functionality

### 2. DoctorProfileInfo
**File**: `lib/features/doctors/widgets/doctor_profile_avatar.dart`
- Doctor name and specialty display
- Consistent text styling
- Reusable across different screens

### 3. CustomToggleSwitch
**File**: `lib/features/doctors/widgets/custom_toggle_switch.dart`
- Animated toggle switch
- Customizable colors and size
- Matches Figma design exactly

### 4. ProfileMenuItem
**File**: `lib/features/doctors/widgets/profile_menu_item.dart`
- Menu items with icon, title, and optional arrow
- Consistent with existing CustomListTile
- Customizable colors

### 5. ScheduleCard
**File**: `lib/features/doctors/widgets/schedule_card.dart`
- Schedule information card
- Matches the blue border design from Figma
- Tap functionality for navigation

## Design System Integration

- Uses existing `BasePage` for consistent app structure
- Integrates with app's color palette (`ColorPalete`)
- Uses app fonts (`AppFonts.satoshi`)
- Responsive design with `flutter_screenutil`
- Follows existing component patterns

## Key Features

1. **Responsive Design**: All components use `flutter_screenutil` for proper scaling
2. **Theme Integration**: Uses existing app colors and design tokens
3. **Reusability**: Components can be used across different screens
4. **Accessibility**: Proper tap targets and visual feedback
5. **Navigation Ready**: All menu items have onTap callbacks for navigation

## Usage Example

```dart
// Profile Avatar
DoctorProfileAvatar(
  imageUrl: AppImages.avatarImage,
  showOnlineStatus: true,
  size: 92.w,
)

// Menu Item
ProfileMenuItem(
  icon: Icons.person_outline,
  title: 'Personal information',
  onTap: () {
    // Navigate to screen
  },
)

// Toggle Switch
CustomToggleSwitch(
  value: isAvailable,
  onChanged: (value) {
    setState(() {
      isAvailable = value;
    });
  },
)
```