import 'package:flutter/material.dart';

class LowStockProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer la liste des produits avec un stock faible depuis Firestore ou une autre source de données
    List<Map<String, dynamic>> lowStockProducts = []; // Remplacez cette liste par vos données réelles

    return Scaffold(
      appBar: AppBar(
        title: Text('Produits avec un stock faible'),
      ),
      body: ListView.builder(
        itemCount: lowStockProducts.length,
        itemBuilder: (context, index) {
          // Afficher les détails de chaque produit avec un stock faible dans la liste
          return ListTile(
            title: Text(lowStockProducts[index]['productname']),
            subtitle: Text('Stock: ${lowStockProducts[index]['qty']}'),
          );
        },
      ),
    );
  }
}
