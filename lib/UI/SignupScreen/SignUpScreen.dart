import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/UI/LoginScreen/loginScreen.dart';
import 'package:notes/UI/SignupScreen/cubit/SignupCubit.dart';
import 'package:notes/UI/SignupScreen/cubit/SignupStates.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SignupCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.024096,
          ),
          body: Container(
            color: Colors.white,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.15846, // 145,
                          width: 192,
                          child: Image.asset('assets/images/Logo.png'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 325,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                cursorColor: mainColor,
                                cursorHeight: 22,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  focusColor: Colors.deepPurple,
                                  fillColor: Colors.deepPurple.shade200,
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                controller: cubit.username,
                                validator: (value) => value!.isEmpty
                                    ? 'Please Enter Username'
                                    : null,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please Enter Email'
                                    : null,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: cubit.email,
                                cursorColor: mainColor,
                                cursorHeight: 22,
                                keyboardType: TextInputType.emailAddress,
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
                                validator: (value) => value!.isEmpty
                                    ? 'Please Enter Password'
                                    : null,
                                controller: cubit.password,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.purple,
                                keyboardType: TextInputType.visiblePassword,
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
                                    ),
                                  ),
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
                                obscureText: !cubit.isShowen,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please Enter Password'
                                    : null,
                                controller: cubit.confirmPassword,
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !cubit.isShowen,
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
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0163934,
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
                                      cubit.signupProcess(context);
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: defultTextStyle(Color(0xFF01D69A)),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    onPressed: () {
                                      createNavigator(context, LoginScreen());
                                    },
                                    child: Text(
                                      'Log In',
                                      style: defultTextStyle(mainColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07322,
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/background2.png',
                  alignment: AlignmentDirectional.bottomCenter,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
