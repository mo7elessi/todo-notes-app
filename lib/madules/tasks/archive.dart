import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class ArchiveTask extends StatelessWidget {
  const ArchiveTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit,TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var archivedTasks = TaskCubit.get(context).archivedTasks;

        return taskBuilder(tasks: archivedTasks, page: 2);
      },
    );
  }
}
