import "package:flutter/material.dart";
import "package:flutter_favorite_places/providers/places.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:flutter_favorite_places/widgets/places_list.dart";
import "package:flutter_favorite_places/screens/add_places.dart";

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          future: future,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : PlacesList(places: places),
        ),
      ),
    );
  }
}
