import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/style.dart';
import '../login_screen/view.dart';
import '../signup_screen/singup_screen.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({Key? key}) : super(key: key);

  @override
  _RegistScreenState createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: sizeFromWidth(context, 1),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: blue,
              ),
              child: const Image(
                image: AssetImage('assets/logo.png',),
                height: 230,
              ),
            ),
            Container(
              width: sizeFromWidth(context, 1),
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: Column(children: [
                SizedBox(
                  height: 65,
                  child: (TabBar(
                    labelColor: blue,
                    unselectedLabelColor: gray,
                    isScrollable: true,
                    labelStyle: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                          fontSize: 25,
                          height: 1.5,
                          fontWeight: FontWeight.w800),
                    ),
                    tabs: const <Widget>[
                      Tab(
                        text: '?????????? ????????',
                      ),
                      Tab(
                        text: "?????????? ????????",
                      ),
                    ],
                  )),
                ),
                 const Expanded(
                  child: SizedBox(
                    child: TabBarView(
                      children: [
                        SignUpScreen(),
                        LoginScreen(),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            // Expanded(
          ],
        ),
      ),
    );
  }
}
