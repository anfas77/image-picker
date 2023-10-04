import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  File? file;
  XFile? pickedImage;
  List<File?> fileList = [];
  Future pickImageFromGallery() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedImage!.path);
      fileList.add(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 94, 141),
        title: const Text("Image Uplod"),
        actions: [
          IconButton(
            onPressed: () {
              pickImageFromGallery();
            },
            icon: const Icon(Icons.add),
            color: Color.fromARGB(255, 240, 117, 2),
          )
        ],
      ),
      body: GridView.builder(
          itemCount: fileList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (_, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.file(File(fileList[index]!.path),
                          fit: BoxFit.cover)),
                  Positioned(
                      right: 1,
                      child: IconButton(
                          onPressed: () {
                            dltImages(fileList[index]);
                          },
                          icon: Icon(Icons.cancel, color: Colors.red)))
                ],
              ),
            );
          }),
    );
  }

  void dltImages(data) {
    setState(() {
      fileList.remove(data);
    });
  }
}
