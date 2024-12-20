import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/api/global_variables/user_manage.dart';
import 'package:tripwonder/screens/cart/cart.dart';
import 'package:tripwonder/screens/explore_screen.dart';
import 'package:tripwonder/screens/order/order.dart';
import 'package:tripwonder/screens/settings/settings.dart';
import 'package:tripwonder/styles&text&sizes/colors.dart';
import 'package:tripwonder/widgets/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    print("000000000000000000000000000000000000000000000000000000000000000");
    print(UserManager().id);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.shopping_cart), label: 'Order'),
            NavigationDestination(
                icon: Icon(Iconsax.ticket), label: 'My Booking'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Account'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // Update this to match the number of destinations
  final screens = [
    const ExploreScreen(),
    const CartScreen(),
    const OrderScreen(),
    const SettingsScreen(),
  ];
}
