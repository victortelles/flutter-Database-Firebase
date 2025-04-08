import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottonUpdate extends StatelessWidget {
  final String productId;
  final String newName;
  final int newPrice;
  final bool newAvailable;

  const BottonUpdate({
    super.key,
    required this.productId,
    required this.newName,
    required this.newPrice,
    required this.newAvailable,
  });


  //Funcion update
  Future<void> updateProduct(String productId, String newName, int newPrice, bool newAvailable){
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    return products.doc(productId).update({'name': newName, 'price': newPrice, 'available': newAvailable})
      .then((value) => print('Product name updated successfully'))
      .catchError((error) => print('Failed to update product name: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit, color: Colors.blue),
      tooltip: "Editar",
      onPressed: () async {
        await updateProduct(productId, newName, newPrice, newAvailable);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto actualizado con éxito.')),
        );
      },
    );
  }
}

