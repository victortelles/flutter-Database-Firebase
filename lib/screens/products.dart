import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/button_update.dart';   //Widget para boton Actualizar
import '../widgets/button_delete.dart';   //Widget para boton Eliminar
import '../widgets/button_create.dart';   //Widget para redireccion ala pantalla de crear
import '../screens/add_product.dart';     //Pagina con formulario para crear

class Products extends StatelessWidget {
  const Products({super.key});

  //Extraccion de datos
  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();
    return snapshot.docs;
  }

  @override
  //Construir el boddy
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProduct())
              );
            },
            tooltip: "Añadir Producto",
          ),
        ],
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //Mostrar en pantalla si no hay productos, dejar mensaje
          if (snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay productos registrados'),
            );
          }

          //Mostrar productos
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final data = product.data() as Map<String, dynamic>;

              //Devolver cards
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text("Precio: \$${data['price']} | Disponible: ${data['available'] ? 'Si' : 'No'}"),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.min,
                    children: [
                      ButtonUpdate(productId: product.id, productData: data),
                      const SizedBox(width: 8,),
                      ButtonDelete(productId: product.id),
                    ]
                  ),
                ),
              );
            },
          );
        }
      )
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