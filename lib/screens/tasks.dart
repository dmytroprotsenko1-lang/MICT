import 'package:flutter/material.dart';

class Task {
  final String title;
  final String deadline;
  final String desc;
  const Task(this.title, this.deadline, this.desc);
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  final List<Task> tasks = const [
    Task('Лабораторна №1', '20.12.2023', 'Розробка UI на Flutter'),
    Task('Курсова робота', '15.01.2024', 'Проектування архітектури ПЗ'),
    Task('Тест з Англійської', '25.12.2023', 'Модуль 4: Технічний переклад'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      app_bar: AppBar(title: const Text('Дедлайни')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.book)),
              title: Text(tasks[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(tasks[index].desc),
              trailing: Text(tasks[index].deadline, style: const TextStyle(color: Colors.red)),
            ),
          );
        },
      ),
    );
  }
}