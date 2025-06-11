import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/local_plant.dart'; // غيري المسار حسب مكان الملف

class IdentifyResultScreen extends StatefulWidget {
  final Map<String, dynamic> resultData;
  final String imagePath;

  const IdentifyResultScreen({
    Key? key,
    required this.resultData,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<IdentifyResultScreen> createState() => _IdentifyResultScreenState();
}

class _IdentifyResultScreenState extends State<IdentifyResultScreen> {
  @override
  Widget build(BuildContext context) {
    final details = widget.resultData['details'] ?? {};
    final name = details['name'] ?? 'Unknown';
    final scientific = details['scientificName'] ?? '';
    final sunlight = details['growingConditions']?['sunlight'] ?? '';
    final water = details['growingConditions']?['water'] ?? '';
    final soil = details['growingConditions']?['soilType'] ?? '';
    final temperature = details['growingConditions']?['temperature'] ?? '';
    final flowerColor = details['flower']?['color'] ?? '';
    final flowerMorphology = details['flower']?['morphology'] ?? '';
    final vitamins = (details['vitamins'] as List?)?.join(', ') ?? '';
    final benefits = (details['healthBenefits'] as List?)?.join(', ') ?? '';

    return Scaffold(
      appBar: AppBar(title: Text("Plant Details")),
      body: ListView(
        children: [
          Image.file(
            File(widget.imagePath),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                Text(scientific, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildTag("☀ $sunlight"),
                    _buildTag("💧 $water"),
                    if (vitamins.isNotEmpty) _buildTag("💊 Vitamins"),
                    if (flowerColor.isNotEmpty) _buildTag("🌼 Flowering"),
                  ],
                ),
                SizedBox(height: 20),
                Text("Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 12),
                _buildDetailRow("Temperature", temperature, Icons.thermostat),
                _buildDetailRow("Sunlight", sunlight, Icons.wb_sunny),
                _buildDetailRow("Water", water, Icons.water_drop),
                _buildDetailRow("Soil Type", soil, Icons.landscape),
                _buildDetailRow("Flower Color", flowerColor, Icons.local_florist),
                _buildDetailRow("Flower Morphology", flowerMorphology, Icons.nature),
                _buildDetailRow("Vitamins", vitamins, Icons.medical_services),
                _buildDetailRow("Health Benefits", benefits, Icons.favorite),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton.icon(
          onPressed: () async {
            final box = await Hive.openBox('myPlants');
            final newPlant = LocalPlant(
              name: name,
              imagePath: widget.imagePath,
            );
            await box.add(newPlant.toMap());

            Navigator.pop(context, true);
          },
          icon: Icon(Icons.add),
          label: Text("Add to My Plants"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.green[50],
      shape: StadiumBorder(),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon) {
    if (value.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 10),
          Text("$title: ", style: TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value, softWrap: true, overflow: TextOverflow.visible),
          ),
        ],
      ),
    );
  }
}
