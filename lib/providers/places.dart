import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:path_provider/path_provider.dart" as syspath;
import "package:path/path.dart" as path;

import "package:flutter_favorite_places/models/place.dart";

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(Place place) async {
    final appPath = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final newImage = await place.image.copy("${appPath.path}/$fileName");
    final newPlace = Place(
      title: place.title,
      image: newImage,
      location: place.location,
    );

    state = [...state, newPlace];
  }
}

final placesProvider = StateNotifierProvider((ref) => PlacesNotifier());
