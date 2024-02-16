import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_medical/orders/add_order.dart';
import 'package:stock_medical/orders/update_order.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Stream<QuerySnapshot> ordersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

  void _deleteOrder(String orderId) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .delete()
        .then((_) {
      // Handle deletion success if needed
    }).catchError((error) {
      print('Failed to delete order: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
        ),
        backgroundColor: Color.fromARGB(224, 64, 78, 156),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: ordersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final List<DocumentSnapshot> ordersList = snapshot.data!.docs;

            return ListView(
              children: ordersList.map((DocumentSnapshot document) {
                final Map<String, dynamic>? orderData =
                    document.data() as Map<String, dynamic>?;

                if (orderData != null) {
                  final String produit =
                      orderData['produit'] ?? 'Unknown produit';
                  final String prix = orderData['prix'] ?? 'Unknown prix';
                  final String quantite =
                      orderData['quantite'] ?? 'Unknown quantite';
                  final String supplier =
                      orderData['supplier'] ?? 'Unknown supplier';
                  final String duree = orderData['duree'] ?? 'Unknown duree';

                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        produit,
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 32, 66),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      subtitle: Text(
                        'Prix: $prix, Quantite: $quantite, Supplier: $supplier, Duree: $duree',
                        style: TextStyle(
                          color: Color.fromARGB(221, 79, 126, 212),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      //4ou lwayel modifier w supprimer m6arithm copihm w clihm v 4e ver
                      //supprimer sal7ali
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteOrder(document.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateOrderScreen(orderId: document.id),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // Handle tap if needed
                      },
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text('Unknown produit'),
                    subtitle: Text('Unknown prix, Unknown quantite'),
                  );
                }
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOrderScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
   );
 }
}
