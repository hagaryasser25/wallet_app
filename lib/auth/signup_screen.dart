import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signupScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 250.h,
                    child: ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        color: Colors.deepOrange,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Text("انشاء حساب",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 29,
                                  fontWeight: FontWeight.w600)),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'تستطيع انشاء حساب من خلال هذه الشاشة',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 17.h),
                            SizedBox(
                              height: 65.h,
                              child: TextField(
                                style: TextStyle(color: Colors.deepOrange),
                                controller: nameController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.text_fields,
                                    color: Colors.deepOrange,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'الأسم',
                                  hintStyle: TextStyle(
                                    color: Colors.deepOrange,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 65.h,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                ),
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.deepOrange,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'رقم الهاتف',
                                  hintStyle: TextStyle(
                                    color: Colors.deepOrange,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 65.h,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                ),
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.deepOrange,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.deepOrange),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'البريد الألكترونى',
                                  hintStyle: TextStyle(
                                    color: Colors.deepOrange,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 65.h,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                ),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Colors.deepOrange,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'كلمة المرور',
                                  hintStyle: TextStyle(
                                    color: Colors.deepOrange,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 150.w, height: 50.h),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          25), // <-- Radius
                                    ),
                                  ),
                                  child: Text(
                                    'انشاء حساب',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  onPressed: () async {
                                    var name = nameController.text.trim();
                                    var phoneNumber =
                                        phoneNumberController.text.trim();
                                    var email = emailController.text.trim();
                                    var password =
                                        passwordController.text.trim();
                                    int wallet = 0;

                                    if (name.isEmpty ||
                                        email.isEmpty ||
                                        password.isEmpty ||
                                        phoneNumber.isEmpty) {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "please fill all fields"))
                                          .show(context);

                                      return;
                                    }

                                    if (password.length < 6) {
                                      // show error toast
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "Weak Password, at least 6 characters are required"))
                                          .show(context);

                                      return;
                                    }

                                    ProgressDialog progressDialog =
                                        ProgressDialog(context,
                                            title: Text('Signing Up'),
                                            message: Text('Please Wait'));
                                    progressDialog.show();

                                    try {
                                      FirebaseAuth auth = FirebaseAuth.instance;

                                      UserCredential userCredential = await auth
                                          .createUserWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );
                                      User? user = userCredential.user;
                                      user!.updateDisplayName(phoneNumber);

                                      if (userCredential.user != null) {
                                        DatabaseReference userRef =
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('users');

                                        String uid = userCredential.user!.uid;
                                        int dt = DateTime.now()
                                            .millisecondsSinceEpoch;

                                        await userRef.child(phoneNumber).set({
                                          'name': name,
                                          'email': email,
                                          'password': password,
                                          'uid': uid,
                                          'dt': dt,
                                          'phoneNumber': phoneNumber,
                                          'wallet': wallet,
                                        });

                                        Navigator.canPop(context)
                                            ? Navigator.pop(context)
                                            : null;
                                      } else {
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description: Text("failed"))
                                            .show(context);
                                      }
                                      progressDialog.dismiss();
                                    } on FirebaseAuthException catch (e) {
                                      progressDialog.dismiss();
                                      if (e.code == 'email-already-in-use') {
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description: Text(
                                                    "email is already exist"))
                                            .show(context);
                                      } else if (e.code == 'weak-password') {
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description:
                                                    Text("password is weak"))
                                            .show(context);
                                      }
                                    } catch (e) {
                                      progressDialog.dismiss();
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description:
                                                  Text("something went wrong"))
                                          .show(context);
                                    }
                                  }),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Positioned(
                top: 180.h,
                right: 130.w,
                child: Align(
                  alignment: Alignment(0, 0.000000),
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo2.png'),
                      radius: 55,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
