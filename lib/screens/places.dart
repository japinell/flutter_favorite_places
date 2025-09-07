import "package:flutter/material.dart";
import "package:flutter_favorite_places/providers/places.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:flutter_favorite_places/widgets/places_list.dart";
import "package:flutter_favorite_places/screens/add_places.dart";

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).fetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPlacesScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : PlacesList(places: places),
        ),
      ),
    );
  }
}
