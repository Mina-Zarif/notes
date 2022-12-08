import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/shared/cubit/appCubit.dart';
import 'package:notes/shared/cubit/appStates.dart';

import 'MenuScreen/MenuScreen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  var ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final noteKey = GlobalKey<FormState>();
        final taskKey = GlobalKey<FormState>();

        return Scaffold(
          key: ScaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.0,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xFF670FA2),
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light),
          ),
          drawer: MenuScreen(),
          body: SafeArea(
            child: Container(
              width: double.infinity,
              color: Color(0xFFD1CFE8),
              child: Column(
                children: [
                  Stack(alignment: AlignmentDirectional.topCenter, children: [
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
                              ScaffoldKey.currentState!.openDrawer();
                            },
                            icon: Image.asset(
                              'assets/Icons/Group 3.png', // menu
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            AppCubit.get(context)
                                .titles[AppCubit.get(context).index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Tooltip(
                            message: AppCubit.get(context)
                                .msg[AppCubit.get(context).index],
                            child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .alertToClear(context: context);

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
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        AppCubit.get(context)
                            .screens[AppCubit.get(context).index],

                        Visibility(
                          visible:
                              AppCubit.get(context).index != 2, // condition
                          child: SizedBox(
                              width: double.infinity,
                              child: Image(
                                image: AssetImage('assets/images/Path 7.2.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        // SizedBox(height: 1,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).index,
            onTap: (value) => AppCubit.get(context).currentIndex(value),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            unselectedItemColor: Color(0xFF666666),
            items: [
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                    backgroundColor: AppCubit.get(context).index == 0
                        ? Colors.grey[300]
                        : Colors.transparent,
                    radius: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/Icons/Group 2.png'),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                      backgroundColor: AppCubit.get(context).index == 1
                          ? Colors.grey[300]
                          : Colors.transparent,
                      radius: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/Icons/Icon Tasks.png'),
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                    backgroundColor: AppCubit.get(context).index == 2
                        ? Colors.grey[300]
                        : Colors.transparent,
                    radius: 20,
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: Color(0xFF666666),
                      size: 28,
                    ),
                  ) /*Image.asset('assets/Icons/deletIcon.png')*/,
                  label: ''),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Visibility(
            visible: AppCubit.get(context).index != 2,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF8230BD),
              onPressed: () {
                if (AppCubit.get(context).index == 0) {
                  // Note
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
                        child: Form(
                          key: noteKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                controller: AppCubit.get(context).note,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Please Enter Note'
                                      : null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Note Abstract',
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
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      // width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            //camera
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/Icons/Icon Camera.png'),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Camera',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      // width: ,
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/Icons/Icon Gallery.png'),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Gallery',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              AppCubit.get(context).storeNote(context);
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFF6C18A4),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                'Add Note',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                      elevation: 15,
                    ),
                  );
                } else {
                  // Add Task
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
                        child: Form(
                          key: noteKey,
                          child: Column(
                            children: [
                              TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: AppCubit.get(context).taskTitle,
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? 'Please Enter Task Title'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Task Title',
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
                                controller: AppCubit.get(context).taskContent,
                                style: TextStyle(color: Colors.white),
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Please Enter Task Content'
                                      : null;
                                },
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            onTap: () {
                              AppCubit.get(context).storeProject();
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFF6C18A4),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                'Add Task',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                      elevation: 15,
                    ),
                  );
                }
              },
              child: Icon(
                Icons.add_rounded,
                size: 40,
              ),
            ),
          ),
        );
      },
    );
  }
}
