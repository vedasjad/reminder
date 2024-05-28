import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    // );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> updateNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
    String priority,
  ) async {
    await cancelNotification(id);
    await scheduleNotification(id, title, body, scheduledTime, priority);
  }

  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
    String priority,
  ) async {
    String sound = 'low_priority';
    Priority notificationPriority = Priority.low;

    switch (priority) {
      case 'High':
        sound = 'high_priority';
        notificationPriority = Priority.high;
        break;
      case 'Medium':
        sound = 'medium_priority';
        notificationPriority = Priority.defaultPriority;
        break;
      case 'Low':
      default:
        sound = 'low_priority';
        notificationPriority = Priority.low;
        break;
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '@string/default_notification_channel_id',
      'Reminder',
      importance: Importance.high,
      priority: notificationPriority,
      sound: RawResourceAndroidNotificationSound(sound),
      playSound: true,
      showWhen: true,
    );

    // final IOSNotificationDetails iOSPlatformChannelSpecifics =
    //     IOSNotificationDetails(sound: '$sound.aiff');

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    // await flutterLocalNotificationsPlugin.show(
    //   id,
    //   title,
    //   body,
    //   platformChannelSpecifics,
    // );

    final timeZoneName = await FlutterTimezone.getLocalTimezone();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "$title - $priority Priority",
      body,
      tz.TZDateTime.from(scheduledTime, tz.getLocation(timeZoneName)),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }
}
