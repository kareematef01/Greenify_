class LocalPlant {
  final String name;
  final String imagePath;

  LocalPlant({required this.name, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory LocalPlant.fromMap(Map<String, dynamic> map) {
    return LocalPlant(
      name: map['name'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }
}
