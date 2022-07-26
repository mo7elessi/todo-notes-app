import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo_app/madules/add_edit/add_edit.dart';
import 'package:todo_app/madules/notes/note_details.dart';
import 'package:todo_app/madules/tasks/task_details.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/styles/colors.dart';
import '../services/notification_services.dart';

Widget textField(
    {required TextEditingController controller,
    required TextInputType keyboard,
    required Function validator,
    required String hintText,
    bool isClick = true,
    IconData? prefixIcon,
    required context,
    required Function onTap,
    Function? onSubmit,
    bool? description = false}) {
  return SizedBox(
    child: TextFormField(
      controller: controller,
      textInputAction: TextInputAction.newline,
      //  expands: true,
      keyboardType: keyboard,
      style: Theme.of(context).textTheme.headline6,
      textAlignVertical: TextAlignVertical.top,
      cursorColor: primaryColor,
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12)),
      onTap: () => onTap(),
    ),
  );
}

Widget button({
  bool isUppercase = true,
  double radius = 5.0,
  required Function function,
  required String text,
  required bool done,
  Color color = primaryColor,
}) {
  return SizedBox(
    child: TextButton(
      onPressed: () => function(),
      child: Text(isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
              color: color,
              fontSize: 14.0,
              fontFamily: 'PNU',
              fontWeight: FontWeight.bold)),
    ),
  );
}

Widget taskItem(context, Map model) {
  //date
  String date = model['date'];
  String year = date.split("/")[0];
  String month = date.split("/")[1];
  String day = date.split("/")[2];

  //hour
  String time = model['time'].split(" ")[0];
  String isPM = model['time'].split(" ")[1];
  String hour = time.split(":")[0];
  String minute = time.split(":")[1];
  int value = isPM == "PM" ? 12 : 0;
  NotifyHelper().scheduledNotification(int.parse(year), int.parse(month),
      int.parse(day), int.parse(hour) + value, int.parse(minute), {
    "title": model['title'],
    "id": model['id'],
  });

  return Slidable(
    actionPane: const SlidableDrawerActionPane(),
    actions: [
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: itemAction(
            color: Colors.red,
            context: context,
            icon: Icons.delete,
            function: () {
              return TaskCubit.get(context)
                  .deleteTask(id: model['id'], context: context);
            }),
      ),
    ],
    child: GestureDetector(
      onTap: () {
        TaskCubit.get(context).taskModel = model;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetails(model),
            ));
      },
      child: Card(
        elevation: 0.5,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              model['status'] == 'new' || model['status'] == 'archive'
                  ? RoundCheckBox(
                      size: 32,
                      checkedColor: primaryColor,
                      borderColor: secondaryColor,
                      isChecked: model['status'] == "done" ? true : false,
                      animationDuration: const Duration(
                        microseconds: 3000,
                      ),
                      onTap: (selected) {
                        if (model['status'] == "done") {
                          return false;
                        } else {
                          Timer(const Duration(milliseconds: 100), () {
                            if (model['status'] == 'new') {
                              TaskCubit.get(context).updateStatusTask(
                                  status: 'done',
                                  id: model['id'],
                                  context: context);
                            }
                            if (model['status'] == 'archive') {
                              TaskCubit.get(context).updateStatusTask(
                                  status: 'done',
                                  id: model['id'],
                                  context: context);
                            }
                            if (model['status'] == 'done') {
                              TaskCubit.get(context).updateStatusTask(
                                  status: 'new',
                                  id: model['id'],
                                  context: context);
                            }
                          });
                        }
                      })
                  : const Icon(
                      Icons.check,
                      color: primaryColor,
                    ),
              const SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: 280.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${model['title']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: model['status'] == 'new' ||
                                model['status'] == 'archive'
                            ? Theme.of(context).textTheme.headline6
                            : Theme.of(context).textTheme.headline2),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Text('${model['date']} - in ${model['time']}',
                            style: Theme.of(context).textTheme.subtitle1),
                        const Spacer(),
                        if (model['date'] ==
                            DateFormat.yMd().format(DateTime.now()))
                          const Text(
                            'اليوم',
                            style: TextStyle(color: primaryColor, fontSize: 10),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget taskBuilder({
  required List<Map> tasks,
  required int page,
}) {
  return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return taskItem(context, tasks[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(
                //  height: 5.0,
                ),
            itemCount: tasks.length,
          ),
        );
      },
      fallback: (context) {
        String message = "";
        if (page == 0) message = "لا يوجد مهام جديدة";
        if (page == 1) message = "لا يوجد مهام مكتملة";
        if (page == 2) message = "لا يوجد مهام مؤجلة";
        return Center(
          child: Text(message, style: Theme.of(context).textTheme.bodyText1),
        );
      });
}

void toastMessage(
    {required String message, required Color color, required context}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget noteItem(context, Map model) {
  return Slidable(
    actionPane: const SlidableDrawerActionPane(),
    actions: [
      Column(
        children: [
          Expanded(
            child: itemAction(
                color: primaryColor,
                context: context,
                icon: Icons.edit,
                function: () {
                  return Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AddEditTaskOrNote(1, 'edit', model: model);
                    },
                  ));
                }),
          ),
          Expanded(
            child: itemAction(
                color: Colors.red,
                context: context,
                icon: Icons.delete,
                function: () {
                  return TaskCubit.get(context)
                      .deleteNote(id: model['id'], context: context);
                }),
          ),
        ],
      ),
    ],
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NoteDetails(model)));
      },
      child: Card(
        elevation: 0.5,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 330.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${model['title']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6),
                        const SizedBox(height: 4.0),
                        Text('${model['description']}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle2),
                        const SizedBox(height: 4.0),
                        Text(' تاريخ الإضافة ${model['date']}',
                            style: Theme.of(context).textTheme.subtitle1),
                        const SizedBox(height: 2.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget noteBuilder({
  required List<Map> notes,
}) {
  return ConditionalBuilder(
      condition: notes.isNotEmpty,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return noteItem(context, notes[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(
                // height: 5.0,
                ),
            itemCount: notes.length,
          ),
        );
      },
      fallback: (context) {
        return Center(
          child: Text('لا يوجد ملاحظات حاليا',
              style: Theme.of(context).textTheme.bodyText1),
        );
      });
}

Widget itemAction(
    {required context,
    required color,
    required IconData icon,
    required Function function}) {
  return InkWell(
    onTap: () => function(),
    child: Container(
      margin: const EdgeInsets.all(5),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadiusDirectional.circular(4)),
      child: Icon(icon, size: 28.0, color: Colors.white),
    ),
  );
}
