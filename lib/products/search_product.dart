import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSearch extends SearchDelegate<String> {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchProducts();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchProducts();
  }

  Widget searchProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products')
          .where('productName', isGreaterThanOrEqualTo: query)
          .where('productName', isLessThan: query + 'z')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<DocumentSnapshot> products = snapshot.data!.docs;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> productData =
                products[index].data() as Map<String, dynamic>;
            String productName = productData['productName'];
            String productBarcode = productData['productBarcode'];

            return ListTile(
              title: Text(productName),
              subtitle: Text('Barcode: $productBarcode'),
              onTap: () {
                close(context, productName);
              },
            );
          },
        );
      },
    );
  }
}
