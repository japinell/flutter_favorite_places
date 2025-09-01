import "package:flutter/material.dart";
import "package:flutter_favorite_places/widgets/places_list.dart";
import "package:flutter_favorite_places/screens/add_places.dart";

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: PlacesList(places: []),
    );
  }
}
