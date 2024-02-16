import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // Demander la permission de recevoir des notifications (Android uniquement)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: }');

    // Récupérer le jeton d'enregistrement
    String? token = await _firebaseMessaging.getToken();
    print('Token: $token');
  }
}
