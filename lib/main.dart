import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/cubit/bloc_observe.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/local/cache_helper.dart';
import 'package:todo_app/shared/services/notification_services.dart';
import 'package:todo_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {
      return TaskCubit()
        ..changeAppMode(fromShared: isDark)
        ..createDatabase();
    }, child: Builder(builder: (context) {
      return BlocConsumer<TaskCubit, TaskStates>(
          listener: (context, TaskStates state) {},
          builder: (context, TaskStates state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeLight,
                darkTheme: themeDark,
                themeMode: TaskCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const Directionality(
                  textDirection: TextDirection.rtl, // set this property
                  child: HomeLayout(),
                ));
          });
    }));
  }
}
