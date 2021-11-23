import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class DoneTask extends StatelessWidget {
  const DoneTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit,TaskStates>(
        listener: (context, state) {},
    builder: (context, state) {
    var doneTasks = TaskCubit.get(context).doneTasks;

    return taskBuilder(tasks: doneTasks,page: 1);
    }
    );
  }
}
