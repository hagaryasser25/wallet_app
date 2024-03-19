import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallet_app/admin/admin_users.dart';
import 'package:wallet_app/auth/login_screen.dart';
import 'package:wallet_app/models/users_model.dart';
import 'package:wallet_app/user/user_wallet.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
      print(currentUser.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Center(
                  child: Text(
                'الصفحة الرئيسية',
                style: TextStyle(color: Colors.white),
              )),
            ),
            body: Column(
              children: [
                Center(
                    child:
                        Image.asset("assets/images/wallet.png", height: 320.h)),
                Text(
                  "الخدمات",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Lemonada',
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    right: 65.w,
                    left: 65.w,
                    top: 15.h
                  ),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, UsersApp.routeName);
                          },
                          child: card("التقارير", Icons.content_paste_sharp)),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(
                                              context, LoginScreen.routeName);
                                        },
                                        child: Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('لا'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: card("تسجيل الخروج", Icons.logout)),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget card(String text, IconData icon) {
  return Container(
    color: HexColor('#ffffff'),
    child: Card(
      elevation: 0.5,
      color: HexColor('#ffffff'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 100.w,
        height: 130.h,
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor('#fae1d6'),
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 243, 113, 73),
            ),
            alignment: Alignment.center,
          ),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                fontSize: 16,
              ))
        ]),
      ),
    ),
  );
}
