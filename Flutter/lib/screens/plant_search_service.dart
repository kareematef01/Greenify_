import 'dart:convert';
import 'package:http/http.dart' as http;

class PlantSearchService {
  static const String baseUrl =
      'https://search-plantapiproject-production-04e2.up.railway.app/api/plants/search';

  static Future<Map<String, dynamic>?> searchPlant(String query) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "Query": query,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}
