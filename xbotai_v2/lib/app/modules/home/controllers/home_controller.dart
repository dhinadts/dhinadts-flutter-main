import 'package:get/get.dart';
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;

class HomeController extends GetxController {
  var currentUrl = ''.obs;
  var currentViewType = ''.obs;

  final List<Map<String, String>> webApps = [
    {
      'title': 'Booking Hospital',
      'desc': 'Hospital List with feature of searching and booking',
      'url': 'https://crio-interview-activities-nioz.vercel.app/',
      'asset': 'assets/weather.png',
      'viewType': 'hospiatl-app',
    },
    {
      'title': 'Bot AI',
      'desc': 'Sample Chat Bot',
      'url': 'https://crio-interview-activities-t7ag.vercel.app/',
      'asset': 'assets/todo.png',
      'viewType': 'bot-ai',
    },
    {
      'title': 'QTrip',
      'desc': 'List of tourist places',
      'url': 'https://qtrip-static-eight-kappa.vercel.app/',
      'asset': 'assets/notes.png',
      'viewType': 'trip-app',
    },
  ];

  @override
  void onInit() {
    super.onInit();

    // Register iframes for all apps
    for (var app in webApps) {
      final viewType = app['viewType']!;
      final url = app['url']!;

      ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
        final iframe =
            web.document.createElement('iframe') as web.HTMLIFrameElement
              ..src = url
              ..style.border = 'none'
              ..style.width = '100%'
              ..style.height = '100%';
        return iframe;
      });
    }
  }

  void loadApp(String viewType) {
    currentViewType.value = viewType;
  }
}
