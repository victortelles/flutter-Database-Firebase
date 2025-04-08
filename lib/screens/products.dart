

//Function Get a product
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

