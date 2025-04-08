import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarea_14_database/screens/products.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea 14',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Products(),
    );
  }
}
