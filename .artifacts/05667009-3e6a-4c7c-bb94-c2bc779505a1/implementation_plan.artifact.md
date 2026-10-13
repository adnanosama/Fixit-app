# Implementation Plan - Separate Light Mode & Dark Mode into Modular Theme Directory

Organize the theme functionality into a dedicated `lib/theme/` directory with separated modules for Light Mode configuration, Dark Mode configuration, and Theme State/Controller management. This provides clean separation of concerns and simplifies overall integration.

## Proposed Architecture & Folder Structure

```
lib/
└── theme/
    ├── light_theme.dart      # Light Mode ThemeData configuration
    ├── dark_theme.dart       # Dark Mode ThemeData configuration
    ├── theme_controller.dart # ValueNotifier & Theme management helpers
    └── app_theme.dart        # Main export file & unified AppTheme access
```

---

## Proposed Changes

### Theme Module Creation (`lib/theme/`)

#### [NEW] [light_theme.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/theme/light_theme.dart)
- Define `lightThemeData` containing the light theme specifications (background `#A5B4CF`, white24 card color, light Material 3 styling, etc.).

#### [NEW] [dark_theme.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/theme/dark_theme.dart)
- Define `darkThemeData` containing the dark theme specifications (midnight background `#0A0A12`, slate card color `#161625`, neon cyan primary accent, dark Material 3 styling).

#### [NEW] [theme_controller.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/theme/theme_controller.dart)
- Expose `themeNotifier` (`ValueNotifier<ThemeMode>`).
- Add clean helper functions like `toggleTheme()`, `setThemeMode()`, and `isDarkMode` getter for simplified usage across UI widgets.

#### [NEW] [app_theme.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/theme/app_theme.dart)
- Central export file exporting `light_theme.dart`, `dark_theme.dart`, and `theme_controller.dart`.
- Define `AppTheme` class exposing static getters `lightTheme` and `darkTheme` for clean backward compatibility.

---

### App Refactoring & Integration

#### [MODIFY] [theme.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/app_config/theme.dart)
- Update `lib/app_config/theme.dart` to export `package:fixit/theme/app_theme.dart` to maintain full backward compatibility for any existing config references.

#### [MODIFY] [main.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/main.dart)
- Update import path to `package:fixit/theme/app_theme.dart`.

#### [MODIFY] [home_page.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/screens/home_page.dart)
- Update theme import to `package:fixit/theme/app_theme.dart` and switch theme toggle call to use the clean `themeNotifier` / `toggleTheme()` methods.

---

## Verification Plan

### Automated Verification
- Run `flutter analyze` to ensure zero static analysis warnings or errors.
- Run `flutter test` to ensure all widget tests continue to pass seamlessly.

### Manual Verification
- Verify Light Mode and Dark Mode rendering.
- Test the Dark Mode toggle in the navigation drawer to confirm state updates work cleanly.
