
//Funcion update
Future<void> updateProduct(String productId, String newName){
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  return products.doc(productId).update({'name': newName})
    .then((value) => print('Product name updated successfully'))
    .catchError((error) => print('Failed to update product name: $error'));
}
