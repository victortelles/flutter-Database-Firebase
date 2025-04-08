//Function delete
/*
Future<void> deleteProduct(String productId){
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  return products.doc(productId).delete()
    .then((value) => print('Product $productId deleted successfully!'))
    .catchError((error) => print('Failed to delete product: $error'));
}
*/