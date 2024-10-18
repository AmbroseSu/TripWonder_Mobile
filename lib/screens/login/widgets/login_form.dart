import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/api/global_variables/fcm_token_manage.dart';
import 'package:tripwonder/api/global_variables/user_manage.dart';
import 'package:tripwonder/api/request/sign_in_request.dart';
import 'package:tripwonder/navigation_menu.dart';
import 'package:tripwonder/screens/settings/settings.dart';
import 'package:tripwonder/screens/signup/signup.dart';
import 'package:tripwonder/screens/signup/verify_email.dart';
import 'package:http/http.dart' as http;
import '../../../styles&text&sizes/sizes.dart';
import '../../../styles&text&sizes/text_strings.dart';
import '../../explore_screen.dart';


class TLoginForm extends StatefulWidget {
  const TLoginForm({
    super.key,
  });

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserManager userManager = UserManager();
  bool _showPassword = false;
  Future<void> _signIn(BuildContext context) async {
    try {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      // Tạo SignInRequest từ dữ liệu người dùng nhập vào
      SignInRequest request = SignInRequest(
        login: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print('00000000000000000000000000000'+request.login + request.password);


      // Gửi yêu cầu POST đến API
      var response = await http.post(
        Uri.parse('https://tripwonder.onrender.com/api/v1/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      // Xử lý phản hồi từ API
      if (response.statusCode == 200) {
        // Phản hồi thành công, xử lý dữ liệu từ server ở đây
        var responseData = jsonDecode(response.body);
        var userDTO = responseData['content']['userDTO'];
        var token = responseData['content']['token'];

        userManager.id = userDTO['userId'];
        userManager.email = userDTO['email'];
        userManager.role = userDTO['role'];
        userManager.token = token;
        String? fcmToken = TokenManager().fcmToken;

        // Send notification using PushNotificationService
        // await PushNotificationService.sendNotificationToSelectedDrived(
        //   fcmToken,
        //   context
        // );

        print("00000000000000000000000000000000000000000000000000000000000");
        // Hiển thị dialog hoặc thực hiện hành động phù hợp sau khi đăng nhập thành công
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('Sign in successfully'),
        //       content: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           Text('ID: ${userDTO['id']}'),
        //           Text('Email: ${userDTO['email']}'),
        //           Text('Role: ${userDTO['role']}'),
        //           Text('Token: $token'),
        //         ],
        //       ),
        //       actions: <Widget>[
        //         TextButton(
        //           child: Text('OK'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //             // Navigate to another screen or perform another action
        Get.to(() => const NavigationMenu());
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      } else {
        // Phản hồi lỗi từ API, hiển thị thông báo lỗi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to sign in. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Xử lý lỗi trong quá trình gửi yêu cầu
      print('Error occurred during sign-in: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

@override
Widget build(BuildContext context) {
  return Form(
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [

          ///Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Password
          TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
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
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),

          /// Remember Me & Forger Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// Remember Me
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                    checkColor: Colors.white,
                    // Color of the checkmark
                    activeColor: Color(0xFF55B97D),
                    // Background color when checked
                    side: BorderSide(
                        color: Colors.black), // Border color of the checkbox
                  ),
                  const Text(TTexts.rememberMe),
                ],
              ),

              /// Forget Password
              TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.forgotPassword,
                    style: TextStyle(color: Colors.black),)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign In Button
          GestureDetector(

            onTap: () {_signIn(context);},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF55B97D),
              ),
              child: Center(
                child: Text(
                  TTexts.signIn,
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

          /// Create Account Button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                border: Border.all(
                    color: Color(0xFFC7C5CC), width: 2), // Add border here
              ),
              child: Center(
                child: Text(
                  TTexts.createAccount,
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    ),
  );
}}
