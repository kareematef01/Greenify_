import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';

// موديل النبات
import '../model/plantss.dart' ;

// بيانات ثابتة لنباتات التصنيف
final List<Plantss> flowerPlants = [
  Plantss(
    image: 'assets/images/silkyPhacelia.jpg',
    scientificName: 'Phacelia sericea',
    commonName: 'Silky phacelia',
    category: 'Wildflower',
    about: 'Phacelia sericea, also known as silky phacelia, is a wildflower native to western North America. It is a delicate annual plant with hairy stems and leaves, producing clusters of small, bell-shaped lavender flowers. Silky phacelia is commonly found in dry, open areas such as grasslands, meadows, and along roadsides.',
    howToCare: 'Plant in well-drained soil in full sun. Water regularly during the growing season, but avoid overwatering. It doesn’t need heavy fertilization. Deadhead spent blooms to encourage more flowering.',

  ),
  Plantss(
    image: 'assets/images/blueMountain.jpg',
    scientificName: 'Penstemon floridus',
    commonName: 'Blue Mountain Penstemon',
    category: 'Perennial',
     about: 'Penstemon floridus, also known as downy penstemon, is a herbaceous perennial plant native to the eastern United States. It typically grows up to 2 feet tall and produces tubular, pink to purple flowers with white throats. The leaves are lance-shaped and covered in fine hairs, giving the plant a downy appearance. Penstemon floridus is commonly found in open woodlands, prairies, and rocky slopes.',
   howToCare: 'Prefers full sun and sandy, well-drained soil. Water moderately and allow the soil to dry out between waterings. Avoid excessive moisture. Pruning faded flowers promotes further blooming.',

  ),
  Plantss(
    image: 'assets/images/sikkimPrimrose.jpg',
    scientificName: 'Primula sikkimensis',
    commonName: 'Sikkim primrose',
    category: 'Perennial',
     about: 'Primula sikkimensis, also known as Sikkim primrose, is a perennial herbaceous plant native to the Himalayan region, specifically found in Sikkim, Bhutan, and Tibet. It is characterized by its clusters of nodding, tubular, bright yellow flowers with a sweet fragrance, blooming in late spring to early summer. The plant has dark green, ovate leaves with a slightly serrated edge, forming a basal rosette. Primula sikkimensis is often grown in gardens for its attractive flowers and prefers cool, moist conditions with partial shade.',
    howToCare: 'Grows best in partial shade with moist, rich, and well-drained soil. Keep the soil consistently moist, especially in dry periods. Avoid full sun in hot climates. Mulch to retain moisture.',

  ),
  Plantss(
    image: 'assets/images/narrowHeaded.jpg',
    scientificName: 'Ligularia stenocephala',
    commonName: 'Narrow-headed Ligularia',
    category: 'Flowering plant',
     about: 'Ligularia stenocephala, also known as leopard plant, is a herbaceous perennial plant native to eastern Asia. It has large, bold, dark green leaves with striking purple undersides and produces tall, yellow daisy-like flowers on sturdy stems. Leopard plant thrives in moist, shady conditions and is often grown for its ornamental foliage in gardens and landscapes.',
    howToCare: 'Thrives in partial shade and moist, fertile soil. Water frequently to maintain soil moisture, especially in summer. Protect from direct afternoon sun. Divide every few years to maintain vigor.',

  ),
];

// ويدجت صفحة التصنيف
class FlowersScreen extends StatelessWidget {
  const FlowersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowers', style: TextStyle(color: Colors.teal[900])),
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
              itemCount: flowerPlants.length,
              itemBuilder: (context, index) {
                final plant = flowerPlants[index];
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
},),
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
