// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'package:eshraf/constant/alert_methods.dart';
import 'package:eshraf/constant/style.dart';
import 'package:eshraf/provider/profile_provider.dart';
import 'package:eshraf/widgets/buttons/buttonsuser.dart';
import 'package:eshraf/widgets/buttons/tetfielduser.dart';
import 'package:eshraf/widgets/textfieldtime.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EditSeminar extends StatefulWidget {
  String? seminarname,
      username,
      location,
      description,
      from,
      to,
      link,
      dropdown,
      dropdown2,
      userid,
      docId;
  var type, selectday;
  bool? isFav;

  EditSeminar(
      {this.from,
      this.dropdown,
      this.dropdown2,
      this.isFav,
      this.userid,
      this.type,
      this.link,
      this.description,
      this.location,
      this.selectday,
      this.seminarname,
      this.to,
      this.docId,
      this.username,
      Key? key})
      : super(key: key);

  @override
  _EditSeminarState createState() => _EditSeminarState();
}

class _EditSeminarState extends State<EditSeminar> {
  var val;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController from = TextEditingController();

  TextEditingController to = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController link = TextEditingController();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void getData() async {
    DocumentSnapshot documentSnapshot2 = (await FirebaseFirestore.instance
        .collection("seminar")
        .doc(widget.docId)
        .get());

    name.text = documentSnapshot2.get('seminarAddress');
    widget.dropdown = documentSnapshot2.get('timedrop');
    widget.dropdown2 = documentSnapshot2.get('timedrop2');
    from.text = documentSnapshot2.get('from');
    to.text = documentSnapshot2.get('to');
    link.text = documentSnapshot2.get('link');
    discription.text = documentSnapshot2.get('description');
    location.text = documentSnapshot2.get('location');
    // _selectedDay = documentSnapshot2.get('selectedDay');
    widget.type = documentSnapshot2.get('type');


    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {

      setState(() {});
    });
    getData();
    print(widget.docId);
    print(name.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('?????????? ????????',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: blue, fontWeight: FontWeight.bold, fontSize: 28),
            )),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
            width: sizeFromWidth(context, 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: clearblue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFieldUser(
                    labelText: "??????????????",
                    scure: false,
                    hintText: "???????? ??????????????",
                    onChanged: (val) {
                      prov.seminaraddress = val;
                    },
                    controller: name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '???????? ???????? ?????????? ????????????';
                      }
                    }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '??????????????',
                    style: hintStyle4,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TableCalendar(
                    rowHeight: 30,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
// update `_focusedDay` here as well
                      });
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '??????????',
                    style: hintStyle4,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Text(
                          '????',
                          style: hintStyle,
                        ),
                        SizedBox(
                          width: 90,
                          child: TimeTextField(
                            onChanged: (val) {
                              prov.from = val;
                            },
                            controller: from,
                            validator: (value) {
                              if (value.isEmpty) {
                                return '???????? ???????? ?????? ?????????? ????????????';
                              }
                            },
                            text: '00:00   ?? ??',
                          ),
                        ),
                        DropdownButton<String>(
                            value: widget.dropdown,
                            onChanged: (newValue) {
                              setState(() {
                                prov.dropdownValue = newValue!;
                              });
                            },
                            items: <String>['pm', 'am']
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value!));
                            }).toList()),
                        Text(
                          '??????',
                          style: hintStyle,
                        ),
                        SizedBox(
                          width: 90,
                          child: TimeTextField(
                            onChanged: (val) {
                              prov.to = val;
                            },
                            controller: to,
                            validator: (value) {
                              if (value.isEmpty) {
                                return '???????? ???????? ?????? ?????????? ????????????';
                              }
                            },
                            text: '00:00   ?? ??',
                          ),
                        ),
                        DropdownButton<String>(
                            value: widget.dropdown2,
                            onChanged: (newValue) {
                              setState(() {
                                prov.dropdownValue2 = newValue!;
                              });
                            },
                            items: <String>['pm', 'am']
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value!));
                            }).toList()),
                      ],
                    ),
                  ),
                ),
                TextFieldUser(
                  onChanged: (val) {
                    prov.location = val;
                  },
                  controller: location,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '???????? ???????? ???????? ????????????';
                    }
                  },
                  labelText: "????????????",
                  scure: false,
                  hintText: "???????? ????????????",
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    '??????????',
                    style: hintStyle4,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: widget.type,
                              onChanged: (value) {
                                setState(() {
                                  widget.type = value;
                                });
                              }),
                          Text('????????', style: hintStyle3),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: widget.type,
                              onChanged: (value) {
                                setState(() {
                                  widget.type = value;
                                });
                              }),
                          Text(
                            '????????',
                            style: hintStyle3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextFieldUser(
                    labelText: "??????????",
                    scure: false,
                    hintText: "?????? ????????????",
                    onChanged: (val) {
                      prov.description = val;
                    },
                    controller: discription,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '???????? ?????? ???????? ????????????';
                      }
                    }),
                TextFieldUser(
                    labelText: "???????? ???????????? ?????? ????????????",
                    scure: false,
                    hintText: "????????????",
                    onChanged: (val) {
                      prov.seminarlink = val;
                    },
                    controller: link,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '???????? ???????? ???????? ???????????? ????????????';
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      ButtonUser(
                          text: '?????? ????????????',
                          color: redGradient,
                          onTap: () {
                            showDialogWarning(context, ontap: () async {
                              await FirebaseFirestore.instance
                                  .collection('seminar')
                                  .doc(widget.docId)
                                  .delete();
                            }, text: '???? ?????? ?????????? ???? ?????? ?????? ????????????');
                          }),
                      ButtonUser(
                          text: '?????? ??????????????????',
                          color: blueGradient,
                          onTap: () async {
                            showDialogWarning(context, ontap: () async {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();

                                await FirebaseFirestore.instance
                                    .collection('seminar')
                                    .doc(widget.docId)
                                    .update({
                                  'seminarAddress': name.text,
                                  'description': discription.text,
                                  'location': location.text,
                                  'link': link.text,
                                  'from': from.text,
                                  'to': to.text,
                                  'type': widget.type
                                }).then((value) async {
                                  Navigator.pop(context);
                                  await AwesomeDialog(
                                          context: context,
                                          title: "??????",
                                          body: const Text(
                                              "?????? ?????????? ?????????????? ??????????"),
                                          dialogType: DialogType.SUCCES)
                                      .show();
                                  Navigator.pop(context);

                                  //             const SeminarScreen()));
                                });
                              }

                              print(name);
                            }, text: '???? ?????? ?????????? ???? ?????? ?????????????????? ??');
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
