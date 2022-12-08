import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/UI/LoginScreen/cubit/loginCubit.dart';
import 'package:notes/UI/splash/splashScreen.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/shared/BlocObserver/BlocObserver.dart';
import 'package:notes/shared/cubit/appCubit.dart';
import 'UI/SignupScreen/cubit/SignupCubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();


/*  var time = DateFormat.jm().format(DateTime.now());
  var now = DateTime.now();
  String date = "${now.day} - ${now.month} - ${now.year}";
  print(date.toString());*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getNotes()..getTasks()..getTrash()..getDoneTasks(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            toolbarHeight: 0,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xFF670FA2),
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light),
          ),
          fontFamily: 'ARLRDBD',
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.deepPurple,
        ),
        home: SplashScreen(), //HomeScreen(),
      ),
    );
  }
}
