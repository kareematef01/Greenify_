import 'package:flutter/material.dart';
import 'package:please_work/screens/categroisDetails.dart';

// موديل النبات
import '../model/plantss.dart';

// بيانات ثابتة لنباتات التصنيف

final List<Plantss> Succulents = [
  Plantss(
    image: 'assets/images/carrionCctus.jpg',
    scientificName: 'Peniocereus striatus',
    commonName: 'Carrion Cactus',
    category: 'Cactus',
    about: 'Peniocereus striatus, also known as the night-blooming cereus, is a species of cactus that produces large white flowers that bloom at night. It is native to the deserts of the southwestern United States and northern Mexico. The plant has long, slender stems with prominent ribs and spines, and it is well adapted to arid environments. The night-blooming cereus is often grown as an ornamental plant for its striking nocturnal blooms.',
   howToCare: 'Plant in sandy, well-drained soil with full sun exposure. Water sparingly; allow soil to dry completely between waterings. Protect from frost and cold drafts. Use cactus fertilizer during growing season.',

  ),
  Plantss(
    image: 'assets/images/texas.jpg',
    scientificName: 'coryphantha erecta',
    commonName: 'Texas nipple cactus',
    category: 'cacuts',
    about: 'Coryphantha erecta is a species of cactus native to Mexico. It is a small, globular cactus with green stems covered in white spines. In the spring, it produces small yellow flowers. This cactus is commonly grown as an ornamental plant in gardens and containers.',
   howToCare: 'Requires full sunlight and excellent drainage. Water deeply but infrequently—only when the soil is completely dry. Withstand drought very well. Avoid humidity and frost. Use a cactus mix for potting.',

  ),
  Plantss(
    image: 'assets/images/airplant.jpg',
    scientificName: 'tillandisa gymnobotrya',
    commonName: 'Gaint airplant',
    category: 'Airplant',
    about: 'Tillandsia gymnobotrya is a species of air plant that is native to Central America. It has thin, wiry leaves that curl and twist as they grow, giving it a unique appearance This plant is epiphytic, meaning it grows without soil and absorbs nutrients and water through its leaves. Tillandsia gymnobotrya produces colorful flowers that range from pink to purple, adding a pop of color to its surroundings.',
   howToCare: 'Place in bright, indirect sunlight or filtered light. Mist with water 2–3 times a week or soak for 20–30 minutes once a week. Allow to dry completely before placing back. Ensure good air circulation.',

  ),
  Plantss(
    image: 'assets/images/Pachycereus-weberi.jpg',
    scientificName: 'Pachycereus weberi',
    commonName: 'Weber pachycereus',
    category: 'Cactus',
    about: 'Pachycereus weberi, also known as Weber\'s pachycereus or Sonoran cardon, is a large columnar cactus native to Mexico. It has a thick trunk covered in spines and can grow up to 15 meters tall. This cactus produces white flowers and edible red fruits, and is commonly found in arid regions.',
   howToCare: 'Needs full sun and well-draining sandy soil. Water infrequently, especially during cooler months. Extremely drought-tolerant. Feed with a balanced cactus fertilizer once per month in spring and summer.',

  ),
];

// ويدجت صفحة التصنيف
class SuccluentsScreen extends StatelessWidget {
  const SuccluentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Succluents and Cacti', style: TextStyle(color: Colors.teal[900])),
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
              itemCount: Succulents.length,
              itemBuilder: (context, index) {
                final plant = Succulents[index];
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
