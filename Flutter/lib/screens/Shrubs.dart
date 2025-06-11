import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';

// موديل النبات
import '../model/plantss.dart';

// بيانات ثابتة لنباتات التصنيف
final List<Plantss> Shrubs = [
  Plantss(
    image: 'assets/images/Miconia nervosa.jpg',
    scientificName: 'Miconia nervosa',
    commonName: 'Velvet tree',
    category: 'Shrub',
    about: 'Miconia crenata, also known as veludo roxo, is a shrub native to Brazil that belongs to the Melastomataceae family. It is characterized by its velvety purple leaves and small pink flowers. It is considered an invasive species in some regions due to its aggressive growth and ability to outcompete native plants.',
    howToCare: 'Plant in partial shade with well-drained, slightly acidic soil. Water regularly to keep the soil moist, but not soggy. Protect from strong winds. Prune lightly to shape and remove dead branches.',

  ),
  Plantss(
    image: 'assets/images/Hakea-sericea.jpg',
    scientificName: 'Hakea gibbosa',
    commonName: 'Needlebush',
    category: 'Shrub',
     about: 'Azima tetracantha, commonly known as thorny azima, is a small shrub or tree native to tropical Africa, Asia, and Australia. It is characterized by its sharp thorns, small green leaves, and clusters of tiny white flowers. This plant is often used in traditional medicine for various purposes.',
   howToCare: 'Requires full sun and sandy, well-drained soil. Very drought-tolerant once established. Avoid overwatering. Prune after flowering to encourage compact growth and more blooms.',

  ),
  Plantss(
    image: 'assets/images/Dendrosenecio kilimanjari.jpg',
    scientificName: 'Dendrosenecio kilimanjari',
    commonName: 'Giant Groundsel',
    category: 'Perennial',
     about: 'Dendrosenecio kilimanjari, also known as the giant groundsel or Kilimanjaro senecio, is a species of flowering plant in the daisy family. It is native to the alpine zones of Mount Kilimanjaro in Tanzania and Mount Kenya in Kenya. This impressive plant can reach heights of up to 5 meters and is characterized by its large rosettes of silver-green leaves and clusters of yellow flowers at the top. It is well adapted to high altitudes and cold temperatures, making it a unique and iconic species in the East African mountains.',
   howToCare: 'Grows best in cool, high-altitude climates with rich, well-drained soil. Needs consistent moisture but avoid waterlogging. Provide protection from extreme heat or frost. Rarely needs fertilizing.',

  ),
  Plantss(
    image: 'assets/images/Discaria americana.webp',
    scientificName: 'Discaria americana',
    commonName: 'American willow',
    category: 'Shrub',
     about: 'Discaria americana, also known as American prairie thorn, is a deciduous shrub native to North America. It typically grows up to 6 feet tall and has thorny branches with small greenish-white flowers that bloom in spring. The plant produces small red fruits that are attractive to birds. It is commonly found in prairies, savannas, and open woodlands.',
    howToCare: 'Prefers full sun to partial shade. Tolerates dry, rocky soils. Water moderately, especially during prolonged dry periods. Prune occasionally to maintain shape and remove any damaged branches.',

  ),
];

// ويدجت صفحة التصنيف
class ShrubScreen extends StatelessWidget {
  const ShrubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shurbs', style: TextStyle(color: Colors.teal[900])),
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
              itemCount: Shrubs.length,
              itemBuilder: (context, index) {
                final plant = Shrubs[index];
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
