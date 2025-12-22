import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  String title;
  String deadline;
  String description;
  String category;
  Color color;

  Task(this.title, this.deadline, this.description, this.category,
      {this.color = Colors.red});
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _tasks = [
    Task('Курсова робота', '25.12.2025', 'Захист проекту по мобільній розробці', 'Проєкт', color: Colors.blue),
  ];

  final List<String> _categories = ['Навчання', 'Проєкт', 'Важливо'];
  String _selectedCategory = 'Навчання';

  // Вікно дій для всього завдання
  void _showActionDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Завдання: ${_tasks[index].title}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Змінити колір дедлайну:"),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _colorCircle(index, Colors.red),
                _colorCircle(index, Colors.orange),
                _colorCircle(index, Colors.blue),
                _colorCircle(index, Colors.green),
              ],
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() => _tasks.removeAt(index));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            label: const Text("Видалити", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Закрити"),
          ),
        ],
      ),
    );
  }

  Widget _colorCircle(int index, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() => _tasks[index].color = color);
        Navigator.pop(context);
      },
      child: CircleAvatar(backgroundColor: color, radius: 18),
    );
  }

  void _addNewTask() {
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController descController = TextEditingController();
    String? localErrorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20, right: 20, top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Новий запис", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (localErrorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(localErrorMessage!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 15),
              TextField(controller: titleController, decoration: const InputDecoration(labelText: "Назва", border: OutlineInputBorder())),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: "Категорія", border: OutlineInputBorder()),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setModalState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Дедлайн", prefixIcon: Icon(Icons.calendar_month), border: OutlineInputBorder()),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime.now(), 
                    lastDate: DateTime(2030)
                  );
                  if (picked != null) {
                    setModalState(() => dateController.text = DateFormat('dd.MM.yyyy').format(picked));
                  }
                },
              ),
              const SizedBox(height: 10),
              TextField(controller: descController, decoration: const InputDecoration(labelText: "Опис", border: OutlineInputBorder())),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, padding: const EdgeInsets.all(15)),
                  onPressed: () {
                    if (titleController.text.isEmpty || dateController.text.isEmpty || descController.text.isEmpty) {
                      setModalState(() => localErrorMessage = "Заповніть усі поля!");
                      return;
                    }
                    setState(() {
                      _tasks.add(Task(titleController.text, dateController.text, descController.text, _selectedCategory));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Додати"),
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
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: task.color.withOpacity(0.5), width: 1),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            // Обгортаємо ListTile в InkWell для клікабельності всієї області
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => _showActionDialog(index), // Тепер клікабельна вся картка
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: task.color.withOpacity(0.1),
                      child: Icon(_getIcon(task.category), color: task.color),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.description,
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Блок дедлайну
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: task.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: task.color),
                      ),
                      child: Text(
                        task.deadline,
                        style: TextStyle(color: task.color, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  IconData _getIcon(String category) {
    if (category == 'Важливо') return Icons.priority_high;
    if (category == 'Проєкт') return Icons.assignment;
    return Icons.school;
  }
}