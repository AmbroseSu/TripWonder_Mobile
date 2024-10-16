import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/api/global_variables/fcm_token_manage.dart';
import 'package:tripwonder/screens/product_detail/favorite.dart';
import '../../styles&text&sizes/colors.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../styles&text&sizes/text_strings.dart';
import '../../widgets/appbar.dart';
import '../../widgets/primary_header_container.dart';
import '../../widgets/section_heading.dart';
import '../../widgets/settings_menu_tile.dart';
import '../../widgets/user_profile_tile.dart';
import '../address/address.dart';
import '../cart/cart.dart';
import '../login/login.dart';
import '../order/order.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// AppBar
                  const TAppBar(
                    title: Text('Account', style: TextStyle(color: Colors.white, fontSize: 35)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// User Profile Card
                  TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),


            /// -- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery address', onTap: () => Get.to(() => const UserAddressScreen()),),
                  TSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'Order', subTitle: 'Add, remove products and move to checkout', onTap: () => Get.to(() => const CartScreen())),
                  TSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Booking', subTitle: 'In-progress and Completed Orders', onTap: () => Get.to(() => const OrderScreen())),
                  TSettingsMenuTile(icon: Iconsax.heart, title: 'Favorite Tours', subTitle: 'List of your favorite tours', onTap: () => Get.to(() => const FavoriteScreen())),
                  const TSettingsMenuTile(icon: Iconsax.discount_shape, title: 'Recommend Tours', subTitle: 'List of all the recommend tours'),
                  const TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notifications message'),
                  const TSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts'),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase'),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_safe,
                    title: 'Safe Mode',
                    subTitle: 'Set result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFC7C5CC), width: 1),
                      ),
                      child: Center(
                        child: Text(
                          TTexts.loginOut,
                          style: GoogleFonts.getFont(
                            "Roboto Condensed",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
