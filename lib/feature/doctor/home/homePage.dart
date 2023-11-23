import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DoctorHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'صـحتيّ',
          style: getTitleStyle(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'Hello, Dr. ',
                      style: getbodyStyle(),
                    ),
                    TextSpan(
                      text: user?.displayName,
                      style: getbodyStyle(),
                    )
                  ])),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: Text(
                    "Let's Find Your Appointment",
                    style: getbodyStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _searchField() {
  //   return Container(
  //     height: 55,
  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(25)),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(.3),
  //           blurRadius: 15,
  //           offset: Offset(5, 5),
  //         )
  //       ],
  //     ),
  //     child: TextField(
  //       onChanged: (_searchKey) {
  //         setState(
  //           () {
  //             print('>>>' + _searchKey);
  //             search = _searchKey;
  //             _length = search!.length;
  //           },
  //         );
  //       },
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  //         hintText: "Search",
  //         hintStyle: getbodyStyle(),
  //         suffixIcon: SizedBox(
  //             width: 50,
  //             child: Icon(Icons.search, color: AppColors.color1)),
  //       ),
  //     ),
  //   );
  // }
}
