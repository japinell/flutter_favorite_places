import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:path_provider/path_provider.dart" as syspath;
import "package:path/path.dart" as path;
import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqlite_api.dart";

import "package:flutter_favorite_places/models/place.dart";

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final database = await sql.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)",
        );
      },
      version: 1,
    );

    return database;
  }

  void addPlace(Place place) async {
    final appPath = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final newImage = await place.image.copy("${appPath.path}/$fileName");
    final newPlace = Place(
      title: place.title,
      image: newImage,
      location: place.location,
    );

    final database = await _getDatabase();

    database.insert("places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "latitude": newPlace.location.latitude,
      "longitude": newPlace.location.longitude,
      "address": newPlace.location.address,
    });

    state = [...state, newPlace];
  }
}

final placesProvider = StateNotifierProvider((ref) => PlacesNotifier());
