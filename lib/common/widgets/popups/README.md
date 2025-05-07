# Kids Learning App - Custom Popup Dialog Implementation

## Overview

This document outlines the implementation of a reusable popup dialog component for the Kids Learning App. The popup is designed to be flexible and customizable, supporting various use cases such as logout confirmation, alerts, and action confirmations.

## Components Created

1. **CustomPopupDialog**: A reusable widget that displays a customizable popup dialog with:
   - Customizable title and content
   - Primary and optional secondary buttons
   - Optional icon
   - Customizable colors for buttons and icons

2. **PopupHelper**: A utility class that provides methods to easily show the popup dialog from anywhere in the app, including a predefined method for logout confirmation.

## File Structure
lib/
├── common/
│   └── widgets/
│       ├── buttons/
│       ├── custom_shapes/
│       ├── list_tiles/
│       ├── loaders/
│       ├── text_fields/
│       └── popups/                      # New directory
│           ├── custom_popup_dialog.dart # New file
│           └── popup_helper.dart        # New file
└── features/
└── personalization/
└── screens/
└── profile/
└── profile_screen.dart  # Modified file
## Changes Made

### New Files Created

#### 1. `lib/common/widgets/popups/custom_popup_dialog.dart`

Created a new widget that implements a customizable popup dialog with the following features:
- Customizable title and content
- Primary and optional secondary buttons
- Optional icon
- Follows the app's design system with rounded corners and consistent spacing
- Supports both single and dual button layouts

#### 2. `lib/common/widgets/popups/popup_helper.dart`

Created a utility class that provides:
- A generic method to show the custom popup dialog with all customization options
- A specialized method for logout confirmation with preset styling
- Helper functions to manage dialog state and navigation

### Modified Files

#### 1. `lib/features/personalization/screens/profile/profile_screen.dart`

Modified the profile screen to use the new popup dialog for logout confirmation:
- Updated the logout icon to show the confirmation popup when clicked
- Added logic to handle the logout action when confirmed

## Implementation Details

### CustomPopupDialog

The `CustomPopupDialog` widget is implemented with the following parameters:
- `title`: String - The popup dialog title
- `content`: String - The main content/message of the popup
- `primaryButtonText`: String - Text for the primary action button
- `primaryButtonColor`: Color - Color for the primary button (defaults to primary color)
- `secondaryButtonText`: String? - Optional text for the secondary button
- `secondaryButtonColor`: Color - Color for the secondary button (defaults to white)
- `onPrimaryButtonPressed`: VoidCallback - Callback function when primary button is pressed
- `onSecondaryButtonPressed`: VoidCallback? - Callback function when secondary button is pressed
- `icon`: IconData? - Optional icon to display above the title
- `iconColor`: Color - Color for the icon

The widget uses the app's design system with consistent spacing (AppSizes), rounded corners, and follows the app's color scheme (AppColors).

### PopupHelper

The `PopupHelper` class provides two main methods:
1. `showCustomPopup()`: A generic method to show a fully customizable popup
2. `showLogoutConfirmation()`: A specialized method for logout confirmation with preset styling

## Usage Examples

### Basic Usage

```dart
PopupHelper.showCustomPopup(
  context: context,
  title: 'Titre du popup',
  content: 'Contenu du message à afficher',
  primaryButtonText: 'Confirmer',
  secondaryButtonText: 'Annuler',
  onPrimaryButtonPressed: () {
    // Handle confirmation
    Navigator.of(context).pop();
  },
  icon: Icons.info_outline,
);  
```
Logout confirmation example:

```dart
PopupHelper.showLogoutConfirmation(
  context: context,
  onConfirm: () {
    // Handle logout logic
    Navigator.of(context).pop();
  },
);
```