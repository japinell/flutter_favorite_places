# Flutter Favorite Places

## Description

This is a cross-platform "favorite places" application built with **Flutter** and **Dart**. It demonstrates state management, image capture & selection, device location, Google Maps integration, and persistent storage (local and optional remote). The app lets users add, view, and remove favorite places — each place can include a title, an image, and a geo-location.

## Features

- Add favorite places with a title, photo, and location
- Pick or take photos using the device camera (`image_picker`)
- View saved places on an interactive Google Map
- Persist places locally using SQLite (`sqflite`) and optionally sync with a remote database
- Responsive UI for mobile and desktop
- Environment-based configuration using a `.env` file
- Simple, focused UI for listing and inspecting saved places

## User Stories

```
As a user
I want to add a place with a photo and location
So that I can remember where I visited and why it was special
```

```
As a user
I want to view my saved places on a map
So that I can see where they are geographically
```

```
As a user
I want to remove places I no longer need
So that my list stays relevant
```

## Design

Key source files and responsibilities:

```
-- lib/models/place.dart

Defines a Place model with id, title, image path, and location.
```

```
-- lib/providers/

Holds state and business logic (uses flutter_riverpod or other state management).
```

```
-- lib/widgets/

UI widgets for the places list, place detail, and the new-place form (image picker, map selector).
```

## Main Screens

- Places list — shows saved places and allows deleting
- Add Place — form to enter a title, pick/take a photo, and choose a location
- Place Detail — shows place image, title, and location on a map

## Installation Instructions

1. Install the Flutter SDK: https://docs.flutter.dev/get-started/install
2. Clone this repository:

```bash
git clone https://github.com/japinell/flutter_favorite_places.git
```

3. Install dependencies:

```bash
flutter pub get
```

4. (Required) Create a `.env` file at the project root to configure remote database connectivity or API keys. See the Configuration section below.

5. Run the app:

```bash
flutter run
```

## Configuration

This app uses Google Maps services for map display, geocoding and static map images. Create a `.env` file at the project root containing the following entries (an example is provided in `.env.example`):

```
GOOGLE_MAPS_API_KEY=your_api_key_here
GOOGLE_MAPS_GEOCODING_URL=https://maps.googleapis.com/maps/api/geocode
GOOGLE_MAPS_STATIC_MAP_URL=https://maps.googleapis.com/maps/api/staticmap
```

Notes and recommendations:

- Obtain an API key from the Google Cloud Console and enable the required APIs for your project: Maps SDK for Android, Maps SDK for iOS, Geocoding API, and Static Maps API.
- Restrict the API key before using it in production (restrict by Android package name + SHA-1, iOS bundle id, or HTTP referrers as appropriate).
- The project uses `flutter_dotenv` to load environment variables. Load the `.env` file early in `main.dart` (for example: `await dotenv.load();`) and read values with `dotenv.env['GOOGLE_MAPS_API_KEY']`.
- Do not commit real API keys to source control. Add `.env` to `.gitignore` and keep `.env.example` in the repo as a template.

This project also includes local persistence using `sqflite`, which works without any remote configuration.

## Packages Used

The project depends on the following packages (see `pubspec.yaml` for exact versions):

- `flutter_riverpod` — state management
- `http` — REST API calls
- `flutter_dotenv` — environment variables
- `image_picker` — capture or select images
- `location` — device location
- `google_maps_flutter` — map display and interaction
- `sqflite` — local SQLite persistence
- `uuid` — generate ids for places
- `google_fonts` — custom fonts
- `path_provider` / `path` — file storage helpers

## License

This project is licensed under the MIT License. See https://opensource.org/licenses/MIT for details.

## Contributing Guidelines

Want to contribute? Fork or clone the repository, create a feature branch, and open a pull request describing the change. Keep changes small and focused.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
