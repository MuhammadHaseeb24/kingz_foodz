# King's Foodz — Customer App (UI Prototype)

A complete Flutter UI for the King's Foodz customer app, built from the
concept document. This is a **UI-only prototype**: login/signup are
hardcoded (no Firebase yet), and restaurant/menu data is mock data in
`lib/data/mock_data.dart`. It's structured so wiring in Firebase later
is a matter of swapping the data layer and `AuthProvider`.

## What's included
- Splash → Onboarding → Login/Signup (hardcoded auth)
- Home (nearby restaurants, categories, AI banner, search)
- Restaurant detail + menu + item customization (add-ons, qty, notes)
- Cart, Checkout (address / payment method / coupon), Order success
- Order tracking (status stepper) and Order history
- AI Food Assistant (chat UI with mock natural-language matching)
- Search with sort/filter, Favorites, Notifications
- Profile + Edit Profile, Logout

**Demo login:** `demo@kingsfoodz.com` / `123456` — any signup form also logs
you straight in (no backend).

## Run it (Android)

You need Flutter SDK + Android Studio (or just the Android SDK/platform
tools) installed. This project ships only `pubspec.yaml` and `lib/` — the
`android/` platform folder is generated fresh so it always matches your
installed Flutter version:

```bash
# 1. Scaffold a new Flutter project (creates android/, ios/, etc.)
flutter create --org com.kingsfoodz --platforms=android kings_foodz_app
cd kings_foodz_app

# 2. Replace the generated pubspec.yaml and lib/ with the ones from this delivery
#    (copy the provided pubspec.yaml over the generated one, and replace
#    the lib/ folder entirely with the provided lib/)

# 3. Get packages
flutter pub get

# 4. Run on an emulator or a connected Android device
flutter run
```

## Project structure
```
lib/
  main.dart                # App entry, providers, theme
  theme/app_theme.dart      # Colors & ThemeData (maroon + gold "royal" theme)
  models/                   # FoodItem, Restaurant, CartItem, FoodOrder
  data/mock_data.dart       # All mock restaurants/menu/orders — replace with Firestore later
  providers/                # AuthProvider (hardcoded), CartProvider, FavoritesProvider
  widgets/                  # Shared widgets (bottom nav shell, text field, etc.)
  screens/                  # One folder per feature area
```

## Next steps (when you're ready to make it real)
- Swap `AuthProvider` for Firebase Authentication (email/phone/social).
- Replace `MockData` with Cloud Firestore queries (restaurants, menus, orders).
- Add real location/maps (Google Maps SDK) for nearby search + live tracking.
- Wire `CheckoutScreen` to a real payment provider instead of the demo flow.
- Build the Restaurant Partner Panel, Rider App, and Admin Dashboard as
  separate Flutter/web projects sharing this backend, per the concept doc.
