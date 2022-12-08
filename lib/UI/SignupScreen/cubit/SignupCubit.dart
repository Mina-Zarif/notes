import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/UI/HomeScreen/HomeScreen.dart';
import 'package:notes/shared/components/components.dart';
import '../../../models/UserModel/UserModel.dart';
import 'SignupStates.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialStates());

  static SignupCubit get(context) => BlocProvider.of(context);
  bool isShowen = false;

  void showPassword() {
    isShowen = !isShowen;
    emit(ShowingAndHidingPassword());
  }

  var username = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var confirmPassword = TextEditingController();

  void signupProcess(context) {
    if (password.text == confirmPassword.text) {
      emit(SignupProcessLoading());
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        storeUserData(
            uid: value.user!.uid, username: username.text, email: email.text);
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomeScreen(),
            ));
        showToast(msg: "success", state: ToastStates.SUCCESS);
        email.text = '';
        password.text = '';
        username.text = '';
        confirmPassword.text = '';
        emit(SignupProcessSuccess());
      }).catchError((error) {
        emit(SignupProcessError());
      });
    } else {
      showToast(msg: "please check password", state: ToastStates.ERROR);
    }
  }

  void storeUserData({username, uid, email}) {
    UserModel model = UserModel(
      username: username,
      email: email,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid.toString())
        .set(model.toJson())
        .then((value) {
      emit(StoreDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(StoreDataError());
    });
  }
}
//    "userName" : "mina",
//     "email": "mina10@gmail.com",
//     "password" : "mina123456",
//     "confirmPassword":"mina123456"
