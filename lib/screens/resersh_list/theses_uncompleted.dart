// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:eshraf/constant/style.dart';
import 'package:eshraf/provider/profile_provider.dart';
import 'package:eshraf/screens/theses_screen/theses_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UnComletedThesesListresersh extends StatefulWidget {
  final String? userId;

  const UnComletedThesesListresersh({ required this.userId});

  @override
  State<UnComletedThesesListresersh> createState() =>
      _UnComletedThesesListresershState();
}

class _UnComletedThesesListresershState
    extends State<UnComletedThesesListresersh> {
  List<ModelTheses> unCompletedTheses = <ModelTheses>[];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getUnCompletedTheses();
    super.initState();
  }

  getUnCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
        .where('thesesStatus', isEqualTo: 'غير مكتملة').where('userId',isEqualTo: widget.userId)
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = doc['isFav'];
      bool isFav = false;
      if (docIsFav.containsKey(
          FirebaseAuth.instance.currentUser!.uid.toString())) {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");


      unCompletedTheses.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: isFav,
          department: doc['department'],
          college: doc['college'],
          userId: doc['userId'],
          id: doc.id));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          child: SizedBox(
            child: ListView.builder(
                itemCount: unCompletedTheses.length,
                itemBuilder: (context, index) {

                  return _buildThesesBox( unCompletedTheses[index]);
                }),
          ),
        )
      ],
    );
  }
  Widget _buildThesesBox(ModelTheses theses){
    var prov = Provider.of<ProfileProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      width: sizeFromWidth(context, 1),
      height: 120,
      decoration: BoxDecoration(
        color: clearblue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "اسم الاطروحة: " +
                        theses.nameTheses!,
                    style: labelStyle3,
                  ),
                  Text(
                    'المشرف:' +
                        theses.nameSupervisors!,
                    style: hintStyle3,
                  ),
                  Text(
                    'المشرفون المساعدون:' +
                        theses.assistantSupervisors!,
                    style: hintStyle3,
                  ),
                ],
              ),
            ),
            prov.counter == 2? const SizedBox(): const VerticalDivider(
              color: gray,
              endIndent: 5,
              indent:5,
              width: 10,
              thickness: 2,
            ),
            prov.counter == 2? const SizedBox(): Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(

                    theses.degreeTheses!,
                    style: labelStyle3,
                  ),
                  InkWell(
                    onTap: () async {
                      DocumentSnapshot docRef = await FirebaseFirestore
                          .instance
                          .collection('theses')
                          .doc(theses.id)
                          .get();

                      Map<String, dynamic> docIsFav =
                      docRef.get("isFav");

                      if (docIsFav.containsKey(
                          FirebaseAuth.instance.currentUser!.uid)) {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid
                              .toString(): theses.isFav! ? false : true
                        });
                      } else {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid:
                          theses.isFav! ? false : true
                        });
                      }
                      FirebaseFirestore.instance
                          .collection('thesesBookmark')
                          .doc(theses.id)
                          .set({
                        'nameTheses': theses.nameTheses,
                        'nameSupervisors': theses.nameSupervisors,
                        'assistantSupervisors': theses.assistantSupervisors,
                        'degreeTheses': theses.degreeTheses,
                        'linkTheses': theses.linkTheses,
                        'thesesStatus': theses.thesesStatus,
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'isFav': docIsFav
                      });

                      theses.isFav = !theses.isFav!;
                      await FirebaseFirestore.instance
                          .collection('theses')
                          .doc(theses.id)
                          .update(
                          {'isFav':docIsFav});
                      if (theses.isFav == false) {
                        FirebaseFirestore.instance
                            .collection('thesesBookmark')
                            .doc(theses.id)
                            .delete();
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 25,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: !theses.isFav!
                          ? const ImageIcon(
                        AssetImage(
                          'assets/bookmark (1).png',
                        ),
                        color: blue,
                        size: 50,
                      )
                          : const ImageIcon(
                        AssetImage(
                          'assets/bookmark (2).png',
                        ),
                        color: blue,
                        size: 50,
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

