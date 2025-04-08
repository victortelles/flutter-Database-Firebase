import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('No hay productos'),
        ]
      ),
    );
  }
}

//Function Get a product
/*
Future<void> getProducts(){
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  return products.get()
    .then((QuerySnapshot snapshot){
      snapshot.docs.forEach((doc) {
        print('${doc.id} => ${doc.data()}');
      });
    })
    .catchError((error) => print('Failed to fetch products: $error'));
}

*/