import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  Future<void> deleteUser(id) {
    return customers
        .doc(id)
        .delete()
        .then((value) => print('Customer Deleted'))
        .catchError((error) => print('Failed to Delete Customer: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clients",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent.shade200,
        iconTheme: IconThemeData(color: Colors.white), 
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Votre logique de recherche de client ici
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Votre logique de tri des clients ici
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Votre logique supplémentaire ici
            },
          ),
        ],
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

          final List<DocumentSnapshot> customersList = snapshot.data!.docs;

          return Column(
            children: [
              SizedBox(
                height: 20, // Hauteur du sous-appbar
                child: AppBar(
                  title: Text(
                    'Nbre de clients: ${customersList.length}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  backgroundColor: Colors.indigoAccent.shade100,
                  automaticallyImplyLeading: false,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: customersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot customer = customersList[index];
                    final Map<String, dynamic> customerData =
                        customer.data() as Map<String, dynamic>;

                    return ListTile(
                      leading: Icon(Icons.person_3_rounded),
                      title: Text(customerData['name']),
                      subtitle: Text(customerData['email']),
                      onTap: () {
                        // Logic to handle customer tap
                      },
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
                              child: Text("Historique"),
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
                                  id: customer.id,
                                ),
                              ),
                            );
                          } else if (value == "delete") {
                            deleteUser(customer.id);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
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
