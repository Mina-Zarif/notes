import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/TaskModel/TaskModel.dart';
import '../../../shared/cubit/appCubit.dart';
import '../../../shared/cubit/appStates.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.0,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xFF670FA2),
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light),
              ),
              body: SafeArea(
                child: Container(
                  width: double.infinity,
                  color: Color(0xFFD1CFE8),
                  child: Column(
                    children: [
                      Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Image.asset(
                              'assets/images/Group 26.png',
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 0, left: 8, right: 8, top: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      )),
                                  Spacer(),
                                  Text(
                                    'Done Tasks',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Tooltip(
                                    message: 'Delete All Done Tasks',
                                    child: IconButton(
                                        onPressed: () {
                                          AppCubit.get(context)
                                              .alertToClearData(
                                                  context: context,
                                                  function:
                                                      AppCubit.get(context)
                                                          .clearDoneTask);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ]),
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                bulidItem(context, cubit.done[index], index),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: cubit.done.length),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget bulidItem(context, TaskModel? model, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          children: [
            SizedBox(width: 25),
            InkWell(
              onTap: () {
                /*
                showDialog(
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
                                  hintText: "Task Title",
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      25.0, 15.0, 25.0, 15.0),
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      25.0, 15.0, 25.0, 15.0),
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
                                )),
                          ],
                        )),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          height: 40,
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
                        height: 15,
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
                              width: 150,
                              child: Text(
                                "${model!.title}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    // wordSpacing: 1.5,
                                    fontFamily: 'ARLRDBD',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                "${model.content}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                    // wordSpacing: 1.5,
                                    fontFamily: 'ARLRDBD',
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${model.date}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            // ProjectDate
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${model.time}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            // ProjectTime
                            SizedBox(
                              height: 8,
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
                              AppCubit.get(context).deletDoneTask(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFF666666),
                              size: 30,
                            ),

                            //Image.asset('assets/Icons/deletIcon.png'),
                          ),
                          /* IconButton(
                              splashColor: Colors.transparent,
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {},
                              icon: Image.asset('assets/Icons/Icon Pin.png')),*/
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
