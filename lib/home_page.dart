import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Camera App"),
      ),
      body: Center(
        child: _image != null
            ? Image.file(File(_image!.path))
            : const Text("No image available"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optionDialogBox,
        child: const Icon(Icons.add_a_photo),
        tooltip: "Open camera",
      ),
    );
  }

  Future<void> _optionDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text(
                      "Take a photo",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: openCamera,
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  GestureDetector(
                    child: const Text(
                      "Select image from Gallery",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: openGallery,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future openCamera() async {
    final XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
  }

  Future openGallery() async {
    final XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = photo;
    });
  }
}
