import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/navigation_menu.dart';

import '../../api/global_variables/user_manage.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../widgets/appbar.dart';
import '../../widgets/t_circular_icon.dart';
import '../checkout/checkout.dart';
import '../explore_screen.dart';
import 'cart_item.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int? userId = UserManager().id;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      AppBar(
        backgroundColor: Colors.white,
        title: Text('Order', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TCartItem(), // Sử dụng TCartItem đã cập nhật
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Builder(
          builder: (context) {
            // Giả lập tổng giá (dùng cho thử nghiệm)
            final double totalPrice = 3500.0; // Giả lập giá trị bất kỳ

            return ElevatedButton(
              onPressed: () => Get.to(() => const CheckoutScreen()),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF55B97D)
              ),
              child: Text('Checkout', style: TextStyle(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }

}