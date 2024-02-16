import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductHistoryScreen extends StatelessWidget {
  final String productId;

  ProductHistoryScreen({required this.productId});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique du produit'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product_history')
            .where('productId', isEqualTo: productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucun historique trouvé pour ce produit'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var history = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // Récupérer l'ID du produit
              String productId = history['productId'];

              // Récupérer les informations du produit à partir de la collection 'products'
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('products').doc(productId).get(),
                builder: (context, productSnapshot) {
                  if (productSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (productSnapshot.hasError || !productSnapshot.hasData) {
                    return Text('Erreur lors de la récupération des informations du produit');
                  }

                  var productData = productSnapshot.data!.data() as Map<String, dynamic>;

                  // Convertir la date d'expiration en format DateTime
                  DateTime? expirationDate = history['expirationDate'] != null ? history['expirationDate'].toDate() : null;

                  // Formater la date d'expiration dans un format convivial
                  String formattedExpirationDate = expirationDate != null
                      ? '${expirationDate.day}/${expirationDate.month}/${expirationDate.year}'
                      : 'Date d\'expiration inconnue';

                  // Afficher les détails de l'historique et du produit
                  return ListTile(
                    title: Text('Date d\'ajout: ${history['dateAdded']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Action: ${history['action']}'),
                        Text('Nom du produit: ${productData['productname']}'),
                        Text('Pays: ${productData['country']}'),
                        Text('Date d\'expiration: $formattedExpirationDate'),
                        Text('Fournisseur: ${productData['supplierName']}'),
                        // Ajoutez d'autres informations du produit ici
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
