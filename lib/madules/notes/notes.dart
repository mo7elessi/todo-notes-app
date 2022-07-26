import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, TaskStates state) {

      },
      builder: (context, TaskStates state) {
        var notes = TaskCubit.get(context).notes.reversed;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'ملاحظاتي',
              style: Theme.of(context).textTheme.headline4,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  TaskCubit.get(context).changeAppMode();
                },
                icon: TaskCubit.get(context).isDark
                    ? const Icon(Icons.lightbulb_outline)
                    : const Icon(Icons.lightbulb),
              )
            ],
          ),
          body: noteBuilder(notes: notes.toList()),
        );
      },
    );
  }
}
