import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:nitro_corn/const.dart';
import 'package:nitro_corn/loginScaffold.dart';
import 'package:nitro_corn/utils.dart';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  List<Uint8List> _selectedImages = [];
  final int _minImageCount = 10;

  Future<void> _selectImages() async {
    List<Uint8List> images = [];

    if (kIsWeb) {
      // Web platform
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        for (var file in result.files) {
          images.add(file.bytes!);
        }
      }
    } else {
      // Mobile platform
      final ImagePicker _picker = ImagePicker();
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        for (var file in pickedFiles) {
          images.add(await file.readAsBytes());
        }
      }
    }

    setState(() {
      _selectedImages.addAll(images);
    });
  }

  void _clearImages() {
    setState(() {
      _selectedImages.clear();
    });
  }

  void _navigateToNextScreen() {
    if (_selectedImages.length >= _minImageCount) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScaffoldWidget(
              widget: Center(
            child: Text("This feature is not available for now....."),
          )),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: appBarGradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust border radius as needed
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "This feature is not available for this version...."),
                          backgroundColor: Color.fromARGB(255, 32, 176,
                              106), // Customize background color if needed
                        ),
                      );
                    },
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.white), // Icon color
                    label: const Text('Open Camera',
                        style: TextStyle(color: Colors.white)), // Text color
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      elevation: MaterialStateProperty.all<double>(
                          0), // This removes any shadow
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_selectedImages.isEmpty)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: appBarGradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust border radius as needed
                    ),
                    child: ElevatedButton.icon(
                      onPressed: _selectImages,
                      icon: const Icon(Icons.file_present_outlined,
                          color: Colors.white), // Icon color
                      label: const Text('Upload Images',
                          style: TextStyle(color: Colors.white)), // Text color
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(
                            0), // This removes any shadow
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _selectedImages.map((image) {
                          return Image.memory(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      if (_selectedImages.length < _minImageCount) ...[
                        Text(
                          'Please select at least $_minImageCount images. Currently selected: ${_selectedImages.length}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: appBarGradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust border radius as needed
                          ),
                          child: ElevatedButton(
                            onPressed: _selectImages,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              elevation: MaterialStateProperty.all<double>(
                                  0), // This removes any shadow
                            ),
                            child: const Text(
                              'Add more Images',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      if (_selectedImages.length >= _minImageCount) ...[
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: appBarGradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust border radius as needed
                          ),
                          child: ElevatedButton(
                            onPressed: _navigateToNextScreen,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              elevation: MaterialStateProperty.all<double>(
                                  0), // This removes any shadow
                            ),
                            child: const Text(
                              'Test',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: appBarGradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust border radius as needed
                        ),
                        child: ElevatedButton(
                          onPressed: _clearImages,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            elevation: MaterialStateProperty.all<double>(
                                0), // This removes any shadow
                          ),
                          child: const Text(
                            'Clear Images',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
