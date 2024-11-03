import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<void> _removeItem(int index) async {
    final cartId = items[index].id; // Lấy cartId từ item cần xóa
    final response = await http.delete(Uri.parse("https://tripwonder.onrender.com/api/v1/order/deleteAll/$cartId"));

    if (response.statusCode == 200) {
      // Nếu xóa thành công, xóa item khỏi danh sách
      setState(() {
        items.removeAt(index);
      });
    } else {
      // Xử lý lỗi nếu xóa không thành công
      throw Exception('Failed to delete cart item');
    }
  }

  Future<void> _updateAttendancepl(int index, int change) async {
    final int newQuantity = items[index].quantity + change;
    if (newQuantity < 1) return; // Đảm bảo quantity không dưới 1

    final int? userId = UserManager().id; // Lấy userId
    final int tourId = items[index].packageTour.id; // Lấy tourId từ packageTour

    // Gọi API để cập nhật số lượng
    final response = await http.post(
      Uri.parse("https://tripwonder.onrender.com/api/v1/order/add/$userId/$tourId"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'quantity': newQuantity}),
    );

    if (response.statusCode == 200) {
      // Nếu cập nhật thành công, cập nhật số lượng trong items
      setState(() {
        items[index].quantity = newQuantity;
      });
    } else {
      // Xử lý lỗi nếu cập nhật không thành công
      throw Exception('Failed to update attendance');
    }
  }

  Future<void> _updateAttendancerm(int index, int change) async {
    final int newQuantity = items[index].quantity + change; // Tính số lượng mới
    final int cartId = items[index].id; // Lấy cartId từ item

    // Gọi API để cập nhật số lượng hoặc xóa item nếu số lượng <= 0
    final response = await http.delete(
      Uri.parse("https://tripwonder.onrender.com/api/v1/order/delete/$cartId"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'quantity': newQuantity}),
    );

    if (response.statusCode == 200) {
      setState(() {
        if (newQuantity < 1) {
          // Nếu số lượng mới < 1, xóa item khỏi danh sách
          items.removeAt(index);
        } else {
          // Nếu số lượng mới >= 1, cập nhật số lượng trong items
          items[index].quantity = newQuantity;
        }
      });
    } else {
      // In ra mã trạng thái và nội dung phản hồi để kiểm tra lỗi
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to update attendance');
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


  String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      locale: 'vi', // Định dạng kiểu Việt Nam
      symbol: '', // Bỏ ký hiệu tiền tệ nếu không cần
      decimalDigits: 0, // Không hiển thị số thập phân
    );
    return formatter.format(price).trim(); // Trim để xóa khoảng trắng nếu có
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      imageUrl: item.packageTour.imageUrl.toString(),
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
                      isNetworkImage: true, // Đảm bảo đánh dấu hình ảnh từ mạng
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
                                onPressed: () => _updateAttendancerm(index, -1),
                              ),
      
                              /// Attendance Number
                              Text(
                                item.quantity.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
      
                              // /// Increase Button
                              // IconButton(
                              //   icon: Icon(Icons.add),
                              //   onPressed: () => _updateAttendance(index, 1),
                              // ),
      
                              /// Increase Button
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => _updateAttendancepl(index, 1),
                              ),
      
                            ],
                          ),
                          TProductPriceText(price: formatPrice(item.totalPrice)),
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
            'Total Price: ${formatPrice(totalPrice)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

}
