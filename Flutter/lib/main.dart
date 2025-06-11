import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:please_work/home_screen.dart';
import 'package:please_work/screens/diagnose_screen.dart';
import 'package:please_work/screens/scan_screen.dart';
import 'package:please_work/screens/ask_expert_screen.dart';
import 'package:please_work/screens/my_plants_screen.dart';
import 'package:please_work/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // فتح صندوق التذكيرات كمخزن بيانات من نوع Map
  await Hive.openBox('reminders');
  await Hive.openBox('myPlants');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    DiagnoseScreen(),
    ScanScreen(),
    AskExpertScreen(),
    MyPlantsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: "Diagnose"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: "Ask Expert"),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: "My Plants"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
