import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateOrderScreen extends StatefulWidget {
  final String orderId;

  UpdateOrderScreen({required this.orderId});

  @override
  _UpdateOrderScreenState createState() => _UpdateOrderScreenState();
}

class _UpdateOrderScreenState extends State<UpdateOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  var produit = "";
  var prix = "";
  var quantite = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Order"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(widget.orderId)
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final Map<String, dynamic> orderData =
              snapshot.data!.data() as Map<String, dynamic>;

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  initialValue: orderData['produit']??'',
                  decoration: InputDecoration(labelText: 'Produit'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    produit = value!;
                  },
                ),
                TextFormField(
                  initialValue: orderData['prix']??'',
                  decoration: InputDecoration(labelText: 'Prix'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    prix = value!;
                  },
                ),
                TextFormField(
                  initialValue: orderData['quantite']??'',
                  decoration: InputDecoration(labelText: 'Quantite'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    quantite = value!;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Update the order in Firestore
                      FirebaseFirestore.instance
                          .collection('orders')
                          .doc(widget.orderId)
                          .update({
                        'produit': produit,
                        'prix': prix,
                        'quantite': quantite,
                      }).then((_) {
                        // Navigate back to Orders screen after updating
                        Navigator.of(context).pop();
                      }).catchError((error) {
                        // Handle error if any
                        print("Failed to update order: $error");
                      });
                    }
                  },
                  child: Text('Update Order'),
                ),
              ],
            ),
          );
        },
     ),
   );
 }
}
