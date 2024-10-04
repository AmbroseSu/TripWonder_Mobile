import 'package:flutter/material.dart';

import '../../styles&text&sizes/colors.dart';
import '../../styles&text&sizes/image_strings.dart';
import '../../styles&text&sizes/sizes.dart';
import 'fill_info_signup_google_form.dart';
import 'fill_info_signup_google_header.dart';




class FillInforSignupGoogle extends StatelessWidget {
  const FillInforSignupGoogle({super.key});
  static final ValueNotifier<String?> _selectedGender = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue background with image
          Container(
            height: 500,
            color: TColors.primary, // Blue background color
            child: const Center(
              child: Image(
                height: 250, // Increase the height to make the image larger
                image: AssetImage(TImages.signupImage),
              ),
            ),
          ),
          // Form container
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 200), // Space from top to overlay the form
                padding: const EdgeInsets.all(TSizes.md),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TFillInfoSignUpGoogleHeader(),
                    const SizedBox(height: TSizes.xl),

                    /// Form
                    TFillInfoSignUpGoogleForm(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}