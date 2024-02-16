// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_medical/auth/signin_screen.dart';
import 'package:stock_medical/screens/home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Medical App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher un indicateur de chargement si l'état de l'authentification est en cours de chargement
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            // Utilisateur connecté, naviguer vers l'écran principal (HomeScreen)
            return HomeScreen();
          } else {
            // Utilisateur non connecté, naviguer vers l'écran de connexion (LoginScreen)
            return login();
          }
        }
      },
    );
  }
}
