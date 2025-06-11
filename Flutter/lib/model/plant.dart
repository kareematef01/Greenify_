class Plant {
  final String id;
  final String commonName;
  final String scientificName;
  final List<String> imageUrls; // <-- تم التعديل هنا
  final String description;
  final String waterNeeds;
  final String lightNeeds;
  final List<Map<String, String>> faq;

  Plant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.imageUrls, // <-- تم التعديل هنا
    required this.description,
    required this.waterNeeds,
    required this.lightNeeds,
    required this.faq,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['_id']?.toString() ?? '',
      commonName: json['plantName'] ?? 'Unknown',
      scientificName: json['scientificName'] ?? 'Unknown',
      imageUrls: (json['images'] as List<dynamic>?)
              ?.map((img) => img['imageUrl']?.toString() ?? '')
              .where((url) => url.isNotEmpty)
              .toList() ??
          [],
      description: json['about'] ?? 'No description available',
      waterNeeds: json['details']?['water'] ?? 'Unknown',
      lightNeeds: json['details']?['sunlight'] ?? 'Unknown',
      faq: (json['faq'] as List<dynamic>?)
        ?.map((item) => Map<String, String>.from({
              'question': item['question'] ?? '',
              'answer': item['answer'] ?? '',
            }))
        .toList() ?? [],

    );
  }
}
