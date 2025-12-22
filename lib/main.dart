import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Обов'язково додайте цей імпорт
import 'screens/home.dart';

void main() {
  // 1. Гарантуємо, що віджети ініціалізовані перед викликом системних команд
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Фіксуємо орієнтацію (тільки портретна вгору)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const StudentPortalApp());
  });
}

class StudentPortalApp extends StatelessWidget {
  const StudentPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Portal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}