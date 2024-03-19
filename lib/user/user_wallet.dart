import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:wallet_app/user/user_home.dart';

class UserWallet extends StatefulWidget {
  String name;
  String phoneNumber;
  String wallet;

  static const routeName = '/userWallet';
  UserWallet(
      {required this.name, required this.phoneNumber, required this.wallet});

  @override
  State<UserWallet> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  var moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int amount = int.parse(widget.wallet);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: Colors.deepOrange,
                title: Text(
                  'ادارة المحفظة',
                  style: TextStyle(color: Colors.white),
                )),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 1,
                    color: HexColor('#ffffff'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 250.h,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w, top: 30.h),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'اهلا بك : ${widget.name}',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '${widget.phoneNumber}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'رصيدك الحالى',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('$amount ج.م'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: 150.w, height: 50.h),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // <-- Radius
                        ),
                      ),
                      child: Text(
                        "أضافة نقود",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Notice"),
                              content: SizedBox(
                                height: 65.h,
                                child: TextField(
                                  controller: moneyController,
                                  decoration: InputDecoration(
                                    fillColor: HexColor('#155564'),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xfff8a55f), width: 2.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: "ادخل المبلغ",
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: HexColor('#6bbcba'),
                                  ),
                                  child: Text("اضافة"),
                                  onPressed: () async {
                                    int money =
                                        int.parse(moneyController.text.trim());
                                    int total = money + amount;

                                    if (money == 0) {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text("ادخل المبلغ"))
                                          .show(context);
                                      return;
                                    }

                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    if (user != null) {
                                      String uid = user.uid;

                                      DatabaseReference companyRef =
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child('users')
                                              .child(widget.phoneNumber);

                                      await companyRef.update({
                                        'wallet': total,
                                      });
                                    }

                                    showAlertDialog(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة النقود"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
