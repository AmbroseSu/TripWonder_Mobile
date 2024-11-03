import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:tripwonder/screens/product_detail/my_trip.dart';
import '../../api/global_variables/user_manage.dart';
import '../../api/response/order.dart';
import '../../styles&text&sizes/colors.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../widgets/helper_functions.dart';
import '../../widgets/rounded_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TOrderListItems extends StatefulWidget {
  const TOrderListItems({super.key});

  @override
  _TOrderListItemsState createState() => _TOrderListItemsState();
}

class _TOrderListItemsState extends State<TOrderListItems> {
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }
  

  Future<void> fetchOrders() async {
    final int? userId = UserManager().id;
    final response = await http.get(
      Uri.parse('https://tripwonder.onrender.com/api/v1/order/getAllOrder?userId=$userId'),
    );

    if (response.statusCode == 200) {
      // Sử dụng utf8.decode để đảm bảo dữ liệu được giải mã đúng
      final decodedData = utf8.decode(response.bodyBytes);
      final data = json.decode(decodedData);
      setState(() {
        orders = (data['content'] as List)
            .map((orderJson) => Order.fromJson(orderJson))
            .toList();
        isLoading = false;
      });
    } else {
      // Xử lý lỗi nếu cần
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return isLoading
        ? Center(child: CircularProgressIndicator()) // Hiển thị loading indicator
        : ListView.separated(
      shrinkWrap: true,
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        final order = orders[index];
        final startDate = DateFormat('dd-MM-yyyy').format(order.startTime.toLocal());
        final endDate = DateFormat('dd-MM-yyyy').format(order.endTime.toLocal());


        return TRoundedContainer(
          showBorder: true,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.dark : TColors.light,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Iconsax.ship),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.state,
                          style: Theme.of(context).textTheme.bodyLarge!.apply(color: Color(0xFF55B97D), fontWeightDelta: 1),
                        ),
                        Text(order.name.toString(), style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.to(() => MyTripScreen()), // Chuyển đến MyTripScreen với packageId
                    icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.tag),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order', style: Theme.of(context).textTheme.labelLarge),
                              Text('[#${order.orderCode}]', style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.calendar),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${order.category.name.toString()}', style: Theme.of(context).textTheme.labelLarge), // Hiển thị tên category
                              Text('$startDate  $endDate', style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
