import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String, String) addTaskCallback;

  AddTaskScreen({required this.addTaskCallback});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _zadatak = TextEditingController();
  String _prioritet = 'Niski';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novi Zadatak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _zadatak,
              decoration: InputDecoration(labelText: 'Zadatak'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _prioritet,
              items: ['Visoki', 'Srednji', 'Niski'].map((String priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _prioritet = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Priority'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.addTaskCallback(_zadatak.text, _prioritet);
                Navigator.pop(context);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}