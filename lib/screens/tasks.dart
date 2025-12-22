import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Додайте intl: ^0.19.0 у pubspec.yaml для форматування

class Task {
  String title;
  String deadline;
  String description;
  Task(this.title, this.deadline, this.description);
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _tasks = [
    Task('Лабораторна №1', '20.12.2025', 'Виконати практичну роботу на Flutter.'),
  ];

  void _addNewTask() {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String? localErrorMessage; // Змінна для збереження тексту помилки

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20, right: 20, top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ЗАГОЛОВОК ТА ПОПЕРЕДЖЕННЯ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Нове завдання", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),

            // БЛОК ПОПЕРЕДЖЕННЯ (З'являється над полями введення)
            if (localErrorMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        localErrorMessage!,
                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Назва завдання", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Дедлайн",
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  setModalState(() {
                    dateController.text = DateFormat('dd.MM.yyyy').format(pickedDate);
                    localErrorMessage = null; // Приховуємо помилку при виборі
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              maxLines: 2,
              decoration: const InputDecoration(labelText: "Опис", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Перевірка всіх полів
                  if (titleController.text.trim().isEmpty || 
                      dateController.text.isEmpty || 
                      descController.text.trim().isEmpty) {
                    setModalState(() {
                      localErrorMessage = "Будь ласка, заповніть усі поля!";
                    });
                    return;
                  }

                  setState(() {
                    _tasks.add(Task(
                      titleController.text, 
                      dateController.text, 
                      descController.text
                    ));
                  });
                  Navigator.pop(context);
                },
                child: const Text("Зберегти завдання"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Завдання та Дедлайни')),
      body: ListView.builder(
        itemCount: _tasks.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) => Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(_tasks[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_tasks[index].description),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer, size: 16, color: Colors.red),
                Text(_tasks[index].deadline, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
            ),
            onLongPress: () => setState(() => _tasks.removeAt(index)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        backgroundColor: Colors.indigo,
        // Змінюємо Icons.add_task на Icons.add
        child: const Icon(Icons.add, color: Colors.white, size: 28), 
      ),
    );
  }
}