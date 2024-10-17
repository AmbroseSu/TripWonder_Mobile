import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/explore_screen.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical_fav.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/appbar.dart';
import 'package:tripwonder/widgets/grid_layout.dart';
import 'package:tripwonder/widgets/t_circular_icon.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TAppBar(
        title:
            Text('Favorite', style: Theme.of(context).textTheme.headlineMedium), showBackArrow: true,
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const ExploreScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(itemCount: 6, itemBuilder: (_, index) => const TProductCardVerticalFav())
            ],
          ),
        ),
      ),
    );
  }
}
