import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripwonder/widgets/section_heading.dart';
import '../screens/profile/profile.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Customer Information', buttonTitle: 'See All', onPressed: () => Get.to(() => ProfileScreen())),
        Text('TripWonder', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
