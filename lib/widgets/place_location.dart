import "package:flutter/material.dart";
import "package:location/location.dart";
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "dart:convert";

import "package:flutter_favorite_places/models/place.dart";

class PlaceLocation extends StatefulWidget {
  const PlaceLocation({super.key});

  @override
  State<PlaceLocation> createState() {
    return _PlaceLocationState();
  }
}

class _PlaceLocationState extends State<PlaceLocation> {
  CustomLocation _location;
  var _isGettingLocation = false;

  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      return;
    }

    final googleMapsAPIKey = dotenv.env["GOOGLE_MAPS_API_KEY"];
    final googleGeocodingUrl = dotenv.env["GOOGLE_MAPS_GEOCODING_URL"];
    final googleGeocodingUrlPath = dotenv.env["GOOGLE_MAPS_GEOCODING_URL_PATH"];

    final url = Uri.parse(
      "$googleGeocodingUrl$googleGeocodingUrlPath/json?latlng=$latitude,$longitude&key=$googleMapsAPIKey",
    );

    final response = await http.get(url);
    final data = json.decode(response.body);
    final address = data["results"][0]["formatted_address"];

    setState(() {
      _location = CustomLocation(
        latitude: latitude!,
        longitude: longitude!,
        address: address,
      );
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      "No location chosen yet",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    if (_isGettingLocation) {
      content = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Select on Map"),
            ),
          ],
        ),
      ],
    );
  }
}
