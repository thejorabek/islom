import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'prayer_times_channel',  // unique channel id
    'Prayer Times',          // channel name
    description: 'Notifications for prayer times',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );

  static Future<void> initialize() async {
    final AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    required int id,
  }) async {
    try {
      await _notificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            threadIdentifier: 'prayer_times',
          ),
        ),
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  static Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
  }

  static Future onNotificationTap(NotificationResponse details) async {
  }

  static Future<void> requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    
  }

  final DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
  threadIdentifier: 'prayer_times',
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
  attachments: [
    DarwinNotificationAttachment('AppIcon.appiconset/Icon-App-20x20@3x.png'), // Custom icon
  ],
);
}