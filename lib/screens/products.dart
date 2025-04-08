import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/button_delete.dart';
import '../widgets/button_update.dart';
import 'package:tarea_14_database/screens/add_product.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // Obtenemos productos como Future
  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    return snapshot.docs;
  }

  // Muestra diálogo para editar nombre
  void showEditDialog(String productId, String currentName) {
    final TextEditingController _newNameController =
        TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar producto"),
        content: TextFormField(
          controller: _newNameController,
          decoration: const InputDecoration(labelText: "Nuevo nombre"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          BottonUpdate(
            productId: productId,
            newName: _newNameController.text.trim(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Añadir producto',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddProduct()),
              ).then((_) {
                if (mounted) {
                  setState(() {}); // ✅ Solo si aún está en pantalla
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay productos disponibles.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productId = product.id;
              final name = product['name'] ?? '';
              final price = product['price'] ?? 0;
              final available = product['available'] ?? false;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(name),
                  subtitle: Text('Precio: \$${price.toString()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BottonUpdate(
                        productId: productId,
                        newName: name, // editable en el diálogo
                      ),
                      ButtonDelete(productId: productId),
                    ],
                  ),
                  leading: Icon(
                    available ? Icons.check_circle : Icons.cancel,
                    color: available ? Colors.green : Colors.red,
                  ),
                  onTap: () => showEditDialog(productId, name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
