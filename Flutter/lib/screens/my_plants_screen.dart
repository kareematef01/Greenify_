import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:please_work/screens/SetReminder.dart';
import 'package:please_work/screens/search_by_name_screen.dart';
import 'package:please_work/screens/scan_screen.dart';
import '../model/reminder_model.dart' as model;
import '../model/local_plant.dart';
import '../model/plant.dart' as model;

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({Key? key}) : super(key: key);

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  int selectedTab = 0;
  List<LocalPlant> myPlants = [];
  List<model.Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    loadPlants();
    loadReminders();
  }

  Future<void> loadPlants() async {
    final box = await Hive.openBox('myPlants');
    myPlants = box.values.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return LocalPlant.fromMap(map);
    }).toList();

    setState(() {});
  }

  Future<void> savePlant(LocalPlant plant) async {
    final box = await Hive.openBox('myPlants');
    await box.add(plant.toMap());
    await loadPlants();
  }

  Future<void> deletePlant(int index) async {
    final box = await Hive.openBox('myPlants');
    final key = box.keyAt(index);
    await box.delete(key);
    await loadPlants();
  }

  void showDeletePlantDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Plant"),
        content: const Text("Are you sure you want to delete this plant?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deletePlant(index);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> loadReminders() async {
    final box = await Hive.openBox('reminders');

    reminders = box.values.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return model.Reminder(
        plant: map['plant'] ?? 'Unknown plant',
        remindAbout: map['task'] ?? 'Unknown task',
        repeat: map['repeat'] ?? 'Never',
        dateTime: DateTime(0, 0, 0, map['hour'] ?? 0, map['minute'] ?? 0),
      );
    }).toList();

    setState(() {});
  }

  void _showAddPlantOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Add Plant",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    _buildOption(
                      icon: Icons.camera_alt_outlined,
                      text: "Identify by photo",
                      onTap: () async {
                        Navigator.pop(context);
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScanScreen()),
                        );
                        if (result != null && result is model.Plant) {
                          await savePlant(
                            LocalPlant(
                              name: result.commonName,
                              imagePath: result.imageUrls.isNotEmpty ? result.imageUrls[0] : '',
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildOption(
                      icon: Icons.search,
                      text: "Search by name",
                      onTap: () async {
                        Navigator.pop(context);
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchByNameScreen()),
                        );
                        if (result != null && result is model.Plant) {
                          await savePlant(
                            LocalPlant(
                              name: result.commonName,
                              imagePath: result.imageUrls.isNotEmpty ? result.imageUrls[0] : '',
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteReminder(int index) async {
    final box = await Hive.openBox('reminders');
    final key = box.keyAt(index);
    await box.delete(key);
    await loadReminders();
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Reminder"),
        content: const Text("Are you sure you want to delete this reminder?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteReminder(index);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: TabSelector(label: 'My Garden', isActive: selectedTab == 0),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: TabSelector(label: 'Reminders', isActive: selectedTab == 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: selectedTab == 0 ? buildMyGarden() : buildReminders(),
          ),
        ],
      ),
    );
  }

  Widget buildMyGarden() {
    return Column(
      children: [
        Expanded(
          child: myPlants.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "No plants in your library 😔",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("Tap the button below to add your first plant",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: myPlants.length,
                  itemBuilder: (context, index) {
                    final plant = myPlants[index];
                    return GestureDetector(
                      onLongPress: () => showDeletePlantDialog(index),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: plant.imagePath.startsWith('http')
                                  ? Image.network(
                                      plant.imagePath,
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                                    )
                                  : const Icon(Icons.image_not_supported,
                                      size: 100, color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                plant.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              _showAddPlantOptions(context);
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Plant"),
          ),
        ),
      ],
    );
  }

  Widget buildReminders() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetReminderScreen()),
              ).then((value) {
                if (value == true) {
                  loadReminders();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.alarm, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Add Reminder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: reminders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.alarm_on, size: 60),
                      SizedBox(height: 20),
                      Text(
                        "No reminders yet!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "You can set watering and care reminders here.",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminders[index];
                    return GestureDetector(
                      onLongPress: () => showDeleteDialog(index),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          title: Text('${reminder.plant} - ${reminder.remindAbout}'),
                          subtitle: Text('Repeat: ${reminder.repeat} at ${reminder.dateTime.hour}:${reminder.dateTime.minute.toString().padLeft(2, '0')}'),
                          leading: const Icon(Icons.alarm),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class TabSelector extends StatelessWidget {
  final String label;
  final bool isActive;

  const TabSelector({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
