import 'package:flutter/material.dart';
import 'tasks.dart';
import 'profile.dart';
import 'health.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Студентський Портал')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text(
              'Вітаємо у вашому помічнику!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Тут ви можете керувати завданнями, переглядати профіль та стежити за здоров\'ям.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildMenuButton(context, 'Завдання та Дедлайни', Icons.list_alt, const TasksScreen()),
            _buildMenuButton(context, 'Профіль Студента', Icons.person, const ProfileScreen()),
            _buildMenuButton(context, 'Здоров\'я та Фокус', Icons.health_and_safety, const HealthScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }
}