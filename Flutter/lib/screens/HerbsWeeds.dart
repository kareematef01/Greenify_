import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';
import '../model/plantss.dart';






// بيانات ثابتة لنباتات التصنيف
final List<Plantss> HerbsANDWeeds= [
  Plantss(
    image: 'assets/images/Pacific blackberry12.jpg', 
    scientificName: ' Rubus rudis',
    commonName: 'Pacific blackberry',
    category: 'Genus ',
    about: 'Rubus rudis, commonly known as the mountain blackberry, is a species of flowering plant in the rose family. It is native to western North America, specifically found in the coastal regions from British Columbia to California. The mountain blackberry produces edible black berries and is often found in mountainous and forested areas.',
    howToCare: 'Plant in full sun with well-drained soil. Water moderately, allowing the soil to dry slightly between waterings. Prune regularly to remove dead canes and promote healthy growth. Mulch around the base to retain moisture and suppress weeds.',
  ),
  Plantss(
    image: 'assets/images/Rough bentgrass.jpg',
    scientificName: ' Agrostis scabra',
    commonName: 'Rough bentgrass',
    category: 'Grass',
    about: 'Agrostis scabra, commonly known as rough bentgrass, is a species of grass native to North America. It is a cool-season perennial grass with fine leaves and a spreading growth habit. It is often found in moist meadows, marshes, and along stream banks. Rough bentgrass is commonly used for erosion control and habitat restoration projects.',
    howToCare: 'Grow in full sun to partial shade. Keep the soil consistently moist but not waterlogged. It adapts to a variety of soils and is tolerant of poor conditions. Mow or trim to maintain appearance, especially if used in landscaping or restoration projects.',
  ),
  Plantss(
   image: 'assets/images/Nuttall\'s sandwort.jpg',
    scientificName: 'Eremogone capillaris',
    commonName: 'Nuttalls sandwort',
    category: 'Genus',
    about: 'Eremogone capillaris, also known as fineleaf sandwort, is a small flowering plant native to North America. It belongs to the Caryophyllaceae family and typically grows in sandy or rocky habitats. The plant produces tiny white flowers with five petals and has narrow, needle-like leaves.Eremogone capillaris is commonly found in dry, open areas such as grasslands, prairies, and dunes',
    howToCare: 'Plant in well-drained, sandy or rocky soil. Prefers full sun exposure. Water sparingly, as it is drought-tolerant once established. Avoid overly rich soils or heavy watering, as it thrives in dry conditions.',
  ),
  Plantss(
    image: 'assets/images/Michauxs wormwood.jpg',
    scientificName: 'Artemisia michauxiana',
    commonName: 'Michauxs wormwood',
    category: 'Artemisia',
    about: 'Artemisia michauxiana, also known as Michaux wormwood, is a perennial herbaceous plant native to North America.It belongs to the Asteraceae family and typically grows in dry, rocky habitats such as prairies, open woods, and roadsides. The plant has silvery-gray foliage with a strong aromatic scent and produces small yellow flowers in late summer. Artemisia michauxiana is often used in traditional medicine and as an ornamental plant in gardens.',
    howToCare: 'Thrives in dry, well-drained soils with full sun. Water occasionally, especially during prolonged dry periods. Avoid excessive watering to prevent root rot. This plant is low-maintenance and tolerant of poor soils and drought.',
  ),
];


// ويدجت صفحة التصنيف
class  HerbsWeeds extends StatelessWidget {
  const HerbsWeeds ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Herbs & Weeds', style: TextStyle(color: Colors.teal[900])),
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
              itemCount: HerbsANDWeeds.length,
              itemBuilder: (context, index) {
                final plant = HerbsANDWeeds[index];
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
