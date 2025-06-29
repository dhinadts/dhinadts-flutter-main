import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
// import 'dart:ui' as ui;
// import "package:flutter_web_plugins/flutter_web_plugins.dart";
// import 'package:flutter/material.dart';

void main() {
 

  runApp(
    GetMaterialApp(
      title: "Bot AI",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
