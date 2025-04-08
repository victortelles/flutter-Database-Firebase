import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonCreate extends StatelessWidget {
  //variables
  final String name;
  final int price;
  final bool available;

  const ButtonCreate({
    super.key,
    required this.name,
    required this.price,
    required this.available,
  });

  //Function Create product
  Future<void> addProduct(String name, int price, bool available){
    CollectionReference products =  FirebaseFirestore.instance.collection('products');

    return products.add({
      'name': name,
      'price': price,
      'available': available
    })
    .then((value) => print('Product added successfully'))
    .catchError((error) => print('Failed to add product: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await addProduct(name, price, available);
        Navigator.pop(context); // regresar a la pantalla anterior
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Producto creado con éxito")),
        );
      },
      child: const Text("Crear Producto"),
    );
  }
}

