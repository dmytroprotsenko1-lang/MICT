import 'package:flutter/material.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final List<Map<String, dynamic>> _habits = [
    {'title': 'Випити воду', 'completed': false},
    {'title': 'Вправи для очей', 'completed': false},
  ];

  void _addHabit() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Нова корисна звичка"),
        content: TextField(controller: controller, decoration: const InputDecoration(hintText: "Наприклад: Розминка")),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _habits.add({'title': controller.text, 'completed': false});
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Додати"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health & Focus')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Твій прогрес сьогодні:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (context, index) => CheckboxListTile(
                title: Text(_habits[index]['title']),
                value: _habits[index]['completed'],
                onChanged: (val) => setState(() => _habits[index]['completed'] = val),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        backgroundColor: Colors.green,
        child: const Icon(Icons.health_and_safety),
      ),
    );
  }
}