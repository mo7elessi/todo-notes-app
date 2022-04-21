import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo_app/madules/add_edit/add_edit.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
        listener: (BuildContext context, TaskStates state) {},
        builder: (BuildContext context, TaskStates state) {
          TaskCubit cubit = TaskCubit.get(context);
          return Scaffold(
            body: cubit.buildScreens[cubit.currentIndex],
            floatingActionButton: SpeedDial(
              icon: Icons.add,
              iconTheme: const IconThemeData(color: Colors.white),
              activeIcon: Icons.close,
              curve: Curves.bounceIn,
              overlayOpacity: 0.0,
              shape: const CircleBorder(),
              spaceBetweenChildren: 10.0,
              children: [
                SpeedDialChild(
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.notes_sharp,
                      color: primaryColor,
                    ),
                  ),
                  labelBackgroundColor: primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditTaskOrNote(0, 'add'),
                        ));
                  },
                ),
                SpeedDialChild(
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.note_sharp,
                        color: primaryColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditTaskOrNote(1, 'add'),
                          ));
                    }),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.navBarsItems,
              onTap: (index) {
                cubit.onClickItemNav(index);
              },
            ),
          );
        });
  }
}
