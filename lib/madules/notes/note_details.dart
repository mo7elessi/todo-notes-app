// ignore: file_names
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/madules/add_edit/add_edit.dart';
import 'dart:ui' as ui;
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

// ignore: must_be_immutable
class NoteDetails extends StatelessWidget {
  Map model;

  NoteDetails(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
        listener: (BuildContext context, TaskStates state) {
      if (state is NoteDeleteState) {
        Navigator.pop(context);
      }
    }, builder: (BuildContext context, TaskStates state) {
      return ConditionalBuilder(
        // ignore: unnecessary_null_comparison
        condition: model != null,
        fallback: (context) => const Center(child: CircularProgressIndicator()),
        builder: (BuildContext context) {
          var scaffoldKey = GlobalKey<ScaffoldState>();
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditTaskOrNote(1, 'edit', model: model),
                        ));
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    TaskCubit.get(context)
                        .deleteNote(id: model['id'], context: context);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                ),

              ]),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child:  Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(model['title'],
                            style: Theme.of(context).textTheme.headline5),
                        const SizedBox(height: 10.0),
                        Text(
                          model['description'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacer(),
                        Text(' تاريخ الإضافة : ' + model['date'],
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                ),
                ),
              );
        },
      );
    });
  }
}
