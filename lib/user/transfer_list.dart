import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:wallet_app/models/transictions_model.dart';

class TransferList extends StatefulWidget {
  static const routeName = '/userList';
  TransferList({
    super.key,
  });

  @override
  State<TransferList> createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Transictions> transList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBookings();
  }

  @override
  void fetchBookings() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("transfers");
    base
        .orderByChild("senderPhone")
        .equalTo("${FirebaseAuth.instance.currentUser!.displayName}")
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      Transictions p = Transictions.fromJson(event.snapshot.value);
      transList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
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
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: Colors.deepOrange,
                title: Center(
                    child: Text(
                  "تقارير التحويل",
                  style: TextStyle(color: Colors.white),
                )),
              ),
              body: Column(children: [
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                    itemCount: transList.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 15, left: 15, bottom: 10),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'رقم المستقبل : ${transList[index].receiverPhone.toString()}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'قيمة التحويل : ${transList[index].amount.toString()}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                              base
                                                  .child(transList[index]
                                                      .id
                                                      .toString())
                                                  .remove();
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ])),
        ));
  }
}
