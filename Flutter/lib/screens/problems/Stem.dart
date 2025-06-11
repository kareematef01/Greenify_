import 'package:flutter/material.dart';
import 'package:please_work/screens/scan_screen.dart';

class Stem extends StatelessWidget {
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
                'assets/images/Stem.jpg',
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
                    "Stem or Crown Rot",
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
                    "Stem or crown rot is a fungal disease that affects the base of the plant, including the stems, crown, and root zone. It is often caused by overwatering, poor drainage, or injury to the plant",
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
                    "To prevent stem or crown rot, improve soil drainage by using well-draining potting mix or amending garden soil with organic matter. Avoid overwatering and allow the soil to dry out slightly between waterings.Remove affected plant parts promptly to prevent the spread of disease and treat with fungicides if necessary.",
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
