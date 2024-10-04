import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:tripwonder/screens/explore_screen.dart';
import 'package:tripwonder/screens/login/widgets/login_form.dart';
import 'package:tripwonder/screens/login/widgets/login_header.dart';
import 'package:tripwonder/styles&text&sizes/colors.dart';
import 'package:tripwonder/styles&text&sizes/image_strings.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/styles&text&sizes/text_strings.dart';

import '../../styles&text&sizes/spacing_styles.dart';
import '../../widgets/login_signup/form_divider.dart';
import '../../widgets/login_signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            ///Logo, Title & Sub-Title
            TLoginHeader(),

            /// Form
            TLoginForm(),

            /// Divider
            TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Footer
            TSocialButtons(),
          ],
        ),
      )),
    );
  }
}
