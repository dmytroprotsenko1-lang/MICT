import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Дмитро Петренко";
  String group = "КН-301";
  String specialty = "Штучний Інтелект";
  String email = "real.email@nure.ua";
  String studentId = "№1413388";
  String description = "Хочу повстання машин.";

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController groupController = TextEditingController(text: group);
    TextEditingController descController = TextEditingController(text: description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Редагувати профіль"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController, 
                decoration: const InputDecoration(labelText: "ПІБ")
              ),
              const SizedBox(height: 10),
              TextField(
                controller: groupController, 
                decoration: const InputDecoration(labelText: "Група")
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Про себе",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Скасувати")
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                name = nameController.text;
                group = groupController.text;
                description = descController.text;
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
        title: const Text('Цифрова картка'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note), 
            onPressed: _editProfile,
            tooltip: "Редагувати дані",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.indigo, width: 3),
                      image: const DecorationImage(
                        image: AssetImage('lib/assets/student_photo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(group, style: const TextStyle(fontSize: 18, color: Colors.indigo, fontWeight: FontWeight.w500)),
                  const Divider(indent: 40, endIndent: 40, height: 40),
                  _buildProfileInfo(Icons.school, specialty),
                  _buildProfileInfo(Icons.email, email),
                  _buildProfileInfo(Icons.badge, studentId),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 22),
          const SizedBox(width: 15),
          Expanded(child: Text(info, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}