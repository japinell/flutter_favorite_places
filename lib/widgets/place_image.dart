import "package:flutter/material.dart";

class PlaceImage extends StatefulWidget {
  const PlaceImage({super.key});

  @override
  State<PlaceImage> createState() {
    return _PlaceImageState();
  }
}

class _PlaceImageState extends State<PlaceImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(Icons.camera),
        label: const Text("Take Picture"),
      ),
    );
  }
}
