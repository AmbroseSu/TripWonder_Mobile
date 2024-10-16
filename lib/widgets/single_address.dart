// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tripwonder/widgets/rounded_container.dart';
// import '../styles&text&sizes/colors.dart';
// import '../styles&text&sizes/sizes.dart';
// import 'helper_functions.dart';
//
// class TSingleAddress extends StatelessWidget {
//   const TSingleAddress({super.key, required this.selectedAddress});
//
//   final bool selectedAddress;
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return TRoundedContainer(
//       showBorder: true,
//       padding: const EdgeInsets.all(TSizes.md),
//       width: double.infinity,
//       backgroundColor: selectedAddress
//           ? Color(0xFF55B97D).withOpacity(0.5)
//           : Colors.transparent,
//       borderColor: selectedAddress
//           ? Colors.transparent
//           : dark
//               ? TColors.darkerGrey
//               : TColors.grey,
//       margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 5,
//             top: 0,
//             child: Icon(
//               selectedAddress ? Iconsax.tick_circle5 : null,
//               color: selectedAddress
//                   ? dark
//                       ? TColors.light
//                       : TColors.dark
//                   : null,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'John Doe',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: TSizes.sm / 2),
//               const Text('(+84) 456 7890', maxLines: 1, overflow: TextOverflow.ellipsis),
//               const SizedBox(height: TSizes.sm / 2),
//               const Text('82356 Timmy Coves, South Liana, Maine, 87665, USA', softWrap: true),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:tripwonder/widgets/rounded_container.dart';
import '../api/global_variables/user_manage.dart';
import '../styles&text&sizes/colors.dart';
import '../styles&text&sizes/sizes.dart';
import 'helper_functions.dart';

class TSingleAddress extends StatefulWidget {
  const TSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  _TSingleAddressState createState() => _TSingleAddressState();
}

class _TSingleAddressState extends State<TSingleAddress> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final data = await fetchUserProfile();
      setState(() {
        userProfile = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error fetching user profile: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : hasError
        ? const Center(child: Text('Error loading profile'))
        : TRoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      width: double.infinity,
      backgroundColor: widget.selectedAddress
          ? Color(0xFF55B97D).withOpacity(0.5)
          : Colors.transparent,
      borderColor: widget.selectedAddress
          ? Colors.transparent
          : dark
          ? TColors.darkerGrey
          : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              widget.selectedAddress ? Iconsax.tick_circle5 : null,
              color: widget.selectedAddress
                  ? dark
                  ? TColors.light
                  : TColors.dark
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProfile?['fullname'] ?? 'Unknown User',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.sm / 2),
              Text(
                userProfile?['phone'] ?? '(+84) 456 7890',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: TSizes.sm / 2),
              Text(
                userProfile?['address'] ??
                    '82356 Timmy Coves, South Liana, Maine, 87665, USA',
                softWrap: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
