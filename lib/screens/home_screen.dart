import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_medical/auth/auth_page.dart';
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
        title: Text('Stock Medical'),
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
  drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              color: Colors.blue, // Change to your desired background color
              alignment: Alignment.center,
              child: Text(
                'Your App Name',
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
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to about screen
                // For example:
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                // Clear Firebase
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthWrapper()),
                );
              },
            ),
          ],
        ),
      ),
      body: DashboardScreen(),
    );
  }
}
