import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Reminder {
  final String plant;
  final String task;
  final String repeat;
  final TimeOfDay time;

  Reminder({
    required this.plant,
    required this.task,
    required this.repeat,
    required this.time,
  });

  String formatTime() {
    final hourStr = time.hourOfPeriod.toString().padLeft(2, '0');
    final minuteStr = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hourStr:$minuteStr $period';
  }
}

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({Key? key}) : super(key: key); // ✅ شلنا plantName

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  String? selectedPlant;
  String? remindAbout;
  String? repeat;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isAM = true;

  void pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        isAM = picked.period == DayPeriod.am;
      });
    }
  }

  void showSelectionDialog({
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                onSelected(option);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget buildOptionTile(String title, String? value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              value ?? 'Select',
              style: TextStyle(
                color: value == null ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isFormValid {
    return selectedPlant != null && remindAbout != null && repeat != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Set Reminder',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildOptionTile('Plant', selectedPlant, () {
              showSelectionDialog(
                options: ['Aloe Vera', 'Snake Plant', 'Peace Lily', 'Rose'],
                onSelected: (plant) {
                  setState(() {
                    selectedPlant = plant;
                  });
                },
              );
            }),
            buildOptionTile('Remind me about', remindAbout, () {
              showSelectionDialog(
                options: ['Watering', 'Fertilizing', 'Pruning', 'Repotting'],
                onSelected: (about) {
                  setState(() {
                    remindAbout = about;
                  });
                },
              );
            }),
            buildOptionTile('Repeat', repeat, () {
              showSelectionDialog(
                options: ['Daily', 'Weekly', 'Monthly'],
                onSelected: (rep) {
                  setState(() {
                    repeat = rep;
                  });
                },
              );
            }),
            GestureDetector(
              onTap: pickTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Time', style: TextStyle(fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Text(
                          selectedTime.format(context),
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isAM ? "AM" : "PM",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormValid
                    ? () async {
                        final newReminder = Reminder(
                          plant: selectedPlant!,
                          task: remindAbout!,
                          repeat: repeat!,
                          time: selectedTime,
                        );

                        final reminderBox = await Hive.openBox('reminders');
                        await reminderBox.add({
                          'plant': newReminder.plant,
                          'task': newReminder.task,
                          'repeat': newReminder.repeat,
                          'hour': newReminder.time.hour,
                          'minute': newReminder.time.minute,
                        });

                        Navigator.pop(context, true); // عشان نرجع ونعمل reload
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid ? Colors.green : Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Turn On Reminder',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isFormValid ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
