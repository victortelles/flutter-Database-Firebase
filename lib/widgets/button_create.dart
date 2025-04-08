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
