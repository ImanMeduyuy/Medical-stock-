// add orders import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  var produit = "";
  var prix = "";
  var quantite = "";
  var supplier = "";
  var duree = "";

  // Create a text controller for each text field
  final produitController = TextEditingController();
  final prixController = TextEditingController();
  final quantiteController = TextEditingController();
  final supplierController = TextEditingController();
  final dureeController = TextEditingController();

  @override
  void dispose() {
    produitController.dispose();
    prixController.dispose();
    quantiteController.dispose();
    supplierController.dispose();
    dureeController.dispose();
    super.dispose();
  }


   void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Order added successfully."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Order",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(224, 64, 78, 156),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: produitController,
              decoration: InputDecoration(
                labelText: 'Produit',
                filled: true,
                fillColor: Color.fromARGB(255, 244, 244, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 141, 189, 243), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: prixController,
              decoration: InputDecoration(
                labelText: 'Prix',
                filled: true,
                fillColor: Color.fromARGB(255, 244, 244, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 141, 189, 243), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: quantiteController,
              decoration: InputDecoration(
                labelText: 'Quantite',
                filled: true,
                fillColor: Color.fromARGB(255, 244, 244, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 141, 189, 243), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: supplierController,
              decoration: InputDecoration(
                labelText: 'Supplier',
                filled: true,
                fillColor: Color.fromARGB(255, 244, 244, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 141, 189, 243), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a supplier';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dureeController,
              decoration: InputDecoration(
                labelText: 'Duree',
                filled: true,
                fillColor: Color.fromARGB(255, 244, 244, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 141, 189, 243), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a duree';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            SizedBox(height: 20.0),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the order to Firestore
                    FirebaseFirestore.instance.collection('orders').add({
                      'produit': produitController.text,
                      'prix': prixController.text,
                      'quantite': quantiteController.text,
                      'supplier': supplierController.text,
                      'duree': dureeController.text
                    }).then((_) {
                     _showAlertDialog();


                    }).catchError((error) {
                      print('Failed to add order: $error');
                    });

                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 46, 59, 143)),
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(120, 36)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  'Add Order',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
