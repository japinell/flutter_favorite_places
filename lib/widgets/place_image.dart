import "package:flutter/material.dart";
import "dart:io";
import "package:image_picker/image_picker.dart";

class PlaceImage extends StatefulWidget {
  const PlaceImage({super.key});

  @override
  State<PlaceImage> createState() {
    return _PlaceImageState();
  }
}

class _PlaceImageState extends State<PlaceImage> {
  File? _imageFile;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _imageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: Icon(Icons.camera),
      label: const Text("Take Picture"),
    );

    if (_imageFile != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _imageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

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
      child: content,
    );
  }
}
