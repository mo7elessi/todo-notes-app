import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    tz.initializeTimeZones();
    WidgetsFlutterBinding.ensureInitialized();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });
    _zonedScheduleTaskNotification(
        context, TaskCubit.get(context).newTasks.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (BuildContext context, TaskStates? state) {},
      builder: (BuildContext context, TaskStates state) => Scaffold(
        appBar: AppBar(
          title: const Text('text'),
        ),
        body: TextButton(
          onPressed: () {
            //_zonedScheduleNotification(context);
            _zonedScheduleTaskNotification(
                context, TaskCubit.get(context).newTasks.first);
          },
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}

Future notificationSelected(String payload, context) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text("Notification : $payload"),
    ),
  );
}

Future<void> _zonedScheduleNotification(context) async {
  DateTime testDate = DateTime.parse("2021-10-04 20:18:04Z");

  tz.TZDateTime testDate_2 =
      tz.TZDateTime.parse(tz.local, ("2021-10-04 15:11:00"));

  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'لديك مهمة جديدة',
      '',
      testDate_2,
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);

  print('Date with parse with zone: ${testDate}');
  print('zone with parse : ${testDate_2}');
}

Future<void> _zonedScheduleTaskNotification(context, Map model) async {
  //2021-10-04 15:11:00
  DateTime time =DateTime(0);
  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));

  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      model['title'],
      model['time'],
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
