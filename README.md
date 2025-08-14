# Movie Demo App (BlackBull)

A Flutter demo that showcases a movie catalog with search, favorites, onboarding, and detail views. It integrates with The Movie Database (TMDB) API, uses local persistence for user session and favorites, and applies smooth UI patterns (skeleton loaders, cached images).

---

## Features

- **Onboarding**: short intro carousel with “Skip” option(Not mandatory for the user).
- **Splash**: validates local session & favorites showing a Lottie animation.
- **Search**: query movies with infinite scroll & skeleton loaders.
- **Favorites**: persist your favorite movies on device.
- **Details**: poster + backdrop with a Hero animation and ratings.
- **Offline-friendly UI**: cached images, graceful error states.

---

## Technical Decisions & Stack

- **Flutter**: cross-platform UI.
- **State management**: `provider` for simple and explicit app state (`UserProvider` and lightweight view state within screens, `AppProvider` for general states).
- **HTTP**: `http` for TMDB requests (lean, no heavy client abstraction).
- **Local persistence**: `shared_preferences` to store:
  - User/device session metadata
  - Favorite movies (full JSON list)
- **Image caching**: `cached_network_image` for fast poster/backdrop loads.
- **UX polish**:

  - `card_loading` for skeletons while fetching.
  - `flutter_rating` to render star ratings.
  - `introduction_screen` for onboarding slides.

- **Device info**: `device_info_plus` when a per-device identifier is useful for a lightweight “session”.
- **Icons**: `flutter_launcher_icons` to generate adaptive app icons from a single source file.

---

## Project Structure

```text
lib/
  main.dart
  models/
    movie.dart
    user.dart
  providers/
    user_provider.dart
    main_provider.dart
  services/
    api_services.dart         # GeneralApi.searchMovies(...), etc.
    shared_prefences.dart         # To store User data and favorite movies.
  home/
    widgets/
      common_movie_tile.dart  # Reusable movie row/tile
      is_favorite_widget.dart # Reusable Widget to add/remove movie from Favorites
      movide_detail.dart # Reusable Widget to show the movie details
      sign_out_button.dart # Reusable Widget to logout the user.
    favorites/
      favorites_main_screen.dart  # Main screen that show the user favorites.
    popular/
      popular_main_screen.dart # Main Screen that shows the popular movies
    search/
      search_main_screen.dart # Main Scren for movie searching
  auth/
    splashscreen.dart * Show an animataion and validate stored data
    onboarding_screen.dart * App general features explanation.
    login.dart *Login page
    user_name_register.dart *User registration page.
```

---

## Setup

### Prerequisites

- Flutter SDK (3.8.x+)
- A TMDB API key (v3). Create one at https://www.themoviedb.org/

### 1) Clone & install

```bash
git clone https://github.com/Ramiro1613/movie_player_demo.git
cd movie_player_demo
flutter pub get
```

### 2) Configure Android permissions

`android/app/src/main/AndroidManifest.xml` (inside `<manifest>` but **outside** `<application>`):

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

### 3) Run the app

```bash
flutter run --dart-define=TMDB_API_KEY=YOUR_TMDB_KEY
```

### Optional: Generate launcher icons

Add to `pubspec.yaml` under `dev_dependencies`:

```yaml
flutter_launcher_icons: ^0.13.1
```

Config:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/logo.png"
  remove_alpha_ios: true
  min_sdk_android: 21
```

Generate:

```bash
dart run flutter_launcher_icons
```

---

## How to Use

1. **Splash**  
   Runs a quick check of local data (session + favorites). First-time users or signed-out state → redirected to **Onboarding**.

2. **Onboarding**  
   Slide carousel explaining core capabilities. Users can **Next** through or **Skip**. On completion, navigate to **Login** (or main flow in this demo).

3. **Search**  
   Enter a query and tap **Search**.

   - Skeleton loaders appear while fetching.
   - Results support **infinite scroll**.
   - Each row uses `CommonMovieTile(movie)`.

4. **Favorites**  
   Stored locally with `shared_preferences`. Retrieve on app start and display in the dedicated list.

5. **Details**  
   Shows backdrop + poster with a `Hero` transition; displays title, release date, overview, and rating.

---

## API Notes

- **Base**: `https://api.themoviedb.org/3`
- **Popular**: `/movie/popular?api_key=...&page=...`
- **Search**: `/search/movie?api_key=...&query=...&page=...`
- **Images**: `https://image.tmdb.org/t/p/w300` (posters/backdrops)

> All requests require an `api_key`. Handle rate limits & errors gracefully (the UI already shows snackbars on failures). If you want to change the `api_key` you can change it at services/api_services.dart

---

## Development Notes

- **Coding style**: `flutter_lints` is enabled. Run:
  ```bash
  dart format .
  flutter analyze
  ```
- **Pagination**: implemented with `ScrollController` near-bottom detection.
- **Caching**: `cached_network_image` handles in-memory/disk caching of posters/backdrops.

---

## Troubleshooting

- **Network errors**  
  Verify `INTERNET` permission is present on Android and that you’re using HTTPS endpoints.

- **Launcher icons tool error**  
  Use `dart run flutter_launcher_icons`. Confirm the image path exists.

---
