import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initialize() {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
      subscribeToTeachersTopic(); // Subscribe to topic representing all teachers
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app is in the foreground: $message');
      // Handle the received message when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked when app is in background: $message');
      // Handle the notification click when the app is in the background
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void subscribeToTeachersTopic() {
    _firebaseMessaging.subscribeToTopic('all_teachers');
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    // Handle the background message
  }
}
