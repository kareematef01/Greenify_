import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';

// موديل النبات
import '../model/plantss.dart';

// بيانات ثابتة لنباتات التصنيف
final List<Plantss> LeafPlants = [
  Plantss(
    image: 'assets/images/oxalis.jpg',
    scientificName: 'Oxalis Palmiforns',
    commonName: 'palm-fruited woodsorrel',
    category: 'Flowering plant',
    about: 'Oxalis palmifrons, commonly known as the palmleaf woodsorrel, is a species of flowering plant in the Oxalidaceae family. It is native to South Africa and has distinctive palm-like leaves with a green color and a reddish underside. The plant produces small yellow flowers and is often grown as an ornamental plant in gardens or as a houseplant.',
   howToCare: 'Place in bright, indirect sunlight. Water moderately, allowing the topsoil to dry out slightly between waterings. Avoid overwatering to prevent root rot. Keep in a cool, well-ventilated space. Trim dead leaves regularly.',

  ),
  Plantss(
    image: 'assets/images/flatStemmed.jpg',
    scientificName: 'Potamogeton epihydrus',
    commonName: 'Flat-stemmed ponweed',
    category: 'flowering plant ',
    about: 'Potamogeton epihydrus, also known as creeping pondweed, is an aquatic plant species belonging to the Potamogetonaceae family. It ischaracterized by its creeping stems that can form dense mats in shallow water habitats.The leaves are linear and alternate along the stem, with a smooth texture and a distinct midrib. This plant is commonly found in ponds, lakes, and slow-moving streams across North America, where it provides important habitat and food for aquatic organisms.',
   howToCare: 'Grow in shallow, still or slow-moving freshwater such as ponds or aquariums. Ensure good water quality and full sunlight. No soil needed; anchor the roots with gravel. Prune excess growth to prevent overpopulation.',

  ),
  Plantss(
    image: 'assets/images/Tectaria_heracleifolia5.jpg',
    scientificName: 'Tectaria heracleifolia',
    commonName: 'Lace Fern',
    category: 'Fern',
    about: 'Tectaria heracleifolia is a fern species that is native to Asia, specifically found in countries like China, Japan, Korea, and Taiwan. It is known for its distinctive triangular fronds that are deeply lobed and resemble a birds foot, hence its common name Birds Foot Fern This fern prefers shaded and moist environments, making it a popular choice for indoor plant enthusiasts looking to add a unique and striking foliage to their collection.',
    howToCare: 'Keep in partial to full shade with high humidity. Water regularly to keep the soil moist but not soggy. Use well-draining, rich soil. Mist leaves to maintain humidity. Avoid direct sun exposure to prevent leaf burn.',

  ),
  Plantss(
    image: 'assets/images/coleusGraveolens.jpg',
    scientificName: 'Coleus graveolens',
    commonName: 'Plectranthus amboinicus',
    category: 'Flowering plant',
    about: 'Coleus graveolens, also known as Indian borage or Spanish thyme, is a small succulent plant with fleshy leaves that are green with purple undersides. It is native to parts of Africa and Asia and is commonly grown as a culinary herb for its aromatic leaves. It is also used in traditional medicine for various ailments.',
   howToCare: 'Place in bright, indirect light or partial sun. Water moderately, allowing the soil to dry slightly between waterings. Use well-draining soil and avoid waterlogging. Pinch the growing tips to encourage bushier growth. Can be grown indoors or outdoors in warm climates.',

  ),
];

// ويدجت صفحة التصنيف
class LeafsScreen extends StatelessWidget {
  const LeafsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaf Plants', style: TextStyle(color: Colors.teal[900])),
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
              itemCount: LeafPlants.length,
              itemBuilder: (context, index) {
                final plant = LeafPlants[index];
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
