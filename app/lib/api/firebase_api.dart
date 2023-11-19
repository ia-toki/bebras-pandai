import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../services/firebase_service.dart';
import '../services/router_service.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final currentUser = FirebaseService.auth().currentUser;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    router.push('/material');
  }

  Future<dynamic> initPushNotfications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
      await _firebaseMessaging.requestPermission();

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        Map<String, dynamic> deviceToken = {
          'fcm_token': fcmToken,
          'fcm_timestamp': FieldValue.serverTimestamp(),
        };

        // Reference to the Firestore collection
        CollectionReference<Map<String, dynamic>> fcmTokensCollection =
            FirebaseFirestore.instance.collection('registered_user');

        // Set the device token in Firestore
        fcmTokensCollection.doc(currentUser!.uid).update(deviceToken);
            }).onError((err) {
        // Error getting token.
      });

      final fCMToken = await _firebaseMessaging.getToken();
      print('Token: $fCMToken');
      await initPushNotfications();
  }
}
