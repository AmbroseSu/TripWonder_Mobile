import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripwonder/api/global_variables/fcm_token_manage.dart';
import 'package:tripwonder/api/global_variables/user_manage.dart';
import 'package:tripwonder/navigation_menu.dart';
import 'package:tripwonder/screens/signup/fill_info_signup_google_form.dart';
import 'package:tripwonder/screens/signup/fill_infor_signup_google.dart';
import 'package:tripwonder/service/auth_service.dart';
import 'package:http/http.dart' as http;
import '../../styles&text&sizes/colors.dart';
import '../../styles&text&sizes/image_strings.dart';
import '../../styles&text&sizes/sizes.dart';

class TSocialButtons extends StatefulWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  _TSocialButtons createState() => _TSocialButtons();
}

class _TSocialButtons extends State<TSocialButtons> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 00.0),
        child: Column(
          children: [
            /// Create Account Button
            isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final UserCredential? userCredential =  await _authService.loginWithGoogle();
                      if (userCredential != null) {
                        final user = userCredential.user;
                        print("User ID: ${user?.uid}");
                        print("Display Name: ${user?.displayName}");
                        print(user?.phoneNumber);
                        print("Email: ${user?.email}");
                        print("Profile Photo URL: ${user?.photoURL}");

                        final url = 'https://tripwonder.onrender.com/api/v1/auth/signingoogle?email=${user?.email}';
                        final headers = {
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                        };
                        final body = jsonEncode({'email': user?.email});

                        try {
                          final response = await http.post(
                            Uri.parse(url),
                            headers: headers,
                            body: body,
                          );

                          print('Status code: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          if (response.statusCode == 200) {
                            final responseData = json.decode(response.body);
                            //final userId = responseData['content']['id'];
                            //final userRole = responseData['content']['role'];
                            //final userEmail = responseData['content']['email'];

                            UserManager userManager = UserManager();
                            userManager.id = responseData['content']['userDTO']['userId'];
                            userManager.email = responseData['content']['userDTO']['email'];
                            userManager.role = responseData['content']['userDTO']['role'];
                            userManager.token = responseData['content']['token'];
                            print(userManager.id);

                            final _baseUrl =
                                'https://tripwonder.onrender.com/api/v1/auth/save-infor-google';
                            print("00000000000000000000000000000000000000000000000000000000000000000");
                            print(user?.email);

                            final Map<String, dynamic> data = {
                              'email': user?.email,
                              'fullname': user?.displayName ?? null,
                              'phone': user?.phoneNumber ?? null,
                              'address': null,
                              'gender': null,
                              'fcmtoken': TokenManager().fcmToken ?? null,
                              'image': user?.photoURL ?? null,
                            };

                            final Uri url = Uri.parse(_baseUrl);

                            try {
                              final response = await http.post(
                                url,
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode(data),
                              );

                              print('Response Status Code: ${response.statusCode}');
                              print('Response Body: ${response.body}');
                              if (response.statusCode == 201) {
                                String body = "Save information successfully. Please login !!";
                                String title = "Create Successfully.";
                                // await PushNotificationService.sendNotificationToSelectedDrived(
                                //     fcmToken,
                                //     context,
                                //     title,
                                //     body
                                // );
                                Get.to(() => const NavigationMenu());
                              } else {
                                // Xử lý khi API thất bại
                                Get.snackbar('Error', 'Failed to sign up: ${response.statusCode}');
                              }
                            } catch (e) {
                              // Xử lý lỗi kết nối
                              Get.snackbar('Error', 'Failed to connect to the server: $e');
                              print("0000000000000000000000000000000000000000000000000000000000000");
                              print(e);
                            }


                          } else {
                            print('Failed to check email');
                            Get.snackbar('Error', 'Failed to check email: ${response.statusCode}');
                          }
                        } catch (error) {
                          print('Error: $error');
                          Get.snackbar('Error', 'An error occurred: $error');
                        }

                      } else {
                        print("Login failed or canceled");
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xFFC7C5CC),
                            width: 2), // Add border here
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              TImages.google,
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Continue with Google',
                              style: GoogleFonts.getFont(
                                "Roboto Condensed",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
