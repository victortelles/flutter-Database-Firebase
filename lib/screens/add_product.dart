import '../widgets/button_create.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //Variables
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _available = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose(); // ✅ Se llama aquí, y al final
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Campo Nombre
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del producto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Campo del precio
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio del producto';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Campo Disponible
              SwitchListTile(
                title: const Text('Disponible'),
                value: _available,
                onChanged: (value) {
                  setState(() {
                    _available = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              //Boton de crear producto
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text.trim();
                      final price = int.parse(_priceController.text.trim());
                      final available = _available;

                      //boton personalizado
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          content: ButtonCreate(
                            name: name,
                            price: price,
                            available: available,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Guardar Producto"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
