// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateSupplier extends StatefulWidget {
  final String id;
  UpdateSupplier({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateSupplierState createState() => _UpdateSupplierState();
}

class _UpdateSupplierState extends State<UpdateSupplier> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String mobile;

  // Updating Supplier
  CollectionReference suppliers = FirebaseFirestore.instance.collection('suppliers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update supplier",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Ajoutez ici la logique de rafraîchissement si nécessaire
            },
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // Valide le formulaire
              if (_formKey.currentState!.validate()) {
                // Met à jour le fournisseur
                updateUser(widget.id, name, email, mobile);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        // Obtention des données spécifiques par ID
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('suppliers').doc(widget.id).get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data!.data()!;
            name = data['name'];
            email = data['email'];
            mobile = data['mobile'];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      initialValue: name,
                      onChanged: (value) => name = value,
                      decoration: InputDecoration(
                        labelText: 'Name: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      initialValue: email,
                      autofocus: false,
                      onChanged: (value) => email = value,
                      decoration: InputDecoration(
                        labelText: 'Email: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      initialValue: mobile,
                      onChanged: (value) => mobile = value,
                      decoration: InputDecoration(
                        labelText: 'mobile: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter mobile';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> updateUser(String id, String name, String email, String mobile) {
    return suppliers
        .doc(id)
        .update({'name': name, 'email': email, 'mobile': mobile})
        .then((value) => print("supplier Updated"))
        .catchError((error) => print("Failed to update supplier: $error"));
  }
}
