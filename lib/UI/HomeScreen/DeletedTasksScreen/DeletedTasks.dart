import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/TaskModel/TaskModel.dart';
import 'package:notes/shared/cubit/appCubit.dart';
import 'package:notes/shared/cubit/appStates.dart';

import '../../../shared/components/components.dart';

class DeletedTasks extends StatelessWidget {
  const DeletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                bulidItem(context, cubit.trash[index], index),
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount: cubit.trash.length);
      },
    );
  }

  Widget bulidItem(context, TaskModel model, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {
            AppCubit.get(context).backToTasks(index);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          '${model.title}',
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
                      SizedBox(
                        width: 150,
                        child: Text(
                          '${model.content}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              wordSpacing: 1.5,
                              fontFamily: 'ARLRDBD',
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
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
                Spacer(),
/*            IconButton(
                splashColor: Colors.transparent,
                style: ButtonStyle(
                    overlayColor:
                    MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {},
                icon:
                // Image.asset('assets/Icons/deletIcon.png')
                Icon(
                  Icons.delete,
                  color: Color(0xFF666666),
                  size: 35,
                )
              //Image.asset('assets/Icons/deletIcon.png'),
            ),*/
              ],
            ),
          ),
        ),
      );
}
