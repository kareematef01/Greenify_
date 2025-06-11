// lib/models.dart
class Plantss {
  final String image;
  final String scientificName;
  final String commonName;
  final String category;
  final String about; // إضافة معلومات about
  final String howToCare; // إضافة معلومات how to care

  Plantss({
    required this.image,
    required this.scientificName,
    required this.commonName,
    required this.category,
    required this.about, // إضافة المعلومات في البناء
    required this.howToCare, // إضافة المعلومات في البناء
  });
}
