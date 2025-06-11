import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/plant.dart'; // كلاس Plant من الـ API

class PlantDetailsScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailsScreen({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.commonName),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plant.imageUrls.isNotEmpty)
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      plant.imageUrls[0],
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (plant.imageUrls.length > 1)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        plant.imageUrls[1],
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 16),
            Text(
              plant.commonName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              plant.scientificName,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              plant.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.thermostat, 'Temperature', '18°C - 24°C'),
            _buildDetailRow(Icons.wb_sunny, 'Sunlight', plant.lightNeeds),
            _buildDetailRow(Icons.water_drop, 'Water', plant.waterNeeds, trailing: _buildCalculateButton()),
            _buildDetailRow(Icons.recycling, 'Repotting', 'Every 14 to 18 months'),
            _buildDetailRow(Icons.grass, 'Fertilizing', 'Apply balanced fertilizer in early spring and late fall'),
            _buildDetailRow(Icons.bug_report, 'Pests', 'Aphids'),

            if (plant.faq.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'FAQs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...plant.faq.map((item) => _buildFAQItem(item['question']!, item['answer']!)).toList(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) => ElevatedButton.icon(
            onPressed: () async {
              final box = await Hive.openBox('myPlants');


              final plantData = {
                'name': plant.commonName,
                'image': plant.imageUrls.isNotEmpty ? plant.imageUrls[0] : '',
              };

              final alreadyExists = box.values.any((p) =>
                  p is Map && p['name'] == plantData['name']);

              if (!alreadyExists) {
                await box.add(plantData);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${plant.commonName} added to My Plants!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${plant.commonName} is already in My Plants.')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add to My Plants'),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value, {Widget? trailing}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildCalculateButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Calculate',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(answer),
        ],
      ),
    );
  }
}
