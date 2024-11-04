import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/api/global_variables/fcm_token_manage.dart';
import 'package:tripwonder/api/global_variables/user_manage.dart';
import 'package:tripwonder/api/push_notification_service.dart';
import 'package:tripwonder/consts.dart';
import 'package:tripwonder/screens/login/login.dart';
import 'package:tripwonder/service/media_service.dart';
import 'package:tripwonder/service/storage_service.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/styles&text&sizes/text_strings.dart';
import 'package:tripwonder/widgets/login_signup/form_divider.dart';
import 'package:tripwonder/widgets/login_signup/social_buttons.dart';

import '../../styles&text&sizes/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GetIt _getIt = GetIt.instance;
  late StorageService _storageService;
  late MediaService _mediaService;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final ValueNotifier<String?> selectedGender = ValueNotifier<String?>(null);
  final TextEditingController _addressController = TextEditingController();
  File? selectedImage;
  final String _baseUrl =
      'https://tripwonder.onrender.com/api/v1/auth/save-infor';

  UserManager userManager = UserManager();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
  }

  Future<void> _signup() async {
    final String? email = userManager.email;
    final String fullname = _fullnameController.text;
    final String phone = _phoneController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _passwordConfirmController.text;
    final String address = _addressController.text;
    final String gender = selectedGender.value ?? 'Other';
    final String? fcmtoken = TokenManager().fcmToken;
    final String? pfpURL;

    if (selectedImage != null) {
      pfpURL = await _storageService.uploadUserPfp(
        file: selectedImage!,
      );
    }else{
      pfpURL = null;
    }



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
    if (fullname.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        gender.isEmpty) {
      Get.snackbar(
        'Error',
        'Please input all fields',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      return; // Dừng hàm nếu có bất kỳ trường nào trống
    }

    final Map<String, dynamic> data = {
      'email': email,
      'fullname': fullname,
      'phone': phone,
      'password': password,
      'address': address,
      'gender': gender.toUpperCase(),
      'fcmtoken': fcmtoken,
      'image': pfpURL,
    };

    print("Đây là data aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: $data");
    print(fullname);
    print(phone);
    print(address);
    print(password);
    print(gender);
    print(fcmtoken);
    print(pfpURL);

    final Uri url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      String? fcmToken = TokenManager().fcmToken;
      if (response.statusCode == 201) {
        String body = "Save information successfully. Please login !!";
        String title = "Create Successfully.";
        await PushNotificationService.sendNotificationToSelectedDrived(
            fcmToken,
            context,
            title,
            body
        );
        Get.to(() => const LoginScreen());
      } else {
        // Xử lý khi API thất bại
        Get.snackbar('Error', 'Failed to sign up: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      Get.snackbar('Error', 'Failed to connect to the server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text('Fill your information',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Form
              Form(
                child: Column(
                  children: [
                    _pfpSelectionFiled(),
                    TextButton(
                      onPressed: () async {
                        File? file = await _mediaService.getImageFromGallery();
                        if (file != null) {
                          setState(() {
                            selectedImage = file;
                          });
                        }
                      },
                      child: const Text(
                        'Choose Profile Picture',
                        style: TextStyle(color: TColors.black),
                      ),
                    ),

                    /// Fullname
                    TextFormField(
                      expands: false,
                      controller: _fullnameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Phone number
                    TextFormField(
                      expands: false,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: TTexts.phoneNo,
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Password
                    TextFormField(
                      expands: false,
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: TTexts.password,
                        prefixIcon: const Icon(Iconsax.password_check),
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
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Confirm Password
                    TextFormField(
                      expands: false,
                      controller: _passwordConfirmController,
                      obscureText: !_showConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Iconsax.password_check),
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
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Address
                    TextFormField(
                      expands: false,
                      controller: _addressController,
                      decoration: const InputDecoration(
                          labelText: TTexts.address,
                          prefixIcon: Icon(Iconsax.location)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Gender Dropdown
                    // DropdownButtonFormField<String>(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Gender',
                    //     prefixIcon: Icon(Iconsax.user_tag),
                    //   ),
                    //   dropdownColor: Colors.white,
                    //   value: selectedGender,
                    //   items: <String>['Female', 'Male', 'Other']
                    //       .map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       selectedGender = newValue;
                    //     });
                    //   },
                    // ),
                    // const SizedBox(height: TSizes.spaceBtwInputFields),
                    ValueListenableBuilder<String?>(
                      valueListenable: selectedGender,
                      builder: (context, value, child) {
                        return DropdownButtonFormField<String>(
                          value: value,
                          onChanged: (String? newValue) {
                            selectedGender.value = newValue;
                          },
                          items: <String>['Male', 'Female', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Terms&Conditions Checkbox
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
                            checkColor: Colors.white,
                            activeColor: Color(0xFF55B97D),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: 'By using TripWonder, you agree to ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: 'Terms ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                        color: Colors.black,
                                        decorationColor: Colors.black)),
                            TextSpan(
                                text: 'and ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                        color: Colors.black,
                                        decorationColor: Colors.black)),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Sign Up Button
                    GestureDetector(
                      onTap: () {
                        _signup();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF55B97D),
                        ),
                        child: Center(
                          child: Text(
                            TTexts.createAccount,
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
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Social Buttons
              const TSocialButtons(),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pfpSelectionFiled() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage(PLACEHOLDER_PFF) as ImageProvider,
      ),
    );
  }
}
