import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/password/create_newpass.dart';
import 'package:tripwonder/screens/product_detail/all_tours.dart';
import 'package:tripwonder/screens/product_detail/favorite.dart';
import 'package:tripwonder/screens/signup/verify_email.dart';
import '../../api/global_variables/user_manage.dart';
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
import 'package:http/http.dart' as http;
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final int? userId = UserManager().id;

    if (userId == null) {
      throw Exception('User ID is null');
    }

    final response = await http.get(
      Uri.parse(
          "https://tripwonder.onrender.com/api/v1/user/get-user-by-id?userId=$userId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['content'];
    } else if (response.statusCode == 404) {
      throw Exception('User not found: ${response.reasonPhrase}');
    } else {
      throw Exception('Failed to load user profile: ${response.reasonPhrase}');
    }
  }

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
                    title: Text('Account',
                        style: TextStyle(color: Colors.white, fontSize: 35)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// User Profile Card
                  TUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
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
                  const TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'Order',
                      subTitle: 'Add, remove products and move to checkout',
                      onTap: () => Get.to(() => const CartScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Booking',
                      subTitle: 'In-progress and Completed Orders',
                      onTap: () => Get.to(() => const OrderScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.folder,
                      title: 'All Tours',
                      subTitle: 'List all tours in TripWonder',
                      onTap: () => Get.to(() => const AllToursScreen())),
                  // TSettingsMenuTile(icon: Iconsax.category, title: 'All Categories', subTitle: 'List all categories in TripWonder', onTap: () => Get.to(() => const CategoryScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.heart,
                      title: 'Favorite Tours',
                      subTitle: 'List of your favorite tours',
                      onTap: () => Get.to(() => const FavoriteScreen())),
                  TSettingsMenuTile(
                    icon: Icons.password,
                    title: 'Change Password',
                    subTitle:
                        'Change your account password with OTP verification',
                    onTap: () => Get.to(() => const CreateNewpass()),
                  ),
                  const TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'Recommend Tours',
                      subTitle: 'List of all the recommend tours'),
                  const TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notifications message'),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload Data to your Cloud Firebase'),
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
