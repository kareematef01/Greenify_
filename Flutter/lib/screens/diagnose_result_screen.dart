import 'package:flutter/material.dart';
import 'dart:io';

class DiagnosisResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;
  final String imagePath;

  const DiagnosisResultScreen({
    Key? key,
    required this.result,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = result['details'] ?? {};
    final String plantName = details['plantName'] ?? 'Unknown';
    final String status = details['status'] ?? 'Unknown';
    final String description = details['description'] ?? '';
    final String treatment = details['treatment'] ?? '';
    final String additionalInfo = details['additionalInformation'] ?? ''; // تأكد من المفتاح الصحيح

    final bool isHealthy = status.toLowerCase() == 'healthy';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File(imagePath),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.local_florist, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  plantName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(
                  isHealthy ? Icons.check_circle : Icons.warning,
                  color: isHealthy ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Status: $status',
                  style: TextStyle(fontSize: 18, color: isHealthy ? Colors.green : Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (isHealthy && additionalInfo.isNotEmpty) ...[
              _buildSectionTitle('Description'),
              Text(description),
              _buildSectionTitle('Additional Information'),
              Text(additionalInfo),
            ] else if (!isHealthy) ...[
              _buildSectionTitle('Description'),
              Text(description),
              const SizedBox(height: 16),
              _buildSectionTitle('Treatment'),
              Text(treatment),
            ],
            const SizedBox(height: 30),

            // زر الرجوع بتصميم دائري
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildSectionTitle(String title) {
  IconData icon;
  if (title.toLowerCase() == 'description') {
    icon = Icons.description; // أيقونة مختلفة لـ Description
  } else {
    icon = Icons.info_outline; // الأيقونة الافتراضية
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
}
