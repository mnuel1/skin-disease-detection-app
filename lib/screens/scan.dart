import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:camera/camera.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _selectedImage;
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  int direction = 0;

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  Future<void> startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController?.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageWidth = screenWidth * 0.97; // Adjust the multiplier to fit your UI
    double imageHeight = screenHeight * 0.78; // Adjust the multiplier to fit your UI

    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const LoadingAnimation(); // Or any other loading state
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.155,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Face Scanner',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                Text(
                  'Make sure your face is inside the screen.',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width - imageWidth) / 2,
            top: (MediaQuery.of(context).size.height - imageHeight) / 1.65,
            child: Container(
              width: imageWidth,
              height: imageHeight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 4.0),
                ),
                child: Center(
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.contain)
                      : (cameraController?.value.isInitialized == true
                      ? SizedBox(
                    width: imageWidth,
                    height: imageHeight,
                    child: CameraPreview(cameraController!),
                  )
                      : const LoadingAnimation()),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.8, .85),
            child: buildButton('Scan', 'assets/scan_icon.png'),
          ),
          Align(
            alignment: const Alignment(0, .85),
            child: buildButton('Flip', 'assets/flip_icon.png'),
          ),
          Align(
            alignment: const Alignment(0.8, .85),
            child: buildButton('Upload', 'assets/upload_icon.png'),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, String imagePath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.grey, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          print('$text button tapped');
          if (text == 'Scan') {
            cameraController?.takePicture().then((XFile? file) {
              if (mounted && file != null) {
                if (file != null) {
                  print("Picture saved to ${file.path}");
                }
              }
            });
          } else if (text == 'Upload') {
            _pickImageFromGallery(); // Use gallery for upload
          } else if (text == 'Flip') {
            setState(() {
              direction = direction == 0 ? 1 : 0;
              startCamera(direction);
            });
          }
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final double size;

  const LoadingAnimation({this.size = 40.0}); // Default size is 40.0

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: size / 6.0, // Adjust the scale factor based on desired size
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ScanScreen(),
  ));
}
