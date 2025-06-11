import 'package:flutter/material.dart';
import 'package:please_work/screens/scan_screen.dart';

class MoldProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ✅ الصورة الرئيسية فوق (SliverAppBar)
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/Mold.jpg',
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ عنوان المشكلة
                  Text(
                    "Mold or Mildew Growth",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 24),

                  // ✅ قسم About
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "About",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Mold and mildew thrive in humid conditions with poor air circulation. They appear as white or gray powdery patches on leaves or stems.",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 24),

                  // ✅ قسم How to Care
                  Row(
                    children: [
                      Icon(Icons.eco_outlined, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "How to Care",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Improve air circulation around the plant by spacing plants properly and removing debris. Avoid overhead watering, as excess moisture can promote fungal growth. Prune affected areas and treat with fungicides containing neem oil or copper if necessary.",
                  ),
                  SizedBox(height: 32),

                  // ✅ زر Diagnose
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Protect your plant ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: "against diseases",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                           Navigator.pop(context); // أول حاجة نقفل الـ bottom sheet
                          Navigator.push(
                                  context,
                             MaterialPageRoute(builder: (context) => const ScanScreen()),
                                         );
                                          },

                            icon: Icon(Icons.add),
                            label: Text("Diagnose your plant"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: StadiumBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
