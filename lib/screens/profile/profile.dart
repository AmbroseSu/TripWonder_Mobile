// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tripwonder/styles&text&sizes/colors.dart';
// import '../../api/global_variables/user_manage.dart';
// import '../../styles&text&sizes/image_strings.dart';
// import '../../styles&text&sizes/sizes.dart';
// import '../../widgets/appbar.dart';
// import '../../widgets/profile_menu.dart';
// import '../../widgets/section_heading.dart';
// import '../../widgets/t_circular_icon.dart';
// import '../../widgets/t_circular_image.dart';
// import '../settings/settings.dart';
// import 'package:http/http.dart' as http;
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   Future<Map<String, dynamic>> fetchUserProfile() async {
//     final int? userId = UserManager().id;
//
//     if (userId == null) {
//       throw Exception('User ID is null');
//     }
//
//     final response = await http.get(
//       Uri.parse("https://tripwonder.onrender.com/api/v1/user/get-user-by-id?userId=$userId"),
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['content'];
//     } else if (response.statusCode == 404) {
//       throw Exception('User not found: ${response.reasonPhrase}');
//     } else {
//       throw Exception('Failed to load user profile: ${response.reasonPhrase}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     void _showEditProfileDialog({
//       required BuildContext context,
//       required String title,
//       required String initialValue,
//       required Function(String) onSave,
//     }) {
//       final TextEditingController controller = TextEditingController(text: initialValue);
//
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text('Edit $title'),
//             content: TextField(
//               controller: controller,
//               decoration: InputDecoration(labelText: title),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Đóng dialog
//                 },
//                 child: const Text('Cancel', style: TextStyle(color: Colors.black)),
//               ),
//               TextButton(
//                 onPressed: () {
//                   onSave(controller.text); // Gọi hàm onSave với giá trị mới
//                   Navigator.of(context).pop(); // Đóng dialog
//                 },
//                 child: const Text('Save', style: TextStyle(color: Color(0xFF55B97D))),
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: TAppBar(
//         title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
//         showBackArrow: true,
//         actions: [
//           TCircularIcon(
//             icon: Iconsax.add,
//             onPressed: () => {},
//           )
//         ],
//       ),
//       /// -- Body
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(TSizes.defaultSpace),
//           child: FutureBuilder<Map<String, dynamic>>(
//             future: fetchUserProfile(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData) {
//                 return const Center(child: Text('No user data found'));
//               }
//
//               final user = snapshot.data!;
//
//               return Column(
//                 children: [
//                   /// Profile Picture
//                   SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                       children: [
//                         const TCircularImage(image: TImages.user, width: 80, height: 80),
//                         TextButton(
//                           onPressed: () {},
//                           child: const Text('Change Profile Picture', style: TextStyle(color: TColors.black)),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   /// Details
//                   const SizedBox(height: TSizes.spaceBtwItems / 2),
//                   const Divider(),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//
//                   /// Heading Profile Info
//                   const TSectionHeading(title: 'Profile Information', showActionButton: false),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//
//                   TProfileMenu(
//                     onPressed: () {
//                       _showEditProfileDialog(
//                         context: context,
//                         title: 'Name',
//                         initialValue: user['fullname'] ?? 'N/A',
//                         onSave: (newValue) {
//                           // Logic to update the name
//                           print('New Name: $newValue');
//                         },
//                       );
//                     },
//                     title: 'Name',
//                     value: user['fullname'] ?? 'N/A',
//                   ),
//
//                   TProfileMenu(
//                     onPressed: () {
//                       _showEditProfileDialog(
//                         context: context,
//                         title: 'Address',
//                         initialValue: user['address'] ?? 'N/A',
//                         onSave: (newValue) {
//                           // Logic to update the address
//                           print('New Address: $newValue');
//                         },
//                       );
//                     },
//                     title: 'Address',
//                     value: user['address'] ?? 'N/A',
//                   ),
//
//                   const SizedBox(height: TSizes.spaceBtwItems),
//                   const Divider(),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//
//                   /// Heading Personal Info
//                   const TSectionHeading(title: 'Personal Information', showActionButton: false),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//
//                   TProfileMenu(
//                     onPressed: () {},
//                     icon: Iconsax.copy,
//                     title: 'Role',
//                     value: user['role'] ?? 'N/A',
//                   ),
//                   TProfileMenu(
//                     onPressed: () {},
//                     title: 'E-mail',
//                     value: user['email'] ?? 'N/A',
//                   ),
//                   TProfileMenu(
//                     onPressed: () {
//                       _showEditProfileDialog(
//                         context: context,
//                         title: 'Phone Number',
//                         initialValue: user['phone'] ?? 'N/A',
//                         onSave: (newValue) {
//                           // Logic to update the phone number
//                           print('New Phone Number: $newValue');
//                         },
//                       );
//                     },
//                     title: 'Phone Number',
//                     value: user['phone'] ?? 'N/A',
//                   ),
//
//                   TProfileMenu(
//                     onPressed: () {},
//                     title: 'Gender',
//                     value: user['gender']?.toUpperCase() ?? 'N/A',
//                   ),
//
//                   const Divider(),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//
//                   Center(
//                     child: TextButton(
//                       onPressed: () => Get.to(() => const SettingsScreen()),
//                       child: const Text('Close Account', style: TextStyle(color: Colors.red)),
//                     ),
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/styles&text&sizes/colors.dart';
import '../../api/global_variables/user_manage.dart';
import '../../styles&text&sizes/image_strings.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../widgets/appbar.dart';
import '../../widgets/profile_menu.dart';
import '../../widgets/section_heading.dart';
import '../../widgets/t_circular_icon.dart';
import '../../widgets/t_circular_image.dart';
import '../settings/settings.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = fetchUserProfile();
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final int? userId = UserManager().id;

    if (userId == null) {
      throw Exception('User ID is null');
    }

    final response = await http.get(
      Uri.parse("https://tripwonder.onrender.com/api/v1/user/get-user-by-id?userId=$userId"),
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

  Future<void> updateUserProfile(int userId, Map<String, dynamic> updatedData) async {
    final response = await http.post(
      Uri.parse("https://tripwonder.onrender.com/api/v1/user/edit-profile?userId=$userId"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Profile updated successfully: ${data['details']}');
    } else {
      throw Exception('Failed to update profile: ${response.reasonPhrase}');
    }
  }

  void _showEditProfileDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    final TextEditingController controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: title),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text); // Gọi hàm onSave với giá trị mới
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Save', style: TextStyle(color: Color(0xFF55B97D))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TAppBar(
        title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => {},
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!;
          final int userId = user['id'];

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Profile Picture
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const TCircularImage(image: TImages.user, width: 80, height: 80),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Change Profile Picture', style: TextStyle(color: TColors.black)),
                        ),
                      ],
                    ),
                  ),

                  /// Details
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Heading Profile Info
                  const TSectionHeading(title: 'Profile Information', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TProfileMenu(
                    onPressed: () {
                      _showEditProfileDialog(
                        context: context,
                        title: 'Name',
                        initialValue: user['fullname'] ?? 'N/A',
                        onSave: (newValue) {
                          final updatedData = {
                            "id": userId,
                            "fullname": newValue,
                            "email": user['email'] ?? '',
                            "address": user['address'] ?? '',
                            "phoneNumber": user['phone'] ?? '',
                            "gender": user['gender'] ?? 'MALE',
                            "role": user['role'] ?? 'CUSTOMER',
                          };

                          updateUserProfile(userId, updatedData).then((_) {
                            setState(() {
                              user['fullname'] = newValue;
                            });
                          }).catchError((error) {
                            print('Failed to update profile: $error');
                          });
                        },
                      );
                    },
                    title: 'Name',
                    value: user['fullname'] ?? 'N/A',
                  ),

                  TProfileMenu(
                    onPressed: () {
                      _showEditProfileDialog(
                        context: context,
                        title: 'Address',
                        initialValue: user['address'] ?? 'N/A',
                        onSave: (newValue) {
                          final updatedData = {
                            "id": userId,
                            "fullname": user['fullname'] ?? '',
                            "email": user['email'] ?? '',
                            "address": newValue,
                            "phoneNumber": user['phone'] ?? '',
                            "gender": user['gender'] ?? 'MALE',
                            "role": user['role'] ?? 'CUSTOMER',
                          };

                          updateUserProfile(userId, updatedData).then((_) {
                            setState(() {
                              user['address'] = newValue;
                            });
                          }).catchError((error) {
                            print('Failed to update profile: $error');
                          });
                        },
                      );
                    },
                    title: 'Address',
                    value: user['address'] ?? 'N/A',
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Heading Personal Info
                  const TSectionHeading(title: 'Personal Information', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TProfileMenu(
                    onPressed: () {},
                    icon: Iconsax.copy,
                    title: 'Role',
                    value: user['role'] ?? 'N/A',
                  ),
                  TProfileMenu(
                    onPressed: () {},
                    title: 'E-mail',
                    value: user['email'] ?? 'N/A',
                  ),
                  TProfileMenu(
                    onPressed: () {
                      _showEditProfileDialog(
                        context: context,
                        title: 'Phone Number',
                        initialValue: user['phone'] ?? 'N/A',
                        onSave: (newValue) {
                          final updatedData = {
                            "id": userId,
                            "fullname": user['fullname'] ?? '',
                            "email": user['email'] ?? '',
                            "address": user['address'] ?? '',
                            "phoneNumber": newValue,
                            "gender": user['gender'] ?? 'MALE',
                            "role": user['role'] ?? 'CUSTOMER',
                          };

                          updateUserProfile(userId, updatedData).then((_) {
                            setState(() {
                              user['phone'] = newValue;
                            });
                          }).catchError((error) {
                            print('Failed to update profile: $error');
                          });
                        },
                      );
                    },
                    title: 'Phone Number',
                    value: user['phone'] ?? 'N/A',
                  ),

                  TProfileMenu(
                    onPressed: () {},
                    title: 'Gender',
                    value: user['gender']?.toUpperCase() ?? 'N/A',
                  ),

                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Center(
                    child: TextButton(
                      onPressed: () => Get.to(() => const SettingsScreen()),
                      child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

