import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';


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
      processImage(File(pickedImage.path));
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
  void processImage(File imageFile) async {
    print("Processing captured image: ${imageFile.path}");

    final interpreter = await tfl.Interpreter.fromAsset('assets/model/model.tflite');

    File testImageFile = File(imageFile.path);

    List<List<List<int>>> imgArray = await preprocessImage(testImageFile);

    var input = List.filled(1 * 28 * 28 * 3, 0.0).reshape([1, 28, 28, 3]);

    // Flatten the 3D array to a 1D list
    var flatInput = imgArray.expand((row) => row.expand((pixels) => pixels.map((value) => value.toDouble())).toList()).toList();

    // Copy the values from flatInput to the input tensor
    for (int i = 0; i < flatInput.length; i++) {
      input[0][i ~/ (28 * 3)][(i ~/ 3) % 28][i % 3] = flatInput[i];
    }

    var output = List.filled(1 * 7, 0.0).reshape([1, 7]);
    interpreter.run(input, output);

    // Get the class label with the highest probability
    int predictedClassIndex = output[0].indexOf(output[0].reduce((a, b) => (a as double) > (b as double) ? a : b));

    // Map of class labels
    Map<int, List<String>> classLabels = {
      4: ['nv', ' melanocytic nevi'],
      6: ['mel', 'melanoma'],
      2: ['bkl', 'benign keratosis-like lesions'],
      1: ['bcc', ' basal cell carcinoma'],
      5: ['vasc', ' pyogenic granulomas and hemorrhage'],
      0: ['akiec', 'Actinic keratoses and intraepithelial carcinomae'],
      3: ['df', 'dermatofibroma']
    };

    // Print the predicted class and confidence score
    List<String> predictedClass = classLabels[predictedClassIndex] ?? ['Unknown', ''];
    double confidenceScore = output[0][predictedClassIndex];

    print('Predicted Class: ${predictedClass[0]} - ${predictedClass[1]}');
    print('Confidence Score: $confidenceScore');


    // Show a dialog with the predicted class
    showDialog(
      context: context, // Replace 'context' with the actual context where you want to show the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediction Result'),
          content: Column(
            children: [
              Text('Predicted Class: ${predictedClass[0]}'),
              Text('Description: ${predictedClass[1]}'),
              // Text('Confidence Score: $confidenceScore'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<List<List<int>>>> preprocessImage(File imageFile) async {
    // Read the file content and convert it to a Uint8List
    Uint8List bytes = await imageFile.readAsBytes();
    // Decode the image
    img.Image? originalImage = img.decodeImage(bytes);

    // Resize the image to 28x28
    img.Image resizedImage = img.copyResize(originalImage!, width: 28, height: 28);

    // Convert the image to a 3D array
    List<List<List<int>>> imgArray = [];
    for (int y = 0; y < resizedImage.height; y++) {
      List<List<int>> row = [];
      for (int x = 0; x < resizedImage.width; x++) {
        final pixel = resizedImage.getPixel(x, y);
        List<int> pixels = [
          pixel.r.toInt(), // Cast to int
          pixel.g.toInt(), // Cast to int
          pixel.b.toInt(), // Cast to int
        ];
        row.add(pixels);
      }
      imgArray.add(row);
    }

    return imgArray;
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
                  'Make sure the affected skin is inside the screen.',
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
                  processImage(File(file.path));
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
