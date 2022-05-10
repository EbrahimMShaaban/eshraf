// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyModel with ChangeNotifier {
  var val;

  //to get the length of the list inside this map use this line
  // departments['كلية علوم الحاسب والمعلومات'].length
  Map<String, List<String>> departments = {
    'كلية الحاسبات والمعلومات': [
      "هندسة البرمجيات",
      "نظم المعلومات",
      "تقنية المعلومات",
      "علوم الحاسب",
    ],
    'كلية العلوم': [
      "النبات",
      "الكمياء",
      "الرياضيات",
      " حصاء",
    ],
    'كلية التربية الرياضة': [
      "علوم الرياضة",
      " دارة الرياضية",
      "اللياقة البدنية",
      "التدريب الرياضي",
    ],
    'كلية الهندسة': [
      "الكيميائية",
      "الكهربائية",
      "الصناعية",
      "الميكانيكية",
    ],
    'كلية الزراعة': [
      "الإنتاج النباتي",
      "وقاية النبات",
      "تغذية  نسان",
      "الإنتاج الحيواني",
    ],
    'كلية الفنون الجميلة': [
      "علوم البناء",
      "التخطيط العام",
      "التصميم العمراني",
      "التخطيط العمراني"
    ],
    'كلية التجارة': [
      "المحاسبة",
      "نظم المعلومات الإدارية",
      "التسويق",
      "المالية"
    ],
    'كليةالتمريض ': ["تمريض عام", "تمريض"],
    'كلية الطب': ["طب وجراحة"],
    'كلية طب  سنان': ["طب أسنان عام"],
    'كلية الصيدلة': ["علوم صيدلة", "دكتور صيدلة"],
    'كلية العلوم الطبية التطبيقية': [
      "التغذية السريرية",
      "المختبرات  كلينيكية",
      "علوم الأشعة",
      "العلاج الطبيعي",
    ],
    'كلية الحقوق': ["العلوم السياسية", "الحقوق"],
    'كلية  داب': [
      "المجال التربوي",
      "إعلام",
      "تاريخ",
      "جغرافيا",
    ],
    'كلية التربية': [
      "تربية فنية",
      "دراسات إسلامية",
      "علم النفس",
      "التربية الخاصة",
    ],
    'كلية الألسن': [
      " نجليزية",
      "الفرنسية",
      "الصينية",
    ],
    'كلية السياحة والفنادق': [
      "إدارة موارد التراث",
      "الإدارة الفندقية",
      "مسار الإرشاد السياحي",
      "الإدارة السياحية",
    ],

    'كلية التربية النوعية': [
      "علوم الحاسب والهندسة",
      "العلوم الصحية",
      "العلوم الإدارية والإنسانية",
    ],
  };
}
