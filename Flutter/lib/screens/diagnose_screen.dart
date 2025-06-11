import 'package:flutter/material.dart';
import 'package:please_work/screens/ask_expert_screen.dart';
import 'package:please_work/screens/problems/BrownTipsScreen.dart';
import 'package:please_work/screens/problems/DroppingFlowers.dart';
import 'package:please_work/screens/problems/EnvironmentalStress.dart';
import 'package:please_work/screens/problems/FungalRoot.dart';
import 'package:please_work/screens/problems/MoldProblemScreen.dart';
import 'package:please_work/screens/problems/PowderyMildew.dart';
import 'package:please_work/screens/problems/Stem.dart';
import 'package:please_work/screens/problems/YellowingLeavesScreen.dart';
import 'package:please_work/screens/scan_screen.dart';

class DiagnoseScreen extends StatelessWidget {
  final List<Map<String, dynamic>> commonProblems = [
    {
      "title": "Yellowing leaves (chlorosis)",
      "image": "assets/images/Yellowing Leaves.jpg",
      "page": YellowingLeavesScreen(),
    },
    {
      "title": "Brown tips or edges on leaves",
      "image": "assets/images/Brown Tips.jpg",
      "page": BrownTipsScreen(),
    },
    {
      "title": "Mold or fungal growth",
      "image": "assets/images/Mold.jpg",
      "page": MoldProblemScreen(),
    },
    {
      "title": "Yellowing or Dropping Flowers",
      "image": "assets/images/dropping.jpg",
      "page": DroppingFlowers(),
    },
    {
      "title": "Environmental Stress",
      "image": "assets/images/Environmental Stress.jpg",
      "page": EnvironmentalStress(),
    },
    {
      "title": "Stem or Crown Rot",
      "image": "assets/images/Stem.jpg",
      "page": Stem(),
    },
    {
      "title": "Fungal Root Rot",
      "image": "assets/images/Fungal Root Rot.jpg",
      "page": FungalRoot(),
    },
    {
      "title": "Powdery Mildew",
      "image": "assets/images/Powdery Mildew.jpg",
      "page": PowderyMildew(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnose"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card: Diagnose
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Diagnose",
                            style: theme.textTheme.titleLarge),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
  Navigator.pop(context); // أول حاجة نقفل الـ bottom sheet
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ScanScreen()),
  );
},
                          child: Text("Get Help"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset("assets/images/dee.png", width: 100),
                ],
              ),
            ),

            SizedBox(height: 24),
            Text("Common Problems",
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 20)),
            SizedBox(height: 12),

            // Common problems
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: commonProblems.map((problem) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => problem["page"]),
                      );
                    },
                    child: Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              problem["image"],
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(problem["title"],
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 32),

            // Ask AI Bot
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ask AI Botanist",
                            style: theme.textTheme.titleMedium),
                        SizedBox(height: 8),
                        Text("Get treatment advice",
                            style: theme.textTheme.bodyMedium),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AskExpertScreen()),
                            );
                          },
                          child: Text("Start Chat"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset("assets/images/pot.jpg", width: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
