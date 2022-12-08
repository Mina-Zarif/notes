import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/UI/HomeScreen/HomeScreen.dart';
import 'package:notes/UI/LoginScreen/cubit/loginState.dart';
import 'package:notes/UI/SignupScreen/SignUpScreen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../Reset Password/ResetPassword.dart';
import 'cubit/loginCubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.06024,
          ),
          body: Form(
            key: formKey,
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 1.0,
                color: Colors.white,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.042168,
                            ),
                            Center(
                              child: SizedBox(
                                  height: 145,
                                  width: 192,
                                  child: Image.asset('assets/images/Logo.png')),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              width: 325,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: cubit.email,
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
                                        borderSide:
                                            BorderSide(color: mainColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'Please Enter Email'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: cubit.password,
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
                                          onPressed: () {
                                            cubit.showPassword();
                                          },
                                          icon: Icon(
                                            cubit.isShowen
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Colors.white,
                                          )),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !cubit.isShowen,
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'Please Enter Password'
                                          : null;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            createNavigator(
                                                context, ResetPassword());
                                            /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ResetPassword(),
                                                ));*/
                                          },
                                          style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent)),
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                fontFamily: 'ARLRDBD',
                                                color: Color(0xFF01D69A),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 263, //325,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7F21BF),
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.loginProcess(context);
                                        }
                                      },
                                      child: Text(
                                        'Log in',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ARLRDBD',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Don\'t have an account?',
                                        style:
                                            defultTextStyle(Color(0xFF01D69A)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          createNavigator(
                                              context, SignUpScreen());
                                        },
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: Text(
                                          'Sign Up',
                                          style: defultTextStyle(mainColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            // Spacer(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.098360 //90,
                        ),
                    Image.asset(
                      'assets/images/background2.png',
                      fit: BoxFit.contain,
                      alignment: AlignmentDirectional.bottomCenter,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
