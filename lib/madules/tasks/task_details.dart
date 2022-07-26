import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/madules/add_edit/add_edit.dart';
import 'package:todo_app/madules/tasks/new_task.dart';
import 'package:todo_app/model/task_model.dart';
import 'dart:ui' as ui;
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/services/notification_services.dart';
import 'package:todo_app/shared/styles/colors.dart';

// ignore: must_be_immutable
class TaskDetails extends StatelessWidget {
  Map model;

  TaskDetails(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
        listener: (BuildContext context, TaskStates state) {
      if (state is TaskDeleteState || state is TaskUpdateStatusState) {
        Navigator.pop(context);
      }

    }, builder: (BuildContext context, TaskStates state) {
      if (model['status'] == 'new') {
        TaskCubit.get(context).btnMessage = 'تعليم مكتمل';
      } else if (model['status'] == 'archive') {
        TaskCubit.get(context).btnMessage = 'تعليم مكتمل';
      } else {
        TaskCubit.get(context).btnMessage = 'تعليم غير مكتمل';
      }
      TaskCubit cubit = TaskCubit.get(context);
      return ConditionalBuilder(
        // ignore: unnecessary_null_comparison
        condition: model != null,
        fallback: (context) => const Center(child: CircularProgressIndicator()),
        builder: (BuildContext context) {
          var scaffoldKey2 = GlobalKey<ScaffoldState>();
          return Scaffold(
              key: scaffoldKey2,
              appBar: AppBar(actions: [
                IconButton(
                  onPressed: () {
                    cubit
                        .deleteTask(id: model['id'], context: context);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                ),
                if (model['status'] == 'archive')
                  IconButton(
                      icon: const Icon(Icons.assignment_return),
                      color: Colors.white,
                      onPressed: () {
                        return cubit.updateStatusTask(
                            status: 'new', id: model['id'], context: context);
                      }),
                if (model['status'] == 'new')
                  IconButton(
                    onPressed: () {
                      cubit.updateStatusTask(
                          status: 'archive', id: model['id'], context: context);
                    },
                    icon: const Icon(Icons.archive),
                    color: Colors.white,
                  ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditTaskOrNote(0, 'edit',model: model),
                        ));
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                ),
              ]),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model['title'],
                          style: Theme.of(context).textTheme.headline5),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (model['description'] != null)
                        Text(
                          model['description'],
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.watch_later),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(model['time'],
                              style: Theme.of(context).textTheme.bodyText1),
                          const Spacer(),
                          const Icon(Icons.date_range),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(model['date'],
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        color: Colors.teal.shade50,
                        child: Center(
                          child: button(
                            done: model['status'] == 'done' ? true : false,
                            function: () {
                              if (model['status'] == 'new') {
                                cubit.updateStatusTask(
                                    status: 'done',
                                    id: model['id'],
                                    context: context);
                              }
                              if (model['status'] == 'archive') {
                                cubit.updateStatusTask(
                                    status: 'done',
                                    id: model['id'],
                                    context: context);
                              }
                              if (model['status'] == 'done') {
                                cubit.updateStatusTask(
                                    status: 'new',
                                    id: model['id'],
                                    context: context);
                              }
                            },
                            text: cubit.btnMessage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
    });
  }
}
