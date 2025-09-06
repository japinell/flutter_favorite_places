import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "package:flutter_favorite_places/models/place.dart";
import "package:flutter_favorite_places/screens/map.dart";

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  String get imageLocation {
    final googleMapsAPIKey = dotenv.env["GOOGLE_MAPS_API_KEY"];
    final googleMapsStaticMapUrl = dotenv.env["GOOGLE_MAPS_STATIC_MAP_URL"];

    final staticImage =
        "$googleMapsStaticMapUrl?center=${place.location.latitude},${place.location.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${place.location.latitude},${place.location.longitude}&key=$googleMapsAPIKey";

    return staticImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MapScreen(
                        location: place.location,
                        isSelecting: false,
                      ),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(imageLocation),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
