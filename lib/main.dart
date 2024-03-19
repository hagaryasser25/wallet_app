import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/admin/admin_home.dart';
import 'package:wallet_app/admin/admin_users.dart';
import 'package:wallet_app/auth/admin_login.dart';
import 'package:wallet_app/auth/login_screen.dart';
import 'package:wallet_app/auth/signup_screen.dart';
import 'package:wallet_app/user/receive_list.dart';
import 'package:wallet_app/user/transfer_list.dart';
import 'package:wallet_app/user/user_home.dart';
import 'package:wallet_app/user/user_report.dart';
import 'package:wallet_app/user/user_wallet.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          : FirebaseAuth.instance.currentUser!.email == "admin@gmail.com"
              ? const AdminHome()
              : UserHome(),
       routes: {
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        UserHome.routeName: (ctx) => UserHome(),
        AdminHome.routeName: (ctx) => AdminHome(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        UsersApp.routeName: (ctx) => UsersApp(),
        UserReport.routeName: (ctx) => UserReport(),
        TransferList.routeName: (ctx) => TransferList(),
        ReceiveList.routeName: (ctx) => ReceiveList(),
      },
    );
  }
}
