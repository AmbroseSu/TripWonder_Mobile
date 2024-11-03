import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/cart/cart.dart';
import 'package:tripwonder/screens/map/google_map_polygon.dart';
import 'package:tripwonder/screens/map/google_map_polyline.dart';
import 'package:tripwonder/screens/map/map_page.dart';
import 'package:tripwonder/screens/order/order.dart';

class MyTripCard extends StatelessWidget {
  final String cafeName;
  final String cafeImage;
  final double rating;
  final int reviewCount;
  final String time;
  final double price;

  const MyTripCard({
    super.key,
    required this.cafeName,
    required this.cafeImage,
    required this.rating,
    required this.reviewCount,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  cafeImage,
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(  // Thêm Expanded ở đây
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cafeName,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4.0),
                        Text(
                          rating.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          ' ($reviewCount)',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$$price',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Các thành phần khác vẫn giữ nguyên
// Discount section
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F7EF),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoogleMapPolyline()));
              },
              child: const Row(
                children: [
                  Icon(Iconsax.discount_circle, color: Color(0xFF55B97D)),
                  SizedBox(width: 8.0),
                  Text(
                    '1 Discount is applied',
                    style: TextStyle(
                        fontSize: 16, color: Color(0xFF55B97D), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF55B97D)),
          ],
        ),
      )],
      ),
    );
  }
}

