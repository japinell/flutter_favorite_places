import "package:uuid/uuid.dart";
import "dart:io";

const uuid = Uuid();

class CustomLocation {
  final double latitude;
  final double longitude;
  final String address;

  const CustomLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image;
  final CustomLocation location;

  Place({id, required this.title, required this.image, required this.location})
    : id = id ?? uuid.v4();
}
