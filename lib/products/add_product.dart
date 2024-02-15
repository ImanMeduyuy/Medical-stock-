// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:stock_medical/suppliers/supplier_screen.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _checkbox = false;
  String _scanBarcode = 'Unknown';
  final _formKey = GlobalKey<FormState>();
  var barcode = "";
  var productname = "";
  int qty = 1;
  double selprice = 0.0;
  var supplierName = "";
  var mfgdate = "";
  DateTime? expdate;
  var pdesc = "";
  int minqty = 1;
  String supplierId = ""; // Champ pour stocker l'ID du fournisseur
  final barcodeController = TextEditingController();
  final pnameController = TextEditingController();
  final qtyController = TextEditingController();
  final selpriceController = TextEditingController();
  final mfgdateController = TextEditingController();
  final expdateController = TextEditingController();
  final pdescController = TextEditingController();
  final minqtyController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  @override
  void dispose() {
    barcodeController.dispose();
    pnameController.dispose();
    qtyController.dispose();
    selpriceController.dispose();
    mfgdateController.dispose();
    expdateController.dispose();
    pdescController.dispose();
    minqtyController.dispose();
    super.dispose();
  }

  clearText() {
    barcodeController.clear();
    pnameController.clear();
    qtyController.clear();
    selpriceController.clear();
    mfgdateController.clear();
    expdateController.clear();
    pdescController.clear();
    minqtyController.clear();
  }

  void getfromData() {
    barcode = barcodeController.text;
    productname = pnameController.text;
    selprice = double.tryParse(selpriceController.text) ?? 0.0;
    qty = int.tryParse(qtyController.text) ?? 1;
    mfgdate = mfgdateController.text;
    expdate = DateTime.tryParse(expdateController.text);
if (expdate == null) {
  // Gérer le cas où la conversion échoue, par exemple afficher un message d'erreur
  print('Failed to parse expiration date');
  return; // ou une autre action appropriée
}

    pdesc = pdescController.text;
    minqty = int.tryParse(minqtyController.text) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              getfromData();
              // Ajouter le produit à la base de données
              // addUser();
              // Afficher la boîte de dialogue
              _displayDialog(context);
              clearText();
            });
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.check),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: barcodeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Barcode';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.scanner,
                          color: Colors.black,
                        ),
                        labelText: 'Barcode',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => scanBarcodeNormal(),
                      child: Text('Start barcode scan'),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: pnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Product Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.sell,
                          color: Colors.black,
                        ),
                        labelText: 'Product Name',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Quantity';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.storage,
                          color: Colors.black,
                        ),
                        labelText: 'Quantity',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: selpriceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Sell Price';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.black,
                        ),
                        labelText: 'Sell Price',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      onTap: () async {
                        var selectedSupplier = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierScreen(),
                          ),
                        );
                        if (selectedSupplier != null) {
                          setState(() {
                           supplierName = selectedSupplier.name;
                           supplierId = selectedSupplier.id;
                           pnameController.text = supplierName; // Mettre à jour l'ID du fournisseur
                          });
                        }
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.supervisor_account,
                          color: Colors.black,
                        ),
                        labelText: 'Supplier',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        controller: mfgdateController,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Mfg. Date';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Mfg. Date" //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          var pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              mfgdateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        // controller: dateinput,
                        controller:
                            expdateController, //editing controller of this TextField
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Exp. Date';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Exp. Date" //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          var pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);

                            setState(() {
                              expdateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: pdescController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Product Description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        labelText: 'Product Description',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = value ?? false;
                            });
                          },
                        ),
                        Text('Low stock Alert on this Product?'),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: minqtyController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Minimum Quantity';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                        labelText: 'Minimum Quantity for Alert',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    Text('Scan result : $_scanBarcode\n',
                        style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      barcodeController.text = _scanBarcode;
    });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Product Added'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
