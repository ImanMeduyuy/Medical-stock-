import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_medical/products/add_product.dart';
import 'package:stock_medical/products/product_expired.dart';
import 'package:stock_medical/products/product_history.dart';
import 'package:stock_medical/products/search_product.dart';
import 'package:stock_medical/products/update_product.dart';
class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final Stream<QuerySnapshot> productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  String? _searchTerm;

  Future<void> deleteProduct(String id) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .delete()
        .then((value) => print('Product Deleted'))
        .catchError((error) => print('Failed to Delete product: $error'));
  }

  void showProductHistory(String productId) {
    // Handle showing the product history here
    print('Show product history for $productId');
  }

  void searchExpiredProducts() {
    // Handle searching for expired products here
    print('Search for expired products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchTerm == null
            ? Text(
                "Produits",
                style: TextStyle(color: Colors.white),
              )
            : TextField(
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher un produit',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Colors.indigoAccent.shade200,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _searchTerm = '';
              });
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("les produits expirés"),
                value: "searchExpired",
              ),
            ],
            onSelected: (value) {
              if (value == "searchExpired") {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListExpiredProductPage(),
                        ),
                );
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productsStream,
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

          // Filter products based on search term
          List<DocumentSnapshot> filteredProducts = _searchTerm == null || _searchTerm!.isEmpty
              ? products
              : products.where((product) =>
                  product['productname'].toString().toLowerCase().contains(_searchTerm!.toLowerCase())).toList();

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> productData =
                  filteredProducts[index].data() as Map<String, dynamic>;
              String productId = filteredProducts[index].id;

              return ListTile(
                title: Text(productData['productname']),
                subtitle: Text('Quantity: ${productData['qty']}'),
                trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert_outlined),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("Edit"),
                        value: "edit",
                      ),
                      PopupMenuItem(
                        child: Text("Delete"),
                        value: "delete",
                      ),
                      PopupMenuItem(
                        child: Text("Historique"),
                        value: "historique",
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == "edit") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateProduct(id: productId),
                        ),
                      );
                    } else if (value == "delete") {
                      deleteProduct(productId);
                    } else if (value == "historique") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductHistoryScreen(productId: productId),
                        ),
                      );
                    }
                  },
                ),
              );
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(),
            ),
          );
        },
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
