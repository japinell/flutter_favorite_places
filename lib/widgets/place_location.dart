import "package:flutter/material.dart";

class PlaceLocation extends StatefulWidget {
  const PlaceLocation({super.key});

  @override
  State<PlaceLocation> createState() {
    return _PlaceLocationState();
  }
}

class _PlaceLocationState extends State<PlaceLocation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {},
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
