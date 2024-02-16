import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ListExpiredProductPage extends StatefulWidget {
  ListExpiredProductPage({Key? key}) : super(key: key);

  @override
  _ListExpiredProductPageState createState() => _ListExpiredProductPageState();
}

class _ListExpiredProductPageState extends State<ListExpiredProductPage> {
  final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('expdate',
          isLessThan: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expired Product List"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchPage()),
            ),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Map<String, dynamic>> expiredProducts = snapshot.data!.docs
              .map((DocumentSnapshot document) => {
                    'productname': document['productname'],
                    'qty': document['qty'],
                    'expdate': document['expdate'].toDate(),
                  })
              .toList();

          return ListView.builder(
            itemCount: expiredProducts.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> product = expiredProducts[index];
              return ListTile(
                title: Text(product['productname']),
                subtitle: Text('Quantity: ${product['qty']}'),
                trailing: Text(
                  DateFormat.yMd().format(product['expdate']),
                  style: TextStyle(fontSize: 14.0),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Product'),
      ),
      body: Center(
        child: Text('Search functionality will be implemented here.'),
      ),
    );
  }
}
