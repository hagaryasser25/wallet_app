import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:wallet_app/models/users_model.dart';
import 'package:wallet_app/user/user_home.dart';

class UserTransfer extends StatefulWidget {
  String userPhone;
  String wallet;
  static const routeName = '/bookPlace';
  UserTransfer({
    required this.userPhone,
    required this.wallet,
  });

  @override
  State<UserTransfer> createState() => _UserTransferState();
}

class _UserTransferState extends State<UserTransfer> {
  var phoneController = TextEditingController();
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                left: 10.w,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/logo2.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "رقم الهاتف",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "قيمة التحويل",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                      ),
                      onPressed: () async {
                        late DatabaseReference base;
                        late FirebaseDatabase database;
                        late FirebaseApp app;
                        late Users currentUser;
                        String phone = phoneController.text.trim();
                        int amount = int.parse(amountController.text).toInt();
                        int wallet = int.parse(widget.wallet);
                        late int reciever;

                        
                          app = await Firebase.initializeApp();
                          database = FirebaseDatabase(app: app);
                          base =
                              database.reference().child("users").child(phone);

                          final snapshot = await base.get();
                          setState(() {
                            currentUser = Users.fromSnapshot(snapshot);
                            String? w = currentUser.wallet;
                            int wallett = int.parse(w!).toInt();
                            reciever = wallett;
                          });
                        

                        if (phone.isEmpty || amount == 0) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        if (amount > wallet) {
                          CherryToast.info(
                            title: Text('رصيد محفظتك لا يكفى'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('transfers');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'senderPhone': widget.userPhone,
                            'receiverPhone': phone,
                            'amount': amount,
                          });
                          DatabaseReference userRef = FirebaseDatabase.instance
                              .reference()
                              .child('users');

                          await userRef.child(widget.userPhone).update({
                            "wallet": wallet - amount,
                          });
                          await userRef.child(phone).update({
                            "wallet": reciever + amount,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child:
                          Text("ارسال", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
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
    content: Text("تم ارسال النقود"),
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
