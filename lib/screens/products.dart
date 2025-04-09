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
  // Obtenemos productos con Future
  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    return snapshot.docs;
  }

  // Muestra diálogo para editar nombre, precio y disponibilidad
  void showEditDialog(String productId, String currentName, int currentPrice,
      bool currentAvailable) {
    final TextEditingController _newNameController = TextEditingController(text: currentName);
    final TextEditingController _newPriceController = TextEditingController(text: currentPrice.toString());
    bool _newAvailable = currentAvailable;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Editar producto"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //campo de nombre
                TextFormField(
                  controller: _newNameController,
                  decoration: const InputDecoration(labelText: "Nuevo nombre"),
                  //Actualiza el Texto
                  onChanged: (value) {
                    setState(() {
                      _newNameController.text = value;
                    });
                  },
                ),

                //Campo de precio
                TextFormField(
                  controller: _newPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Nuevo precio"),
                  //Actualiza el precio
                  onChanged: (value) {
                    setState(() {
                      _newPriceController.text = value;
                    });
                  },
                ),

                //Campo de switch
                SwitchListTile(
                  title: const Text("Disponible"),
                  value: _newAvailable,
                  onChanged: (bool value) {
                    setState(() {
                    _newAvailable = value;
                    });
                  },
                ),
              ],
            ),
            actions: [
              //Boton de cancelar
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),

              //Icono de boton de actualizar
              BottonUpdate(
                productId: productId,
                newName: _newNameController.text.trim(),
                newPrice: int.parse(_newPriceController.text.trim()),
                newAvailable: _newAvailable,
                onUpdate: () {
                  this.setState(() {}); // Se actualiza la vista
                  Navigator.pop(context); // Cierra el diálogo después de actualizar
                },
              ),
            ],
          );
        },
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
                //Redireccion a add_products
                MaterialPageRoute(builder: (context) => const AddProduct()),
              ).then((_) {
                if (mounted) {
                  setState(() {});
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
              //print("Producto a editar: $productId, $name, $price, $available"); // Verifica los valores antes de abrir el diálogo

              //Widget de card
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  //Texto
                  title: Text(name),
                  //Precio
                  subtitle: Text('Precio: \$${price.toString()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: "Editar",
                        onPressed: () =>
                            showEditDialog(productId, name, price, available),
                      ),
                      ButtonDelete(productId: productId),
                    ],
                  ),

                  //Icono de disponibilidad
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
