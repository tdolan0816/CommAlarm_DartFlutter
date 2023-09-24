import 'package:flutter/material.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Picker with Custom Buttons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Time: ${selectedTime.format(context)}',
              style: const  TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showCustomTimePicker(context);
              },
              child: const Text('Open Custom Time Picker'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCustomTimePicker(BuildContext context) async {
    TimeOfDay? pickedTime;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Time'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Customize the content of the dialog as per your requirement
              // You can add additional buttons, widgets, or any UI elements here
              Text('Custom Time Picker Content'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Custom Button 1'),
            ),
            TextButton(
              onPressed: () {
                pickedTime = selectedTime; // Assign the selected time
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime!;
      });
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: TimePickerPage(),
  ));
}