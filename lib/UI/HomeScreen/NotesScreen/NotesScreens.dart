import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/NoteModel/NoteModel.dart';
import 'package:notes/shared/components/components.dart';
import 'package:notes/shared/cubit/appCubit.dart';
import 'package:notes/shared/cubit/appStates.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  bulidItem(context, cubit.notes[index],index),
              separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: cubit.notes.length);
        });
  }

  Widget bulidItem(context, NoteModel model,index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {
            /*showDialog(
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
                    height: 20,
                  ),
                ],
                elevation: 15,
              ),
            );*/
          },
          splashColor: Colors.transparent,
          child: Card(
            elevation: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset('assets/images/ProjectImage.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        model.abstract!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            wordSpacing: 1.5,
                            fontFamily: 'ARLRDBD',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
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
                Spacer(),
                IconButton(
                    splashColor: Colors.transparent,
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      AppCubit.get(context).deleteNote(index);

                    },
                    icon:
                        Icon(
                      Icons.delete,
                      color: Color(0xFF666666),
                      size: 30,
                    )),
              ],
            ),
          ),
        ),
      );
}
