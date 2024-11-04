

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripwonder/api/response/order_code.dart';
import 'package:tripwonder/navigation_menu.dart';
import 'package:tripwonder/screens/success_screen/payment_success.dart';
import 'package:tripwonder/styles&text&sizes/image_strings.dart';
import '../../styles&text&sizes/colors.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../widgets/billing_address_section.dart';
import '../../widgets/billing_payment_section.dart';
import '../../widgets/helper_functions.dart';
import '../../widgets/rounded_container.dart';
import '../cart/cart_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  Future<void> _checkOrderStatus(BuildContext context, int orderCode) async {
    final String apiUrl = 'https://tripwonder.onrender.com/api/v1/order/checkStatus?orderCode=$orderCode';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Kiểm tra trạng thái thanh toán
        if (responseData['content'] == 'PAID') {
          OrderCode().orderCode = null;
          // Nếu đã thanh toán, chuyển đến trang PaymentSuccess
          Get.to(() => PaymentSuccess(
            image: TImages.paymentSuccess,
            title: 'Payment Success!',
            subTitle: 'Your package is ready!',
            onPressed: () => Get.to(() => const NavigationMenu()),
          ));
        } else {
          // Nếu không, hiển thị thông báo thanh toán không thành công
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment Fail')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to check order status. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> _launchCheckout(BuildContext context) async {
    // final paymentInfo = await _fetchPaymentInfo(context);
    OrderCode orderCode = OrderCode();
    if (orderCode.orderCode != null) {
      // Lấy orderCode từ paymentInfo và chuyển đổi sang String
      //String orderCode = paymentInformation.orderCode;
      print(orderCode.orderCode);// Sửa dòng này
      // Gọi kiểm tra trạng thái đơn hàng
      await _checkOrderStatus(context, orderCode.orderCode!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Order', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TCartItem(),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    TBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => _launchCheckout(context), // Gọi phương thức launchCheckout
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF55B97D),
          ),
          child: const Text('Checkout', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
