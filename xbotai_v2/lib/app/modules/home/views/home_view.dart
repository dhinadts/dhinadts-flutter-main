import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget listTile({
    required String title,
    required String desc,
    required String assetName,
    required String viewType,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(desc),
      leading: CircleAvatar(
        backgroundImage: AssetImage(assetName),
        onBackgroundImageError: (_, __) {},
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => controller.loadApp(viewType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentViewType.isNotEmpty) {
          controller.currentViewType.value = ''; // Go back to list
          return false; // Prevent browser back, handle internally
        }
        return true; // Allow default back if on list
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Web Apps in React.js'),
          centerTitle: true,
          leading: Obx(() {
            if (controller.currentViewType.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => controller.currentViewType.value = '',
              );
            } else {
              return const SizedBox.shrink(); // No back button if on list
            }
          }),
        ),
        body: Obx(() {
          if (controller.currentViewType.isEmpty) {
            // Show app list
            return ListView.builder(
              itemCount: controller.webApps.length,
              itemBuilder: (context, index) {
                final app = controller.webApps[index];
                return listTile(
                  title: app['title']!,
                  desc: app['desc']!,
                  assetName: app['asset']!,
                  viewType: app['viewType']!,
                );
              },
            );
          } else {
            // Show selected React app
            return HtmlElementView(viewType: controller.currentViewType.value);
          }
        }),
      ),
    );
  }
}
