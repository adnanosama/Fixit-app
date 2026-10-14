# Implementation Plan - Custom Component Search, Retailer Network & Firebase Auth

Implement consumer custom component search with live web device data and images, retailer location/pricing network for Pakistan, Firebase Authentication, separate sidebar drawer widget, and Material 3 UI optimizations.

## User Review Required

> [!IMPORTANT]
> **Firebase Setup Note**: Firebase packages (`firebase_core`, `firebase_auth`) will be added to `pubspec.yaml`. A modular `AuthService` will handle Firebase Authentication with graceful fallback to local authentication if `google-services.json` has not yet been placed in `android/app/`.

> [!NOTE]
> **Web Data Source**: Device autocomplete and images will be fetched live via `DeviceApiService` using HTTP web endpoints and fallback device catalog API (including major brands like Samsung, Apple, Xiaomi, Vivo, Infinix, etc., popular in Pakistan).

---

## Proposed Changes

### Data Models & Web Services

#### [NEW] [device_model.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/data_models/device_model.dart)
- `MobileDevice`: `id`, `brand`, `modelName`, `imageUrl`, `specs`.
- `RepairPart`: `id`, `partName`, `category`, `icon`.
- `RetailerListing`: `shopName`, `city`, `locationNotes`, `pricePkr`, `inStock`, `contactPhone`.

#### [NEW] [device_api_service.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/services/device_api_service.dart)
- Live HTTP fetching for mobile phone models and high-quality device images.
- Query mobile phone repair parts catalog and mock/live local retailer price listings with exact shop location notes.

#### [NEW] [auth_service.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/services/auth_service.dart)
- Firebase Auth integration (`signInWithEmailAndPassword`, `createUserWithEmailAndPassword`, `signOut`, `currentUser`).

---

### UI Components & Widgets

#### [NEW] [app_drawer.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/widgets/app_drawer.dart)
- Extract sidebar navigation drawer into a standalone widget.
- Include user profile header, Consumer/Retailer mode indicator, Navigation links (Custom Search, My Bookings, Create Account / Login, Settings), and Dark Mode switch.

#### [MODIFY] [service_card.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/widgets/service_card.dart)
- Remove price tags from home screen service cards as requested.

---

### Screens

#### [MODIFY] [home_page.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/screens/home_page.dart)
- Replace inline drawer with `AppDrawer`.
- Remove price display from service grid.
- Add custom `+` floating action button (FAB) / top bar action to trigger the Custom Component Search.

#### [NEW] [custom_component_search_page.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/screens/custom_component_search_page.dart)
- **Device Autocomplete Field**: Live typing search for real mobile devices.
- **Device Header Card**: Displays selected device image and title prominently.
- **Part Selector**: Live filtering for repair parts (OLED Screen, Battery, Camera, Charging Port, etc.).
- **Retailer Price & Location Cards**: Displays available prices in PKR and shop location details/notes added by registered local retailers.

#### [NEW] [login_page.dart](file:///C:/Users/adnan/AndroidStudioProjects/Fixit/lib/screens/login_page.dart)
- Material 3 Login & Sign-up screen integrated with `AuthService` (Firebase Auth).

---

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure zero static analysis errors/warnings.
- Run `flutter test` to verify all widget tests pass.

### Manual Verification
- Test `+` Custom Search FAB: Type phone model (e.g. "Samsung S23", "iPhone 15"), view live suggestion list and device header image.
- Select phone part and view retailer list with PKR pricing and shop location notes.
- Open Navigation Drawer from the 3 horizontal lines and verify dark mode toggle and navigation links work seamlessly.
- Test Login screen and authentication flow.
