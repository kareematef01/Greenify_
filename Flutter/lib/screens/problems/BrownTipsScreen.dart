import 'package:flutter/material.dart';
import 'package:please_work/screens/scan_screen.dart';

class BrownTipsScreen extends StatelessWidget {
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
                'assets/images/Brown Tips.jpg',
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
                    "Brown Tips or Edges on Leaves",
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
                    "Brown tips or edges on leaves can result from underwatering, over-fertilization, or low humidity. It may also indicate salt buildup in the soil.",
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
                    "Maintain consistent watering, ensuring water penetrates the root zone without causing waterlogged conditions.Flush the soil periodically to remove excess salts.Increase humidity around the plant by misting or using a humidifier. Adjust fertilizer application to avoid over-fertilization Protect your",
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
