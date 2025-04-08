import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottonUpdate extends StatelessWidget {
  final String productId;
  final String newName;

  const BottonUpdate({
    super.key,
    required this.productId,
    required this.newName,
  });


  //Funcion update
  Future<void> updateProduct(String productId, String newName){
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    return products.doc(productId).update({'name': newName})
      .then((value) => print('Product name updated successfully'))
      .catchError((error) => print('Failed to update product name: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit, color: Colors.blue),
      tooltip: "Editar",
      onPressed: () async {
        await updateProduct(productId, newName);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto actualizado con éxito.')),
        );
      },
    );
  }
}

