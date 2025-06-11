import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import 'package:please_work/screens/identify_result_screen.dart';
import 'package:please_work/screens/diagnose_result_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  File? _selectedImage;
  bool _isFlashOn = false;
  bool _isCameraInitialized = false;
  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(_cameras![0], ResolutionPreset.medium);
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final image = await _cameraController!.takePicture();
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController != null) {
      _isFlashOn = !_isFlashOn;
      await _cameraController!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    }
  }

  Future<File?> _compressImage(File imageFile) async {
    final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image != null) {
      final compressedImage = img.encodeJpg(image, quality: 85);
      return File(imageFile.path)..writeAsBytesSync(compressedImage);
    }
    return imageFile;
  }

  Future<void> _sendImageRequest(String apiUrl, File image, String action) async {
    try {
      final compressedImage = await _compressImage(image);
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('image', compressedImage!.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);

        if (action == 'identify') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IdentifyResultScreen(
                resultData: data,
                imagePath: compressedImage.path,
              ),
            ),
          );
        } else if (action == 'diagnose') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DiagnosisResultScreen(
                result: data,
                imagePath: compressedImage.path,
              ),
            ),
          );
        }
      } else {
        throw Exception('Failed to process image');
      }
    } catch (e) {
      if (!_isRetrying) {
        setState(() {
          _isRetrying = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to process image. Retrying...')),
        );
        await Future.delayed(const Duration(seconds: 2));
        await _sendImageRequest(apiUrl, image, action); // Retry
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to process image after retrying.')),
        );
      }
    }
  }

  Future<void> _identifyPlant() async {
    if (_selectedImage == null) return;
    await _sendImageRequest(
      'https://greenify-project-production.up.railway.app/api/plants/identify-plant',
      _selectedImage!,
      'identify',
    );
  }

  Future<void> _diagnosePlant() async {
    if (_selectedImage == null) return;
    await _sendImageRequest(
      'https://greenify-project-production.up.railway.app/api/plants/analyze-image',
      _selectedImage!,
      'diagnose',
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_selectedImage != null)
            Positioned.fill(
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
              ),
            )
          else if (_isCameraInitialized)
            Positioned.fill(child: CameraPreview(_cameraController!))
          else
            const Center(child: CircularProgressIndicator()),

          // مربع الإطار في المنتصف
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // زر الفلاش
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(
                _isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _toggleFlash,
            ),
          ),

          // زر الرجوع
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // زر التقاط صورة
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                ),
              ),
            ),
          ),

          // أزرار Identify و Diagnose
          Positioned(
            bottom: 170,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _identifyPlant,
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.green, Colors.blue],
                          ),
                        ),
                        child: const Icon(Icons.search, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 6),
                      const Text("Identify", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                GestureDetector(
                  onTap: _selectedImage != null ? _diagnosePlant : null,
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: _selectedImage != null
                              ? const LinearGradient(colors: [Colors.orange, Colors.deepOrange])
                              : const LinearGradient(colors: [Colors.grey, Colors.grey]),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 6),
                      Text("Diagnose",
                        style: TextStyle(
                          color: _selectedImage != null ? Colors.white : Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // زر المعرض + معاينة مصغرة
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.white, size: 28),
                  onPressed: _pickImageFromGallery,
                ),
                if (_selectedImage != null)
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
