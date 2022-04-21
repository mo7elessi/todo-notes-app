import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: TaskCubit.get(context).screens.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "PNU",
                  fontSize: 12,
                ),
                tabs: TaskCubit.get(context).tabs,
                indicatorColor: Colors.white,
                isScrollable: false,
                physics: const NeverScrollableScrollPhysics(),
              ),
              title: Text(
                'مهامي اليومية',
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
            body: TabBarView(
              children: TaskCubit.get(context).screens,
              physics: const BouncingScrollPhysics(),
            ),
          ),
        );
      },
    );
  }
}
