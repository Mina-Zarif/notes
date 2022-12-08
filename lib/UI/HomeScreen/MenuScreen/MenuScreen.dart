import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/UI/LoginScreen/loginScreen.dart';
import 'package:notes/shared/components/constants.dart';
import 'package:notes/shared/cubit/appCubit.dart';
import 'package:notes/shared/cubit/appStates.dart';
import 'package:notes/shared/local/cacheHelper/cacheHelper.dart';

import '../../contactUs/contactUs.dart';
import '../DoneTasks/DoneTasksScreen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        right: false,
        child: Drawer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontFamily: 'ARLRDBD',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Image.asset('assets/images/Logo.png'),
              ),
              Divider(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8, right: 25, left: 25, top: 8),
                child: InkWell(
                  onTap: () {
                    // print('Done Tasks');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoneTasks(),
                        ));
                  },
                  splashColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF5248A6),
                        borderRadius: BorderRadius.circular(6)),
                    height: 55,
                    child: Row(
                      children: [
                        SizedBox(width: 12),
                        Image.asset('assets/Icons/Icon Done All.png'),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Done Tasks',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8, right: 25, left: 25, top: 8),
                child: InkWell(
                  onTap: () {
                    // print('Contact Us');
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(),
                      ),
                    );*/
                    AppCubit.get(context).mailUs();
                  },
                  splashColor: Colors.transparent,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Image.asset('assets/Icons/Icon Exclamation.png'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      labelText: 'Contact Us',
                      labelStyle:
                          TextStyle(color: Colors.white, fontFamily: 'ARLRDBD'),
                      fillColor: Color(0xFF9863C2),
                      filled: true,
                    ),
                    enabled: false,
                    keyboardType: TextInputType.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8, right: 25, left: 25, top: 8),
                child: InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF5248A6),
                        borderRadius: BorderRadius.circular(6)),
                    height: 55,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 13,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
