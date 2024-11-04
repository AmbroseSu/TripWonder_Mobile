// import 'package:flutter/material.dart';
// import 'package:tripwonder/widgets/rounded_container.dart';
// import 'package:tripwonder/widgets/section_heading.dart';
//
// import '../styles&text&sizes/colors.dart';
// import '../styles&text&sizes/image_strings.dart';
// import '../styles&text&sizes/sizes.dart';
// import 'helper_functions.dart';
//
// class TBillingPaymentSection extends StatelessWidget {
//   const TBillingPaymentSection({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Column(
//       children: [
//         TSectionHeading(
//           title: 'Payment Method',
//           buttonTitle: 'Payment Information',
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return
//                   AlertDialog(
//                   backgroundColor: Colors.white,
//                   title: Text('Thông tin chuyển khoản',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),),
//                   content: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Nội dung chuyển khoản: \nSDT_HoVaTen',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18, // Increase the font size as needed
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       // Text('STK: 0312341934234', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
//                       // SizedBox(height: 10),
//                       // Text('Người nhận: Namlee Entertainment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                       // SizedBox(height: 10),
//                       // Text('Vietcombank - Ngân hàng thương mại cổ phần Ngoại thương Việt Nam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                       // SizedBox(height: 10),
//                       // Thêm hình ảnh QR Code
//                       Image.asset(
//                         TImages.qrCode,
//                         height: 250,
//                         width: 250,
//                         fit: BoxFit.cover,
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Close', style: TextStyle(color: Colors.black),),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//         SizedBox(height: TSizes.spaceBtwItems / 2),
//         Row(
//           children: [
//             TRoundedContainer(
//               width: 60,
//               height: 35,
//               backgroundColor: dark ? TColors.light : TColors.white,
//               padding: const EdgeInsets.all(TSizes.sm),
//               child: const Image(
//                 image: AssetImage(TImages.domesticTransfer),
//                 width: 100,
//                 height: 100,
//                 // fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(width: TSizes.spaceBtwItems / 2),
//             Text('Domestic Transfer', style: Theme.of(context).textTheme.bodyLarge),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Widget _buildInfoRow(String title, {String? subtitle, double? fontSize}) {
//   //   return Card(
//   //     elevation: 0,
//   //     margin: EdgeInsets.symmetric(vertical: TSizes.xs),
//   //     child: ListTile(
//   //       title: Text(
//   //         title,
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           fontSize: fontSize ?? TSizes.fontSizeMd,
//   //         ),
//   //       ),
//   //       subtitle: subtitle != null ? Text(subtitle) : null,
//   //     ),
//   //   );
//   // }
// }

import 'package:flutter/material.dart';
import 'package:tripwonder/api/response/order_code.dart';
import 'package:tripwonder/widgets/rounded_container.dart';
import 'package:tripwonder/widgets/section_heading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/global_variables/user_manage.dart';
import '../api/response/payment_info.dart';
import '../styles&text&sizes/colors.dart';
import '../styles&text&sizes/image_strings.dart';
import '../styles&text&sizes/sizes.dart';
import 'helper_functions.dart';
import 'dart:convert'; // Để sử dụng json.decode
import 'package:http/http.dart' as http; // Import package http

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({Key? key}) : super(key: key);

  // Future<void> _launchPaymentLink(BuildContext context) async {
  //   final userId = UserManager().id; // Lấy userId từ UserManager
  //
  //   if (userId == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('User ID is not available')),
  //     );
  //     return;
  //   }
  //
  //   final String apiUrl = 'https://tripwonder.onrender.com/api/v1/checkout/linkPay?userId=$userId';
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         // Thêm header nếu cần
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       PaymentInformation paymentInfo = PaymentInformation.fromJson(responseData);
  //
  //       // Bây giờ bạn có thể sử dụng paymentInfo để truy cập các thuộc tính
  //       final checkoutUrl = paymentInfo.checkoutUrl;
  //       // Mở checkoutUrl trong trình duyệt
  //       final Uri uri = Uri.parse(checkoutUrl);
  //       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Could not launch payment link.')),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to fetch payment link. Status code: ${response.statusCode}')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred: $e')),
  //     );
  //   }
  //
  // }


  Future<PaymentInformation?> _fetchPaymentInfo(BuildContext context) async {
    final userId = UserManager().id;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID is not available')),
      );
      return null;
    }

    final String apiUrl = 'https://tripwonder.onrender.com/api/v1/checkout/linkPay?userId=$userId';

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        OrderCode().orderCode = PaymentInformation.fromJson(responseData).orderCode;
        return PaymentInformation.fromJson(responseData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch payment link. Status code: ${response.statusCode}')),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      return null;
    }
  }

  Future<void> _launchPaymentLink(BuildContext context) async {
    final paymentInfo = await _fetchPaymentInfo(context);

    if (paymentInfo != null) {
      final Uri uri = Uri.parse(paymentInfo.checkoutUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch payment link.')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Pay trip',
          onPressed: () => _launchPaymentLink(context),
        ),
        SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(
                image: AssetImage(TImages.domesticTransfer),
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text('Domestic Transfer', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
