import 'package:bmi_app/screens/history_screen.dart';
import 'package:bmi_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized() để đảm bảo Flutter binding đã được khỏi tạo
  // Cần đảm bảo môi trường đã sẵn sàng trước khi gọi các phương thức bất đồng bộ
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng đo chỉ số BMI',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (_) => const HomeScreen(),
        '/history': (_) => HistoryScreen(),
      },
      //home: const HomeScreen(),
    );
  }
}