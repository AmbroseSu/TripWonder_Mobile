import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripwonder/navigation_menu.dart';
import 'package:tripwonder/screens/password/create_newpass.dart';
import 'package:tripwonder/screens/signup/signup.dart';
import '../../styles&text&sizes/sizes.dart';
import '../../styles&text&sizes/text_strings.dart';
import '../../widgets/helper_functions.dart';
import '../login/login.dart';

class ChangePassSuccess extends StatelessWidget {
  const ChangePassSuccess({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => const LoginScreen()), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        // Padding to Give Default Equal Space on all sides in all screens.
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(image: AssetImage(image), width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & Sub-title
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:  Color(0xFF55B97D),
                  ),
                  child: Center(
                    child: Text(
                      TTexts.tContinue,
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
      ),
    );
  }
}
