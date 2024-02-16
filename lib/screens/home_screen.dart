import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_medical/auth/auth_page.dart';
import 'package:stock_medical/products/product_expired.dart';
import 'package:stock_medical/products/product_notif.dart';
import 'package:stock_medical/screens/about_screen.dart';
import 'package:stock_medical/screens/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Medical',
        style: TextStyle(color: Colors.white, 
        fontSize: 22,),
        
        
        ),
        backgroundColor: Colors.indigoAccent.shade200,
        iconTheme: IconThemeData(color: Colors.white),
        
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Navigate to about screen or show about dialog
              // For example:
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
              // or showAboutDialog(context: context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
  
        drawer: DrawerWidget(),
      body: DashboardScreen(),
   
      // Replace with your dashboard screen
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 150,
            color: Colors.blue, // Change to your desired background color
            alignment: Alignment.center,
            child: Text(
              'Stock Medical',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Alerts'),
            onTap: () {
              // Show alerts when the user taps on the "Alerts" item
              _showAlerts(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to the About screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAlerts(BuildContext context) {
    // Show alerts for expired and low stock products
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerts'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to the screen for expired products
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListExpiredProductPage(),
                    ),
                  );
                },
                child: Text('Expired Products'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the screen for low stock products
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LowStockProductsScreen(),
                    ),
                  );
                },
                child: Text('Low Stock Products'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}