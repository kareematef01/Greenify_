import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:light/light.dart';
import 'package:permission_handler/permission_handler.dart';

class LightMeterScreen extends StatefulWidget {
  const LightMeterScreen({super.key});

  @override
  State<LightMeterScreen> createState() => _LightMeterScreenState();
}

class _LightMeterScreenState extends State<LightMeterScreen> {
  late CameraController _controller;
  Light? _light;
  StreamSubscription<int>? _subscription;

  double _lightLevel = 0;
  bool _isCameraInitialized = false;
  bool _hasPermission = false;
  bool _isLightSensorAvailable = true; // نفترض أنه موجود، لو فشل نستخدم الكاميرا
  bool _isUsingCamera = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final sensorStatus = await Permission.sensors.status;

    if (!cameraStatus.isGranted) await Permission.camera.request();
    if (!sensorStatus.isGranted) await Permission.sensors.request();

    if (mounted) {
      setState(() {
        _hasPermission = cameraStatus.isGranted;
      });
      await _initLightMeasurement();
    }
  }

  Future<void> _initLightMeasurement() async {
    try {
      _startLightSensor();
    } catch (e) {
      _isLightSensorAvailable = false;
      await _initCamera();
      _startCameraLightAnalysis();
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.back),
        ResolutionPreset.low,
      );

      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _isUsingCamera = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize camera: ${e.toString()}')),
        );
      }
    }
  }

  void _startLightSensor() {
    _light = Light();
    _subscription = _light!.lightSensorStream.listen(
      (luxValue) {
        if (mounted) {
          setState(() {
            _lightLevel = luxValue.toDouble();
          });
        }
      },
      onError: (error) async {
        _isLightSensorAvailable = false;
        await _initCamera();
        _startCameraLightAnalysis();
      },
    );
  }

  void _startCameraLightAnalysis() {
    if (!_isCameraInitialized) return;

    _controller.startImageStream((CameraImage image) {
      final brightness = _estimateBrightness(image);
      if (mounted) {
        setState(() {
          _lightLevel = (brightness * 20).clamp(0, 2000).toDouble();
        });
      }
    });
  }

  double _estimateBrightness(CameraImage image) {
    if (image.planes.isEmpty) return 0;

    final plane = image.planes[0];
    final bytes = plane.bytes;
    int sum = 0;

    for (int i = 0; i < bytes.length; i += 10) {
      sum += bytes[i] & 0xFF;
    }

    return sum / (bytes.length / 10) / 255;
  }

  @override
  void dispose() {
    if (_isUsingCamera && _isCameraInitialized) {
      _controller.dispose();
    }
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Light Meter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMainContent()),
          _buildLightInfoCard(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (!_hasPermission) return _buildPermissionDenied();

    if (_isUsingCamera && !_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isUsingCamera) {
      return CameraPreview(_controller);
    }

    return _buildSensorVisualization();
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.no_photography, size: 60, color: Colors.grey),
          const SizedBox(height: 20),
          const Text('Camera permission required', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _checkPermissions,
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }

  Widget _buildSensorVisualization() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline, size: 100, color: _getLightColor()),
          const SizedBox(height: 20),
          Text(
            'Measuring ambient light...',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildLightInfoCard() {
    final optimalMin = 430;
    final optimalMax = 1184;
    final isOptimal = _lightLevel >= optimalMin && _lightLevel <= optimalMax;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'CURRENT LIGHT LEVEL',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.grey[600],
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_lightLevel.toStringAsFixed(0)} LUX',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _getLightColor(),
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _lightLevel / 2000,
            minHeight: 10,
            backgroundColor: Colors.grey[200],
            color: _getLightColor(),
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                isOptimal ? Icons.check_circle : Icons.warning,
                color: isOptimal ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isOptimal
                      ? 'Optimal light for plants'
                      : _lightLevel < optimalMin
                          ? 'Not enough light for plants'
                          : 'Too much light for plants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isOptimal ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Optimal range: $optimalMin-$optimalMax LUX',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Color _getLightColor() {
    if (_lightLevel < 430) return Colors.orange;
    if (_lightLevel > 1184) return Colors.red;
    return Colors.green;
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Light Measurement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isLightSensorAvailable
                  ? 'Using device light sensor'
                  : 'Estimating light from camera',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Most plants need between 430-1184 LUX for healthy growth. '
              'This tool helps you measure light intensity in your plant\'s location.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Note: Camera-based measurements are estimates only. '
              'For precise readings, use a dedicated light meter.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
