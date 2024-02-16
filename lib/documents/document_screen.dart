import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logs d'activité"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('document').get(), // Récupérer tous les documents de la collection 'activity_logs'
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucun journal d\'activité trouvé.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final activityLog = snapshot.data!.docs[index];
                final data = activityLog.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['action'] ?? 'Action inconnue'),
                  subtitle: Text('Utilisateur: ${data['userId']}'),
                  // Ajoutez d'autres widgets pour afficher d'autres détails de l'activité
                );
              },
            );
          }
        },
      ),
    );
  }
}
