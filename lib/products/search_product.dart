import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class ListSearchsPage extends StatefulWidget {
  ListSearchsPage({Key? key}) : super(key: key);

  @override
  _ListSearchPageState createState() => _ListSearchPageState();
}

class _ListSearchPageState extends State<ListSearchsPage> {
  var carMake, carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  Widget build(BuildContext context) {
    debugPrint('carMake: $carMake');

    return Scaffold(
      appBar: AppBar(
        title: Text("jjj"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .orderBy('productname')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();
                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    carMake = snapshot.data!.docs[0].get('productname');
                    debugPrint('setDefault make: $carMake');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: carMake,
                    items: snapshot.data!.docs.map((value) {
                      return DropdownMenuItem(
                        value: value.get('productname'),
                        child: Text('${value.get('productname')}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      debugPrint('selected onchange: $value');
                      setState(
                        () {
                          debugPrint('make selected: $value');
                          // Selected value will be stored
                          carMake = value;
                          // Default dropdown value won't be displayed anymore
                          setDefaultMake = false;
                          // Set makeModel to true to display first car from list
                          setDefaultMakeModel = true;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
