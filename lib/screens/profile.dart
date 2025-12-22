import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Іван Іваненко";
  String specialty = "Computer Science";

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController specController = TextEditingController(text: specialty);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Редагувати профіль"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "ПІБ")),
            TextField(controller: specController, decoration: const InputDecoration(labelText: "Спеціальність")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Відміна")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                name = nameController.text;
                specialty = specController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Зберегти"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Цифрова Картка'),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: _editProfile)],
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 60, backgroundColor: Colors.indigo, child: Icon(Icons.person, size: 50, color: Colors.white)),
                const SizedBox(height: 20),
                Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Спеціальність: $specialty', style: const TextStyle(color: Colors.grey)),
                const Divider(height: 30),
                _buildInfoRow(Icons.email, 'ivan.i@university.edu.ua'),
                _buildInfoRow(Icons.badge, 'ID: 12345678'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [Icon(icon, color: Colors.indigo, size: 20), const SizedBox(width: 10), Text(text)]),
    );
  }
}