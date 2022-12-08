import 'package:flutter/material.dart';
import 'package:notes/UI/LoginScreen/loginScreen.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../SignupScreen/SignUpScreen.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.030120, //25,
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              physics: BouncingScrollPhysics(),
                children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                          height: 145,
                          width: 192,
                          child: Image.asset('assets/images/Logo.png')),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            'Reset Password',
                            style: TextStyle(
                                fontFamily: 'ARLRDBD',
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Please Choose your new password',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 325,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            cursorColor: mainColor,
                            cursorHeight: 22,
                            decoration: InputDecoration(
                              focusColor: Colors.deepPurple,
                              fillColor: Colors.deepPurple.shade200,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.white,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.purple,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.deepPurple.shade200,
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white,
                                  )),
                              hintText: 'New Password',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.purple,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.deepPurple.shade200,
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white,
                                  )),
                              hintText: 'Confirm New Password',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 263, //325,
                            // color: mainColor,
                            decoration: BoxDecoration(
                              color: Color(0xFF7F21BF),
                              borderRadius: BorderRadius.circular(23),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontFamily: 'ARLRDBD',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.0060, //5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  createRoute(
                                    LoginScreen(),
                                  ));
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              'Back To Log In',
                              style: TextStyle(
                                  color: Color(0xFF01D69A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05245 //48,
                  ),
              Image.asset(
                'assets/images/background2.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ]),
          ),
        ));
  }
}
