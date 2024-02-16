
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About US",
          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
        ),
        backgroundColor: Color.fromARGB(223, 56, 116, 184),
      ),
      body: Container(
        height: 200,
        color: Color.fromARGB(255, 42, 97, 143),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/syring.jpg',
              height: 100, // Adjust the height as needed
              width: 100, // Adjust the width as needed
            ),
            SizedBox(height: 10), 
            Text(
              'Medical stock administration',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
