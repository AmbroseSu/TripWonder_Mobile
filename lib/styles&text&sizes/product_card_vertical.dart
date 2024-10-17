
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/product_detail/place_screen.dart';
import 'package:tripwonder/styles&text&sizes/shadows.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import '../widgets/helper_functions.dart';
import '../widgets/product_price_text.dart';
import '../widgets/product_title_text.dart';
import '../widgets/rounded_container.dart';
import '../widgets/t_circular_icon.dart';
import '../widgets/t_rounded_image.dart';
import 'colors.dart';
import 'image_strings.dart';



class TProductCardVertical extends StatelessWidget {
  final String title;
  final String price;
  final String province;
  final String? gallery; // Thêm trường gallery

  const TProductCardVertical({
    super.key,
    required this.title,
    required this.price,
    required this.province,
    this.gallery, // Thêm tham số gallery vào constructor
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return
      GestureDetector(
      onTap: () => Get.to(() => const PlaceScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          children: [
            // TRoundedContainer(
            //   // padding: const EdgeInsets.all(TSizes.sm),
            //   backgroundColor: dark ? TColors.dark : TColors.light,
            //   child: Stack(
            //     children: [
            //       AspectRatio(
            //         aspectRatio: 4 ,
            //         child: TRoundedImage(
            //           imageUrl: gallery ?? TImages.tokyo, // Sử dụng ảnh từ gallery hoặc ảnh mặc định
            //           applyImageRadius: true,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            TRoundedContainer(
              width: 200,
              // padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: SizedBox(
                child: TRoundedImage(
                  height: 95,
                  imageUrl: gallery ?? TImages.tokyo,
                  applyImageRadius: true,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text(province,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(width: TSizes.xs),
                      const Icon(Iconsax.verify5,
                          color: TColors.primary, size: TSizes.iconXs),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: price),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(child: Icon(Iconsax.add, color: TColors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
