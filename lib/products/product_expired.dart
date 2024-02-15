// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListExpiredProductPage extends StatefulWidget {
  ListExpiredProductPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListExpiredProductPageState createState() => _ListExpiredProductPageState();
}

class _ListExpiredProductPageState extends State<ListExpiredProductPage> {
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('products')
      .where('expdate',
          isLessThan: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text("Expired Product List"),
              actions: [
                // Navigate to the Search Screen
                IconButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => SearchPage())),
                    icon: Icon(Icons.search))
              ],
            ),
            body: ListView(
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        1: FixedColumnWidth(140),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    'P.Name',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    'Qty',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    'Exp.Date',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < storedocs.length; i++) ...[
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                    child: Text(storedocs[i]['productname'],
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(
                                        storedocs[i]['qty']?.toString() ?? "",
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text(
                                        storedocs[i]['expdate']
                                            .toDate()
                                            .toString(),
                                        style: TextStyle(fontSize: 18.0))),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}
