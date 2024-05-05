import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path/path.dart' as path;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late ScreenshotController _screenshotController;
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();
    _initializeCameraControllerFuture = _initializeCamera();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus == PermissionStatus.granted) {
      _initializeCamera();
    } else {
      _showCameraPermissionDeniedMessage();
    }
  }

  void _showCameraPermissionDeniedMessage() {
    print('camera permission was denied by user');
  }

  Future<void> _initializeCamera() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus == PermissionStatus.granted) {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final firstCamera = cameras.first;
        _cameraController = CameraController(
          firstCamera,
          ResolutionPreset.high,
        );
        return _cameraController.initialize(); // This will set the future
      } else {
        _showNoCameraAvailableMessage();
      }
    } else {
      _showCameraPermissionDeniedMessage();
    }
    return Future.error('Camera initialization failed');
  }

  void _showNoCameraAvailableMessage() {
    print('no camera  avaible');
  }

  void _showCameraNotInitializedMessage() {
    print('no camera iniitioalized');
  }

  void _showTakePictureErrorMessage(e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error taking picture: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSaveImageErrorMessage(e) {}
  void _showImageSavedMessage(savedImagePath) {}

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      _showCameraNotInitializedMessage();
      return;
    }
    try {
      final XFile photo = await _cameraController.takePicture();
      _saveImage(photo.path);
    } catch (e) {
      _showTakePictureErrorMessage(e);
    }
  }

  Future<void> _saveImage(String imagePath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = path.basename(imagePath);
      final savedImagePath = path.join(directory.path, fileName);
      final imageFile = File(imagePath);
      await imageFile.copy(savedImagePath);
      _showImageSavedMessage(savedImagePath);
    } catch (e) {
      _showSaveImageErrorMessage(e);
    }
  }

  // Add methods to show messages to the user here...

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeCameraControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Screenshot(
            controller: _screenshotController,
            child: Scaffold(
              appBar: AppBar(title: Text('Camera UI')),
              body: CameraPreview(_cameraController),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.camera),
                onPressed: () async {
                  final imagePath = await _takePicture();

                  // Optionally, save the image to the gallery
                },
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    if (_cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
    super.dispose();
  }
}
