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

  // Muestra diálogo para editar nombre, precio y disponibilidad
  void showEditDialog(String productId, String currentName, int currentPrice, bool currentAvailable) {
    final TextEditingController _newNameController = TextEditingController(text: currentName);
    final TextEditingController _newPriceController = TextEditingController(text: currentPrice.toString());
    bool _newAvailable = currentAvailable;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar producto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _newNameController,
              decoration: const InputDecoration(labelText: "Nuevo nombre"),
            ),
            TextFormField(
              controller: _newPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Nuevo precio"),
            ),
            SwitchListTile(
              title: const Text("Disponible"),
              value: _newAvailable,
              onChanged: (bool value) {
                _newAvailable = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          BottonUpdate(
            productId: productId,
            newName: _newNameController.text.trim(),
            newPrice: int.parse(_newPriceController.text.trim()),
            newAvailable: _newAvailable,
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
                MaterialPageRoute(builder: (context) => const AddProduct()),
              ).then((context) {
                if (mounted) {
                  setState(() {}); // ✅ Solo si aún está en pantalla
                }
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No hay productos disponibles.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final products = snapshot.data!.docs;
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
                      // Solo se podrá editar al presionar el ícono de editar
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: "Editar",
                        onPressed: () => showEditDialog(productId, name, price, available),
                      ),
                      ButtonDelete(productId: productId),
                    ],
                  ),
                  leading: Icon(
                    available ? Icons.check_circle : Icons.cancel,
                    color: available ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
