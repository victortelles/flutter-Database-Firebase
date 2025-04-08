
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonDelete extends StatelessWidget {
  final String productId;

  const ButtonDelete({
    super.key,
    required this.productId
  });

  //Function delete
  Future<void> deleteProduct(String productId){
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    return products.doc(productId).delete()
      .then((value) => print('Product $productId deleted successfully!'))
      .catchError((error) => print('Failed to delete product: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      tooltip: "Eliminar",
      onPressed: () async {
        await deleteProduct(productId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto eliminado con éxito.')),
        );
      }
    );
  }
}


