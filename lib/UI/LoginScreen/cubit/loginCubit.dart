import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/UserModel/UserModel.dart';
import '../../../shared/components/components.dart';
import '../../HomeScreen/HomeScreen.dart';
import 'loginState.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(AppInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isShowen = false;

  var email = TextEditingController();
  var password = TextEditingController();

  void showPassword() {
    isShowen = !isShowen;
    emit(ShowingAndHidingPassword());
  }

  UserModel? userModel;

  void loginProcess(context) {
    emit(LoginStateLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      showToast(msg: "success", state: ToastStates.SUCCESS);
      emit(LoginStateSuccess());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
      email.text = "";
      password.text = "";
      emit(LoginStateSuccess());
    }).catchError((error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
        showToast(
            msg: "No user found for that email.", state: ToastStates.ERROR);
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showToast(
            msg: "Wrong password provided for that user.",
            state: ToastStates.ERROR);
      }
      emit(LoginStateError());
    });
  }
}
