import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_medical/documents/document_screen.dart';

class ActivityLogger {
  static Future<void> logActivity(String action, String userId, Map<String, dynamic> details) async {
    try {
      await FirebaseFirestore.instance.collection('document').add({
        'action': action,
        'userId': userId,
        'timestamp': DateTime.now(),
        'details': details,
      });
      print('Activité enregistrée dans le journal');
    } catch (error) {
      print('Erreur lors de l\'enregistrement de l\'activité dans le journal: $error');
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            // Appel de logActivity pour enregistrer une action de navigation
            ActivityLogger.logActivity('Navigation', 'ID_utilisateur', {
              'route': settings.name,
              // Autres détails de l'action si nécessaire
            });

            // Retourne le widget de la page correspondante à la route
            return DocumentScreen();
          },
        );
      },
    );
  }
}
