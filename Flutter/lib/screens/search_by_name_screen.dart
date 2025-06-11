import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:please_work/screens/Fruits.dart';
import 'package:please_work/screens/HerbsWeeds.dart';
import 'package:please_work/screens/SearchResultsScreen.dart';
import 'package:please_work/screens/Shrubs.dart';
import 'package:please_work/screens/Trees.dart';
import 'package:please_work/screens/Vegetables.dart';
import 'package:please_work/model/plant.dart' as model;


// صفحات التصنيفات
import 'package:please_work/screens/flowers_screen.dart';
import 'LeafPlants.dart';
import 'package:please_work/screens/Succluents.dart';



class SearchByNameScreen extends StatefulWidget {
  const SearchByNameScreen({super.key});

  @override
  State<SearchByNameScreen> createState() => _SearchByNameScreenState();
}

class _SearchByNameScreenState extends State<SearchByNameScreen> {
  TextEditingController _searchController = TextEditingController();
  List<model.Plant> searchResults = [];
  bool isLoading = false;

  final List<Map<String, String>> categories = [
    {'title': 'Leaf Plants', 'image': 'assets/images/leafs.png'},
    {'title': 'Flowers', 'image': 'assets/images/flower.png'},
    {'title': 'Succulents & Cacti', 'image': 'assets/images/Cacti.png'},
    {'title': 'Trees', 'image': 'assets/images/tree.png'},
    {'title': 'Shrubs', 'image': 'assets/images/Shrubs.png'},
    {'title': 'Herbs & Weeds', 'image': 'assets/images/herbs.png'},
    {'title': 'Fruits', 'image': 'assets/images/fruit.png'},
    {'title': 'Vegetables', 'image': 'assets/images/tomato.png'},
  ];

  final Map<String, Widget Function()> categoryScreens = {
    'Flowers': () => FlowersScreen(),
    'Leaf Plants': ()=>LeafsScreen(),
    'Succulents & Cacti': () => SuccluentsScreen(), 
    'Trees': () => TreesScreen(),
    'Shrubs': ()=>ShrubScreen(),
    'Herbs & Weeds': () => HerbsWeeds(),
    'Fruits':()=>FruitsScreen(),
    'Vegetables': ()=>vegetablesScreen(),

    
    
  };

  Future<void> _searchPlants(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      'https://greenify-project-production.up.railway.app/api/plants/search',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': query}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody.containsKey('results')) {
          final List<dynamic> results = responseBody['results'];

          if (results.isNotEmpty) {
            final List<model.Plant> plants =
                results.map((json) => model.Plant.fromJson(json)).toList();
            setState(() {
              searchResults = plants.cast<model.Plant>();
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchResultsScreen(results: plants),
              ),
            );
          } else {
            setState(() {
              searchResults = [];
            });
          }
        }
      } else {
        setState(() {
          searchResults = [];
        });
      }
    } catch (e) {
      print('Error fetching plants: $e');
      setState(() {
        searchResults = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchPlants,
              decoration: InputDecoration(
                hintText: 'Search for plants',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (searchResults.isEmpty && !isLoading)
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                  fontFamily: 'MouseMemoirs',
                ),
              ),
            const SizedBox(height: 16),
            if (searchResults.isEmpty && !isLoading)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                  children: categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        final selectedTitle = category['title']!;
                        if (categoryScreens.containsKey(selectedTitle)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => categoryScreens[selectedTitle]!(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  category['image']!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  category['title']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.green[800],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
