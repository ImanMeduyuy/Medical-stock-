import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_medical/auth/auth_page.dart';
import 'package:stock_medical/documents/activite.dart';
import 'package:stock_medical/firebase_api.dart';
import 'package:stock_medical/firebase_options.dart'; // Importez FirebaseApi ici

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  runApp(const MyApp());
    // Appel de logActivity pour enregistrer une action au démarrage de l'application
//  ActivityLogger.logActivity();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
    );
  }
}
