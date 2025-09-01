import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:flutter_favorite_places/models/place.dart";

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(Place place) {
    state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider((ref) => PlacesNotifier());
