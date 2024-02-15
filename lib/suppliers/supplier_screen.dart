// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_medical/models/product_supplier.dart';
import 'package:stock_medical/suppliers/add_supplier.dart';
import 'package:stock_medical/suppliers/update_suppliers.dart';

class SupplierScreen extends StatefulWidget {
  SupplierScreen({Key? key}) : super(key: key);

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  final Stream<QuerySnapshot> suppliersStream =
      FirebaseFirestore.instance.collection('suppliers').snapshots();

  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  Future<void> deleteUser(id) {
    return suppliers
        .doc(id)
        .delete()
        .then((value) => print('supplier Deleted'))
        .catchError((error) => print('Failed to Delete supplier: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fournisseurs",
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
          IconButton(
            icon: Icon(Icons.sort_outlined),
            onPressed: () {
              // Votre logique de validation et ajout du fournisseur ici
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Votre logique de validation et ajout du fournisseur ici
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: suppliersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<DocumentSnapshot> suppliersList = snapshot.data!.docs;

          return Column(
            children: [
              SizedBox(
                height: 20, // Hauteur du sous-appbar
                child: AppBar(
                  title: Text(
                    'Nbre de fournisseur: ${suppliersList.length}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  backgroundColor: Colors.indigoAccent.shade100,
                  automaticallyImplyLeading: false,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: suppliersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot supplier = suppliersList[index];
                    final Map<String, dynamic> supplierData =
                        supplier.data() as Map<String, dynamic>;

                    return ListTile(
                      leading: Icon(Icons.person_3_rounded),
                      title: Text(supplierData['name']),
                      subtitle: Text(supplierData['email']),
                      onTap: () {
                        SupplierData selectedSupplier = SupplierData(
                          id: supplier.id,
                          name: supplierData['name'],
                        );
                        Navigator.pop(context, selectedSupplier);
                      },
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_horiz_outlined),
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
                              value: "",
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == "edit") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateSupplier(
                                  id: supplier.id,
                                ),
                              ),
                            );
                          } else if (value == "delete") {
                            deleteUser(supplier.id);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSupplier(),
            ),
          );
        },
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0), // Ajustez la valeur selon votre préférence
        ),
      ),
    );
  }
}
