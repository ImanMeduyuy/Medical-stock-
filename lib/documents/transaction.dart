import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Classe de modèle pour représenter une transaction de produit
class ProductTransaction {
  final String productId;
  final int quantity;
  final double price;
  final DateTime timestamp;

  ProductTransaction({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.timestamp,
  });
}

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _productIdController,
                decoration: InputDecoration(labelText: 'Product ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveTransaction();
                    }
                  },
                  child: Text('Save Transaction'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      final String productId = _productIdController.text;
      final int quantity = int.parse(_quantityController.text);
      final double price = double.parse(_priceController.text);
      final DateTime timestamp = DateTime.now();

      // Créer une instance de ProductTransaction
      ProductTransaction transaction = ProductTransaction(
        productId: productId,
        quantity: quantity,
        price: price,
        timestamp: timestamp,
      );

      // Enregistrer la transaction dans Firestore
      _addTransactionToFirestore(transaction);

      // Effacer les champs après enregistrement
      _productIdController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  void _addTransactionToFirestore(ProductTransaction transaction) {
    FirebaseFirestore.instance.collection('transactions').add({
      'productId': transaction.productId,
      'quantity': transaction.quantity,
      'price': transaction.price,
      'timestamp': transaction.timestamp,
    }).then((value) {
      // Enregistrement réussi
      print('Transaction saved successfully!');
    }).catchError((error) {
      // Erreur lors de l'enregistrement
      print('Failed to save transaction: $error');
    });
  }
}
