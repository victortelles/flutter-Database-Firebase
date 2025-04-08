import 'package:flutter/material.dart';
import 'package:tarea_14_database/screens/products.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Database',
      home: const Products(),
    );
  }
}