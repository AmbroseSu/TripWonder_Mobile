import 'package:flutter/material.dart';
import '../../api/response/packageTour.dart';
import '../../styles&text&sizes/colors.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../widgets/helper_functions.dart';
import '../../widgets/product_price_text.dart';
import '../../widgets/product_title_text.dart';
import '../../widgets/t_brand_title_text_with_verified_icon.dart';
import '../../widgets/t_rounded_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/global_variables/user_manage.dart';

class TCartItem extends StatefulWidget {
  const TCartItem({super.key});

  @override
  _TCartItemState createState() => _TCartItemState();
}

class _TCartItemState extends State<TCartItem> {
  List<CartItem> items = [];

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }


  Future<void> _fetchCartItems() async {
    final int? userId = UserManager().id;
    final response = await http.get(Uri.parse("https://tripwonder.onrender.com/api/v1/order/getall/$userId?Page=0&PageSize=100"));

    if (response.statusCode == 200) {
      // Sử dụng utf8.decode để chuyển đổi dữ liệu về chuỗi UTF-8
      final decodedResponse = utf8.decode(response.bodyBytes);
      final data = json.decode(decodedResponse);
      setState(() {
        items = (data['content']['content'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      });
    } else {
      // Handle error
      throw Exception('Failed to load cart items');
    }
  }


  double get totalPrice => items.fold<double>(
    0,
        (sum, item) => sum + (item.totalPrice * item.quantity),
  );

  void _updateAttendance(int index, int change) {
    setState(() {
      items[index].quantity += change;
      if (items[index].quantity < 1) {
        items[index].quantity = 1; // Đảm bảo quantity không dưới 1
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index); // Remove item at the given index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Column(
            children: [
              Row(
                children: [
                  /// Image
                  TRoundedImage(
                    imageUrl: item.packageTour.shortDescription,
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  /// Title, Price, & Size
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TBrandTitleTextWithVerifiedIcon(title: 'Travel'),
                        Flexible(
                          child: TProductTitleText(
                            title: item.packageTour.name.toString(),
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Person: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.quantity.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 50),

                            /// Decrease Button
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _updateAttendance(index, -1),
                            ),

                            /// Attendance Number
                            Text(
                              item.quantity.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),

                            /// Increase Button
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _updateAttendance(index, 1),
                            ),
                          ],
                        ),
                        TProductPriceText(price: item.totalPrice.toStringAsFixed(2)),
                      ],
                    ),
                  ),

                  /// Delete Button
                  IconButton(
                    icon: Icon(Icons.delete, color: Color(0xFF55B97D)),
                    onPressed: () => _removeItem(index),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Thay đổi chiều cao tại đây để tăng khoảng cách
            ],
          );
        }).toList(),

        const SizedBox(height: 20), // Space before total price
        Text(
          'Total Price: \$${totalPrice.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

}
