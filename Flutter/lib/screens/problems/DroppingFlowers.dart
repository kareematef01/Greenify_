import 'package:flutter/material.dart';
import 'package:please_work/screens/scan_screen.dart';

class DroppingFlowers extends StatelessWidget {
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
                'assets/images/dropping.jpg',
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
                    "Yellowing or Dropping Flowers",
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
                    "Yellowing or dropping flowers can occur due to various stress factors, including temperature fluctuations, inadequate light, overwatering, or underwatering.",
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
                    "To prevent yellowing or dropping flowers, ensure plants receive appropriate light levels for their species and requirements.Maintain consistent watering, allowing the soil to dry out slightly between waterings to prevent overwatering. Protect plants from extreme temperatures and environmental stressors by providing shade during the hottest part of the day and minimizing exposure to drafts or cold temperatures",
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
