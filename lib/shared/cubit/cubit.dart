import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/madules/notes/notes.dart';
import 'package:todo_app/madules/tasks/archive.dart';
import 'package:todo_app/madules/tasks/done_task.dart';
import 'package:todo_app/madules/tasks/new_task.dart';
import 'package:todo_app/madules/tasks/tasks.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/local/cache_helper.dart';
import 'package:todo_app/shared/services/notification_services.dart';
import 'package:todo_app/shared/styles/colors.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(AppInitialState());

  static TaskCubit get(context) => BlocProvider.of(context);

  List<Widget> tabs = const [
    Text('المهام'),
    Text('المؤجلة'),
    Text('المنتهية'),
  ];

  List<Widget> screens = const [NewTask(), ArchiveTask(), DoneTask()];

//bottom navigation
  int currentIndex = 0;
  List<Widget> buildScreens = [const Tasks(), const Notes()];
  List<String> appBarTitle = ['مهامي اليومية', 'ملاحظاتي'];
  List<BottomNavigationBarItem> navBarsItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.notes_sharp), label: 'Tasks'),
    const BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
  ];

  void onClickItemNav(int index) {
    currentIndex = index;
    emit(BottomNavigationState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Map> searchTasks = [];
  List<Map> lateTasks = [];

  List<Map> notes = [];

  String btnMessage = '';
  Map taskModel = {};

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 2,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT ,date date, time time, status TEXT)')
            .then((value) {
          print('table tasks created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
        database
            .execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, description TEXT ,date TEXT)')
            .then((value) {
          print('table notes created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        getNoteFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(TaskCreateDatabaseState());
    });
  }

  insertTaskToDatabase(
      {required String title,
      String? description,
      required String time,
      required String date,
      required context}) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title, description,date, time, status) VALUES("$title","$description", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully');
        emit(TaskInsertState());
        toastMessage(
            message: 'تم الإضافة', color: primaryColor, context: context);

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  insertNoteToDatabase(
      {required String title,
      String? description,
      required String date,
      required context}) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO notes(title, description,date) VALUES("$title","$description", "$date")')
          .then((value) {
        print('$value inserted successfully');
        emit(NoteInsertState());
        toastMessage(
            message: 'تم الإضافة', color: primaryColor, context: context);
        getNoteFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database
        .rawQuery('SELECT * FROM tasks ORDER BY date,time ASC')
        .then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
          // newTasks.sort((a,b) => a[element['date']].compareTo(b[element['date']]));
        }
        if (element['status'] == 'done') {
          doneTasks.add(element);
        }
        if (element['status'] == 'archive') {
          archivedTasks.add(element);
        }
      });
      emit(TaskGetState());
    });
  }

  void getNoteFromDatabase(database) {
    notes = [];
    database.rawQuery('SELECT * FROM notes').then((value) {
      value.forEach((element) {
        notes.add(element);
      });
      emit(NoteGetState());
    });
  }

  void updateStatusTask(
      {required String status, required int id, required context}) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      String message = "";
      switch (status) {
        case 'done':
          message = "تم إكمال مهمة واحدة";
          NotifyHelper().cancelSendNotification(id: id);
          break;
        case 'archive':
          message = "تمت الأرشفة";
          break;
        case 'new':
          message = "تمت الإعادة";
      }
      toastMessage(message: message, color: primaryColor, context: context);

      getDataFromDatabase(database);
      emit(TaskUpdateStatusState());
    });
  }

  void deleteTask({required int id, required context}) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      toastMessage(message: 'تم الحذف', color: Colors.red, context: context);
      getDataFromDatabase(database);
      NotifyHelper().cancelSendNotification(id: id);

      emit(TaskDeleteState());
    });
  }

  void deleteNote({required int id, required context}) async {
    database!.rawDelete('DELETE FROM notes WHERE id = ?', [id]).then((value) {
      toastMessage(message: 'تم الحذف', color: Colors.red, context: context);
      getNoteFromDatabase(database);
      emit(NoteDeleteState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.add;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(TaskChangeBottomSheetState());
  }

  void searchTask({
    required String text,
  }) async {
    emit(TaskSearchState());
    database!
        .query('SELECT * FROM tasks WHERE title LIKE %$text%')
        .then((value) {
      for (var element in value) {
        searchTasks.add(element);
        print(element);
      }
      getDataFromDatabase(database);
      emit(TaskSearchState());
    });
  }

  void editTask(
      {required int id,
      required String title,
      String? description,
      String? time,
      String? date,
      required context}) {
    emit(TaskEditLoadingState());
    database!.rawUpdate(
      'UPDATE tasks SET title = ?,description = ? ,time = ?, date = ? WHERE id = ?',
      [title, description, time, date, id],
    ).then((value) {
      toastMessage(
          message: 'تم التعديل', color: primaryColor, context: context);

      getDataFromDatabase(database);
      emit(TaskEditState());
    });
  }

  void editNote(
      {required int id,
      required String title,
      String? description,
      required context}) {
    notes = [];
    emit(NoteEditLoadingState());
    database!.rawUpdate(
      'UPDATE notes SET title = ?,description = ? WHERE id = ?',
      [title, description, id],
    ).then((value) {
      toastMessage(
          message: 'تم التعديل', color: primaryColor, context: context);
      getNoteFromDatabase(database);
      emit(NoteEditState());
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    // ignore: unnecessary_null_comparison
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
