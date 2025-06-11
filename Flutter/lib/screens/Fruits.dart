import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';
import '../model/plantss.dart' ;




// بيانات ثابتة لنباتات التصنيف
final List<Plantss> Fruits = [
  Plantss(
    image: 'assets/images/Ohelo.jpg',
    scientificName: 'Vaccinium reticulatum',
    commonName: 'Ohelo',
    category: 'Shrub',
    about: 'Ohelo is a native Hawaiian shrub that grows in volcanic soils and is known for its bright red berries. It plays a crucial role in native ecosystems and is often found near volcanic craters."',
    howToCare: 'Ohelo requires well-draining, acidic soil and plenty of sunlight. Water regularly but avoid waterlogging. It thrives in cooler climates and needs minimal pruning. Avoid high-nitrogen fertilizer',
  ),
  Plantss(
    image: 'assets/images/Chrysophyllum pomiferum.jpg',
    scientificName: 'Chrysophyllum pomiferum',
    commonName: 'Star apple',
    category: 'Fruit tree ',
    about: '"The Star apple tree is a tropical fruit-bearing species known for its star-shaped interior. Its sweet, milky flesh is rich in nutrients and is commonly grown in Caribbean and Southeast Asian regions."',
    howToCare: 'Plant in full sun with rich, well-draining soil. Water deeply during dry periods. Prune regularly to maintain shape and encourage fruiting. Protect young trees from frost and pests."',
  ),
  Plantss(
    image: 'assets/images/Solanum aphyodendro.jpg',
    scientificName: 'Solanum aphyodendron',
    commonName: 'ghost plant',
    category: 'Solanaceae',
    about:'Ghost plant is a rare member of the nightshade family, recognized for its pale, almost ghostly appearance. It typically grows in forested or shaded environments and is known for its delicate structure.' ,
    howToCare: '"Grow in partial shade and ensure the soil remains moist but not soggy. Use organic mulch to retain moisture. It doesn’t tolerate extreme heat or direct sunlight well. Avoid over-fertilizing.',

  ),
  Plantss(
    image: 'assets/images/Spondias pinnata.jpg',
    scientificName: 'Spondias pinnata',
    commonName: 'Indian hog plum',
    category: 'Flowering plant',
    about: 'The Indian hog plum is a fast-growing flowering tree native to South and Southeast Asia. It produces tangy, edible fruits used in pickles and traditional medicine.',

    howToCare: '"Plant in full sun and water regularly during the growing season. Prune to control shape and remove dead branches. It adapts well to various soil types but prefers slightly acidic soil.',
  ),
];

// ويدجت صفحة التصنيف
class FruitsScreen extends StatelessWidget {
  const FruitsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruits', style: TextStyle(color: Colors.teal[900])),
        leading: BackButton(color: Colors.teal[900]),
        backgroundColor: Colors.teal[100],
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
                fillColor: const Color.fromARGB(255, 221, 229, 223),
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
              itemCount: Fruits.length,
              itemBuilder: (context, index) {
                final plant = Fruits[index];
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
}, ),
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
