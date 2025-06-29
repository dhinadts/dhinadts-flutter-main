import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
// import 'dart:ui' as ui;
// import "package:flutter_web_plugins/flutter_web_plugins.dart";
// import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;

// import 'package:your_package/platform_view_registry.dart';
import 'package:web/web.dart' as web;

// platformViewRegistry.registerViewFactory(
//   'iframe',
//   (int viewId) => html.IFrameElement()
//     ..src = 'https://example.com'
//     ..style.width = '100%'
//     ..style.height = '100%'
//     ..style.border = 'none',
// );

void main() {
  ui_web.platformViewRegistry.registerViewFactory('react-app', (int viewId) {
    final iframe =
        web.document.createElement('iframe') as web.HTMLIFrameElement
          ..src = 'https://crio-interview-activities-t7ag.vercel.app/'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
    return iframe;
  });

  runApp(
    GetMaterialApp(
      title: "Bot AI",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
