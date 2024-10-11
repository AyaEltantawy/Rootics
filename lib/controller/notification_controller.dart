import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationController extends GetxController {
  static FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        handleNotificationTap(response);
      },
      onDidReceiveBackgroundNotificationResponse: (response) {
        handleNotificationTap(response);
      },
    );
  }

  void handleNotificationTap(NotificationResponse response) {
    // Handle the notification tap
  }

  Future<void> showCustomRepeatedNotification(
      {required int plantId,
      required String plantName,
      required String task,
      required int interval}) async {
    tz.initializeTimeZones();

    await scheduleNotification(
        plantId: plantId, plantName: plantName, task: task, interval: interval);
    Timer.periodic(Duration(minutes: interval), (timer) async {
      await scheduleNotification(
          plantId: plantId,
          plantName: plantName,
          task: task,
          interval: interval);
    });
  }

  Future<void> scheduleNotification(
      {required int plantId,
      required String plantName,
      required String task,
      required int interval}) async {
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.now(tz.local).add(Duration(minutes: interval));

    await notifications.zonedSchedule(
      plantId,
      plantName,
      task,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'id 1',
          'repeated notification',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: 'customRepeatedNotification',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("Custom repeated notification scheduled for $scheduledTime");
  }

  Future<void> deleteNotification(int notificationId) async {
    await notifications.cancel(notificationId);
    print("Notification with id $notificationId cancelled");
  }
}
