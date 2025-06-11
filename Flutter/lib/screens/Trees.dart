import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';
import '../model/plantss.dart';

// موديل النبات




// بيانات ثابتة لنباتات التصنيف
final List<Plantss> treePlant = [
  Plantss(
    image: 'assets/images/Ventilago denticulata.jpg',
    scientificName: 'Ventilago denticulata',
    commonName: 'Toothed Ventilago',
    about: 'A climbing shrub found in tropical forests. It is recognized by its toothed leaf edges.',
    howToCare: 'Requires moderate sunlight and moist soil. Water regularly, avoid waterlogging.',
    category: 'Angiosperms'
  ),
  Plantss(
    image: 'assets/images/Eucalyptus woodwardii.jpg',
    scientificName: 'Eucalyptus woodwardii',
    commonName: 'Lemon Flowered',
    about: 'A small tree with lemon-scented yellow flowers, native to Western Australia.',
    howToCare: 'Needs full sunlight and well-drained soil. Prune occasionally to maintain shape.',
    category: 'tree'
  ),
  Plantss(
    image: 'assets/images/Inga pezizifera.jpg',
    scientificName: 'Inga pezizifera',
    commonName: 'Guama',
    about: 'Tropical tree species commonly used for shade and soil improvement in agroforestry.',
    howToCare: 'Thrives in warm climates. Provide rich, moist soil and regular watering.',
    category: 'Genus'
  ),
  Plantss(
    image: 'assets/images/Duboisia myoporoides.jpg',
    scientificName: 'Duboisia myoporoides',
    commonName: 'Corkwood',
    about: 'A fast-growing shrub used for medicinal purposes. Leaves contain alkaloids.',
    howToCare: 'Plant in sunny areas. Requires well-drained soil and protection from strong winds.',
    category: 'Shurb'
  ),
];


// ويدجت صفحة التصنيف
class TreesScreen extends StatelessWidget {
  const TreesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trees', style: TextStyle(color: Colors.teal[900])),
        leading: BackButton(color: Colors.teal[900]),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for plants',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: treePlant.length,
              itemBuilder: (context, index) {
                final plant = treePlant[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          plant.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        plant.commonName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plant.scientificName, style: TextStyle(fontSize: 12)),
                          SizedBox(height: 4),
                          Text(plant.category, style: TextStyle(color: Colors.teal)),
                        ],
                      ),
                   onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CategroisDetailsScreen(plant: plant),
    ),
  );
},
 ),
                    
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
