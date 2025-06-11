import 'package:flutter/material.dart';

class DiagnosisResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const DiagnosisResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final details = result['details'] ?? {};
    final String plantName = details['plantName'] ?? 'Unknown';
    final String status = details['status'] ?? 'Unknown';
    final String description = details['description'] ?? '';
    final String treatment = details['treatment'] ?? '';
    final String additionalInfo = details['additionalInformation'] ?? details['additionalInfo'] ?? '';

    final bool isHealthy = status.toLowerCase() == 'healthy';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plant: $plantName',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: $status',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              if (isHealthy) ...[
                Text(
                  'Additional Information:',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  additionalInfo.isNotEmpty
                      ? additionalInfo
                      : 'No additional info provided.',
                ),
              ] else ...[
                Text(
                  'Description:',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(description),
                const SizedBox(height: 20),
                Text(
                  'Treatment:',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(treatment),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
