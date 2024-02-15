// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, sort_child_properties_last, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_medical/customers/add_customer.dart';
import 'package:stock_medical/customers/update_customer.dart';

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final Stream<QuerySnapshot> customersStream =
      FirebaseFirestore.instance.collection('customers').snapshots();

  // For Deleting User
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return customers
        .doc(id)
        .delete()
        .then((value) => print('customer Deleted'))
        .catchError((error) => print('Failed to Delete customer: $error'));
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
            icon: Icon(Icons.sort),
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
           
         ]
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: customersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return ListView.builder(
            itemCount: storedocs.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.person_3_rounded),
                title: Text(storedocs[index]['name']),
                subtitle: Text(storedocs[index]['email']),
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
                          builder: (context) => UpdateCustomer(
                            id: storedocs[index]['id'],
                          ),
                        ),
                      );
                    } else if (value == "delete") {
                      deleteUser(storedocs[index]['id']);
                    }
                  },
                ),
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
              builder: (context) => AddCustomer(),
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
