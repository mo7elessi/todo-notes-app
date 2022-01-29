import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'dart:ui' as ui;

class AddEditTaskOrNote extends StatelessWidget {
  int numPage;
  String status;
  Map? model;

  AddEditTaskOrNote(this.numPage, this.status, {this.model});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (BuildContext context, state) {
        if (state is TaskInsertState) {
          Navigator.pop(context);
          titleController.text = '';
          detailsController.text = '';
          timeController.text = '';
          dateController.text = '';
        }
        if (state is NoteInsertState) {
          Navigator.pop(context);
          titleController.text = '';
          detailsController.text = '';
        }
        if (state is NoteEditState ||
            state is TaskEditState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, TaskStates state) {
        if (model != null && numPage == 1) {
          titleController.text = model!['title'];
          detailsController.text = model!['description'];
        }
        if (model != null && numPage == 0) {
          titleController.text = model!['title'];
          detailsController.text = model!['description'];
          dateController.text = model!['date'];
          timeController.text = model!['time'];
        }
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  if (numPage == 0
                      ? titleController.text.isEmpty ||
                          timeController.text.isEmpty ||
                          dateController.text.isEmpty
                      : titleController.text.isEmpty) {
                    scaffoldKey.currentState!.showSnackBar(
                      SnackBar(
                        content: Text(
                          'يرجى ملء الحقول المطلوبة',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        padding: const EdgeInsets.all(5),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    if (status == 'add') {
                      if (numPage == 0) {
                        TaskCubit.get(context).insertTaskToDatabase(
                            title: titleController.text,
                            description: detailsController.text,
                            time: timeController.text,
                            date: dateController.text,
                            context: context);
                      } else {
                        TaskCubit.get(context).insertNoteToDatabase(
                            title: titleController.text,
                            description: detailsController.text,
                            date: dateController.text =
                                DateFormat.yMMMd().format(DateTime.now()),
                            context: context);
                      }
                    } else {
                      if (numPage == 0) {
                        TaskCubit.get(context).editTask(
                            title: titleController.text,
                            description: detailsController.text,
                            time: timeController.text,
                            date: dateController.text,
                            context: context,
                            id: model!['id']);
                      } else {
                        TaskCubit.get(context).editNote(
                            title: titleController.text,
                            description: detailsController.text,
                            id: model!['id'],
                            context: context);
                      }
                    }
                  }
                },
                icon: Icon(Icons.check),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.arrow_forward_sharp, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              //    automaticallyImplyLeading: false,
              title: Text(
                status == 'add'
                    ? numPage == 0
                        ? 'اضافة مهمة '
                        : 'اضافة ملاحظة '
                    : numPage == 0
                        ? 'تعديل المهمة'
                        : 'تعديل الملاحظة',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textField(
                          onTap: () {},
                          context: context,
                          controller: titleController,
                          keyboard: TextInputType.text,
                          validator: () {},
                          hintText:
                              numPage == 0 ? "عنوان المهمة" : "عنوان الملاحظة",
                          suffixIcon: Icons.title),
                      const SizedBox(height: 8.0),
                      if (numPage == 0)
                        Column(
                          children: [
                            textField(
                                validator: () {},
                                context: context,
                                controller: dateController,
                                keyboard: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2023-01-01'),
                                  ).then((value) {
                                    dateController.text  = DateFormat().add_yMMMd().format(value!);
                                  });
                                },
                                hintText: 'تاريخ المهمة',
                                suffixIcon: Icons.date_range),
                            const SizedBox(
                              height: 8,
                            ),
                            textField(
                                validator: () {},
                                context: context,
                                controller: timeController,
                                keyboard: TextInputType.text,
                                onTap: () {
                                  showTimePicker(
                                    initialEntryMode: TimePickerEntryMode.dial,
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context);
                                    //  00:00:00.0000000
                                    print("Time >>> " + value.toString());
                                  });
                                },
                                hintText:
                                    /* TimeOfDay.now().format(context).toString()*/ 'وقت انجاز المهمة',
                                suffixIcon: Icons.watch_later),
                          ],
                        ),
                      const SizedBox(height:8.0),
                   /*   Container(
                        width: double.infinity,
                          child: Text('مزيد من التفاصيل',style: Theme.of(context).textTheme.headline3,)),
                      const SizedBox(height: 6.0),*/
                      textFieldNoIcon(
                          max: 100,
                          onTap: () {},
                          description: true,
                          context: context,
                          controller: detailsController,
                          keyboard: TextInputType.multiline,
                          validator: () {},
                          hintText: "مزيد من التفاصيل (اختياري)",),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
