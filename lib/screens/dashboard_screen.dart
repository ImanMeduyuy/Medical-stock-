// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

import 'package:stock_medical/customers/customer_screen.dart';
import 'package:stock_medical/documents/document_screen.dart';
import 'package:stock_medical/orders/order_screen.dart';
import 'package:stock_medical/products/product_screen.dart';
import 'package:stock_medical/rapports/rapport_screen.dart';
import 'package:stock_medical/suppliers/supplier_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  SingleChildScrollView(
        
         child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 5.0,
                    children: <Widget>[
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen()),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/add-product.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Product",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderScreen()),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/commande.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Commande",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupplierScreen()),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/supplier.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Suppliers",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerScreen()),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/customer.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Customer",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 150.0,
                      //   height: 150.0,
                      //   child: new InkWell(
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => StockScreen()),
                      //       );
                      //     },
                      //     child: Card(
                      //       color: Color.fromARGB(255, 255, 255, 255),
                      //       elevation: 2.0,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8.0)),
                      //       child: Center(
                      //           child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           children: <Widget>[
                      //             Image.asset(
                      //               "assets/stock.png",
                      //               height: 80,
                      //               width: 80,
                      //             ),
                      //             SizedBox(
                      //               height: 10.0,
                      //             ),
                      //             Text(
                      //               "Stocks",
                      //               style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 18.0),
                      //             ),
                      //             SizedBox(
                      //               height: 5.0,
                      //             ),
                      //           ],
                      //         ),
                      //       )),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentScreen()),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/document.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Documents",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RapportScreen()),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/rapport.png",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Rapports",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
       ),    
    );
  }
}