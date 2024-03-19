import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallet_app/auth/login_screen.dart';
import 'package:wallet_app/models/users_model.dart';
import 'package:wallet_app/user/receive_list.dart';
import 'package:wallet_app/user/transfer_list.dart';
import 'package:wallet_app/user/user_transfer.dart';
import 'package:wallet_app/user/user_wallet.dart';

class UserReport extends StatefulWidget {
  static const routeName = '/userReport';
  const UserReport({super.key});

  @override
  State<UserReport> createState() => _UserReportState();
}

class _UserReportState extends State<UserReport> {
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
                "التقارير",
                style: TextStyle(color: Colors.white),
              )),
            ),
            body: Column(
              children: [
                Center(
                    child:
                        Image.asset("assets/images/trans.jpg", height: 320.h)),
                Padding(
                  padding: EdgeInsets.only(right: 65.w, left: 65.w, top: 15.h),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, TransferList.routeName);
                          },
                          child: card("تقارير التحويل", Icons.send)),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {Navigator.pushNamed(
                                context, ReceiveList.routeName);},
                          child: card("تقارير الأستلام", Icons.money)),
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
