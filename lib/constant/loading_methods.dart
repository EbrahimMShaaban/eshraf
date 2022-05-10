import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Directionality(
            textDirection: TextDirection.rtl,
              child:  Text("برجاء الا نتظار")),
          // ignore: sized_box_for_whitespace
          content: Container(
              height: 50,
              child: const Center(child: CircularProgressIndicator())),
        );
      });
}
