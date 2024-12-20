import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:tripwonder/screens/product_detail/place_screen.dart';
import 'package:tripwonder/styles&text&sizes/shadows.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';

import '../api/response/tour.dart';
import '../widgets/helper_functions.dart';
import '../widgets/product_price_text.dart';
import '../widgets/product_title_text.dart';
import '../widgets/rounded_container.dart';
import '../widgets/t_circular_icon.dart';
import '../widgets/t_rounded_image.dart';
import 'colors.dart';
import 'image_strings.dart';

class TProductCardVerticalFav extends StatelessWidget {
  final Tour tour;

  const TProductCardVerticalFav({
    super.key, required this.tour,

  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() =>
          PlaceScreen(tour: tour,)
      ),
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
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3.1,
                    child: TRoundedImage(
                      imageUrl: tour.getFirstImageUrl()!,
                      applyImageRadius: true,
                      fit: BoxFit.cover,
                      isNetworkImage: true, // Flag để sử dụng `Image.network`
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  TProductTitleText(title: tour.name, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  // Start time and end time
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(tour.startTime)} - ${DateFormat('dd/MM/yyyy').format(tour.endTime)}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              Row(
                    children: [
                      Text('Travel',
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
                  child: TProductPriceText(price: '${tour.price}'),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF55B97D),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
