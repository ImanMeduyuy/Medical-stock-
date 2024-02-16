// ignore_for_file: avoid_print, invalid_return_type_for_catch_error, prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSupplier extends StatefulWidget {
  AddSupplier({Key? key}) : super(key: key);

  @override
  _AddSupplierState createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var email = "";
  var mobile = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    mobileController.clear();
  }

  // Adding Supplier
  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  Future<void> addSupplier() {
    return suppliers
        .add({'name': name, 'email': email, 'mobile': mobile}).then((value) {
      Navigator.pop(
          context); // Retourne à la page précédente (liste des fournisseurs)
    }).catchError((error) => print('Failed to Add Supplier: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Supplier", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 100, 98, 224),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Votre logique de validation et ajout du fournisseur ici
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Votre logique de validation et ajout du fournisseur ici
            },
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                name = nameController.text;
                email = emailController.text;
                mobile = mobileController.text;
                addSupplier();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Supplier',
                    filled: true,
                    fillColor: Color.fromARGB(255, 244, 244, 248),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 141, 189, 243),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  ),
                  controller: nameController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Color.fromARGB(255, 244, 244, 248),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 141, 189, 243),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  ),
                  controller: emailController,
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
                  autofocus: false,
                  keyboardType:
                      TextInputType.number, // Affiche le clavier numérique
                  decoration: InputDecoration(
                    labelText: 'Telephone',
                    filled: true,
                    fillColor: Color.fromARGB(255, 244, 244, 248),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 141, 189, 243),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  ),
                  controller: mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Mobile';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}