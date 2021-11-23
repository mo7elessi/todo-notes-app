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
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              activeIcon: Icons.close,
              curve: Curves.bounceIn,
              overlayOpacity: 0.0,
              shape: CircleBorder(),
              spaceBetweenChildren: 10.0,
              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.notes,
                  ),
                  labelWidget: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('مهمة',style: Theme.of(context).textTheme.subtitle2),
                  ),
                  labelBackgroundColor: primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditTaskOrNote(0,'add'),
                        ));
                  },
                ),
                SpeedDialChild(
                    child: Icon(
                      Icons.event_note,
                    ),
                    labelWidget: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('ملاحظة',style: Theme.of(context).textTheme.subtitle2),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditTaskOrNote(1,'add'),
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
