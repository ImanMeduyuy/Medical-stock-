// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_medical/products/add_product.dart';
import 'package:stock_medical/products/product_expired.dart';
import 'package:stock_medical/products/update_product.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final Stream<QuerySnapshot> productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  Future<void> deleteProduct(String id) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .delete()
        .then((value) => print('Product Deleted'))
        .catchError((error) => print('Failed to Delete product: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Produits",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent.shade200,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Votre logique de validation et ajout du fournisseur ici
            },
          ),
          PopupMenuButton(
                  icon: Icon(Icons.more_vert_outlined),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("produits expire"),
                        value: "expired",
                      ),
                      PopupMenuItem(
                        child: Text("historique"),
                        value: "historique",
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == "expired") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListExpiredProductPage()
                          ),
                      );
                    } else if (value == "historique") {
                        
                      
                    } 
                  },
               ) 
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

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> productData =
                  products[index].data() as Map<String, dynamic>;
              String productId = products[index].id;

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
                        child: Text("historique"),
                        value: "historique",
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == "edit") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(id: productId),
                        ),
                      );
                    } else if (value == "delete") {
                      deleteProduct(productId);
                    } else {
                      // Handle historique action
                    }
                  },
                ),
                onTap: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(id: productId),
                        ),
                      );
                },
              );
            },
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

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  ProductDetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails du produit"),
      ),
      body: Center(
        child: Text("Product Details for ID: $productId"),
      ),
    );
  }
}
