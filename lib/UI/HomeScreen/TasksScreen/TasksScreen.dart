import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/shared/cubit/appCubit.dart';
import 'package:notes/shared/cubit/appStates.dart';

import '../../../models/TaskModel/TaskModel.dart';
import '../../../shared/components/components.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetTaskLoadingState,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  bulidItem(context, cubit.tasks[index], index),
              separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: cubit.tasks.length),
        );
      },
    );
  }

  Widget bulidItem(context, TaskModel? model, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Checkbox(
              value: model!.check,
              onChanged: (value) =>
                  AppCubit.get(context).doneTask(value!, model, index),
            ),
            InkWell(
              onTap: () {
               /* showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    alignment: AlignmentDirectional.center,
                    backgroundColor: Color(0xFFE7E7EE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Column(
                        children: [
                          TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Task Title',
                                hintStyle: TextStyle(color: Colors.white),
                                contentPadding:
                                    EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Color(0xFF5248A6),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                  color: Colors.white,
                                ),
                                // prefixIconColor: Colors.white,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Task Content',
                              hintStyle: TextStyle(color: Colors.white),
                              contentPadding:
                                  EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colors.deepPurple.shade200,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.content_paste,
                                color: Colors.white,
                              ),
                              // prefixIconColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color(0xFF6C18A4),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            'Edit Note',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                    elevation: 15,
                  ),
                );*/
              },
              splashColor: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  borderOnForeground: false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: (MediaQuery.of(context).size.width * 0.8) -
                                  100,
                              child: Text(
                                "${model.title}",
                                overflow: TextOverflow.ellipsis,
                                // maxLines: 1,
                                style: TextStyle(
                                    fontFamily: 'ARLRDBD',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width * 0.8) -
                                  100,
                              child: Text(
                                '${model.content}',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${model.time}',
                              style: TextStyle(color: Colors.grey),
                            ), // ProjectTime
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${model.date}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 120,),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(
                            splashColor: Colors.transparent,
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              AppCubit.get(context).deleteTask(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFF666666),
                              size: 30,
                            ),
                          ),
                          IconButton(
                              splashColor: Colors.transparent,
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {
                                AppCubit.get(context).binTask(index,model);
                              },
                              icon: (model.bin == false
                                  ? Image.asset('assets/Icons/Icon Pin.png')
                                  : Image.asset('assets/Icons/Icon Pined.png'))),
                          // pin icon
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
