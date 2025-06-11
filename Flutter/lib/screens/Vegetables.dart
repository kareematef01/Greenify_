import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';

// موديل النبات

import '../model/plantss.dart';
// بيانات ثابتة لنباتات التصنيف
final List<Plantss> Vegetables = [
  Plantss(
    image: 'assets/images/Physalis virginiana.jpg',
    scientificName: 'Physalis virginiana',
    commonName: 'Ground Cherry',
    category: 'Herbaceous plant',
    about: 'Physalis is a genus of flowering plants in the nightshade family (Solanaceae), which includes annual and perennial herbaceous plants. The most well-known species is Physalis peruviana, also known as cape gooseberry or goldenberry, which produces small, round fruits encased in a papery husk. Physalis plants are commonly grown for their edible fruit and ornamental value.',
   howToCare: 'Plant in full sun with well-drained, sandy or loamy soil. Water regularly but avoid soggy conditions. Apply mulch to retain moisture. Support the plant as it grows. Fertilize lightly during the growing season.',

  ),
  Plantss(
    image: 'assets/images/Brassica repanda.jpg',
    scientificName: 'Brassica repanda',
    commonName: 'Creeping mustard',
    category: 'Flowering plant',
    about: 'Brassica repanda, also known as Crepidifolium mustard, is a plant species in the Brassicaceae family. It is native to the Canary Islands and Madeira, and is typically found in rocky habitats. This plant produces yellow flowers and has lobed leaves with toothed margins.',
    howToCare: 'Grow in full sun with well-draining soil. Water moderately, keeping soil evenly moist. Tolerates poor soils but benefits from compost. Prune lightly to control spread. Watch for pests like aphids or flea beetles.',

  ),
  Plantss(
    image: 'assets/images/Cucurbita palmata.jpg',
    scientificName: 'Cucurbita palmata',
    commonName: 'Coyote Melon',
    category: 'Herbaceous plan',
    about: 'Cucurbita palmata, also known as coyote melon, is a species of gourd native to the southwestern United States and northern Mexico. It is a vine plant with lobed leaves and yellow flowers, producing small round fruits that are typically green with white stripes. The fruits are not typically consumed by humans due to their bitter taste, but they are an important food source for wildlife in the region.',
    howToCare: 'Thrives in full sun with dry, sandy or rocky soil. Very drought-tolerant—water sparingly. Do not over-fertilize. Needs room to sprawl. Ideal for xeriscaping or desert gardens.',

  ),
  Plantss(
    image: 'assets/images/Vicia ervilia.jpg',
    scientificName: 'Vicia ervilia',
    commonName: 'Bitter vetch',
    category: 'Flowering plant',
    about: 'Vicia ervilia, also known as bitter vetch, is a leguminous plant that is grown as a grain crop in some parts of the world. It is an annual plant with climbing stems, compound leaves, and purple or blue pea-like flowers. The seeds of Vicia ervilia are used for human consumption as well as for animal feed.',
    howToCare: 'Plant in full sun with fertile, well-drained soil. Water regularly but avoid overwatering. This plant fixes nitrogen, so limit fertilization. Provide support for climbing growth. Harvest before seed pods split.',

  ),
];

// ويدجت صفحة التصنيف
class vegetablesScreen extends StatelessWidget {
  const vegetablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('vegetables', style: TextStyle(color: Colors.teal[900])),
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
              itemCount: Vegetables.length,
              itemBuilder: (context, index) {
                final plant = Vegetables[index];
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
