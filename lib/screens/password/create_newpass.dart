import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/api/global_variables/user_manage.dart';
import 'package:tripwonder/screens/password/reset_password.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../styles&text&sizes/text_strings.dart';
import 'package:http/http.dart' as http;

class CreateNewpass extends StatefulWidget {
  const CreateNewpass({super.key});

  @override
  _CreateNewpassState createState() => _CreateNewpassState();
}

class _CreateNewpassState extends State<CreateNewpass> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  Future<void> checkEmail(String email, String password) async {
    final String confirmPassword = _passwordConfirmController.text;
    if (confirmPassword != password) {
      Get.snackbar(
        'Error',
        'Confirm password does not match',
        snackPosition: SnackPosition.TOP,
        //backgroundColor: Colors.white,
        colorText: Colors.red,
      );
      return; // Dừng hàm nếu không trùng
    }
    final url = 'https://tripwonder.onrender.com/api/v1/auth/change-password?email=$email&password=$password';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'email': email, 'password' : password});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        //final userId = responseData['content']['id'];
        //final userRole = responseData['content']['role'];
        //final userEmail = responseData['content']['email'];

        // Chuyển đến OtpVerificationScreen với id và role
        Get.to(() => ResetPassword());
      } else {
        print('Failed to check email');
        Get.snackbar('Error', 'Failed to check email: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar('Error', 'An error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Headings
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
              child: Text(
                // TTexts.otpVerificationTitle,
                'Change your password',

                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Text fields
            TextFormField(
              expands: false,
              controller: _passwordController,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.direct_right),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Iconsax.eye : Iconsax.eye_slash,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              expands: false,
              controller: _passwordConfirmController,
              obscureText: !_showConfirmPassword,
              decoration: InputDecoration(
                labelText: TTexts.conPassword,
                prefixIcon: const Icon(Iconsax.direct_right),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirmPassword
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ),
                  onPressed: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Submit Button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(onPressed: () =>
            //       Get.off(() => const ResetPassword()), child: const Text(TTexts.create),
            //     // Get.off(() => const ResetPassword()), child: const Text(TTexts.submit)
            //   ),
            // )
            GestureDetector(
              onTap: () {
                final email = UserManager().email;
                final password = _passwordController.text.trim();
                if (email != null && password.isNotEmpty) {
                  // Directly navigate to the OtpVerificationScreen
                  checkEmail(email, password);
                } else {
                  Get.snackbar('Error', 'Please enter your email');
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF55B97D),
                ),
                child: Center(
                  child: Text(
                    "Change",
                    style: GoogleFonts.getFont(
                      "Roboto Condensed",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
