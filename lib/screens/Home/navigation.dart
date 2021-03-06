// ignore_for_file: must_be_immutable

import 'package:eshraf/constant/style.dart';
import 'package:eshraf/screens/Home/view.dart';
import 'package:eshraf/screens/project_screen/view.dart';
import 'package:eshraf/screens/seminar/view.dart';
import 'package:eshraf/screens/theses_screen/view.dart';
import 'package:flutter/material.dart';

class NavigationFile extends StatefulWidget {
   final Widget d ;
   String ?title;
  final int counter;

  late final List <Widget> pages;
  NavigationFile( {Key? key, this.title, required this.d,required this.counter,}) : super(key: key){
    pages=[
      HomeScreen(c: d, ),
      const ProjectScreen(),
      const ThesesScreen(),
      const SeminarScreen() ,
    ];
  }
  @override
  _NavigationFileState createState() => _NavigationFileState();
}

class _NavigationFileState extends State<NavigationFile> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  widget.pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: blue,
        selectedIconTheme: const IconThemeData(color: gray,),
        selectedLabelStyle: hintStyle4,
        unselectedLabelStyle: hintStyle4,
        selectedItemColor: white,
        mouseCursor: MouseCursor.defer,
        unselectedItemColor: gray,
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 25,color: white,), label: 'الرئيسية',),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/bar-chart.png',),height: 25,color: white,), label: 'المشاريع'),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/newsletter.png'),height: 25,color: white,), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/class.png'),height: 25,color: white,), label: 'الندوات'),
        ],
      ),
    );
  }
}
