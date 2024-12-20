// import 'package:flutter/material.dart';
//
// class TSectionHeading extends StatelessWidget {
//   const TSectionHeading({
//     super.key,
//     this.textColor,
//     this.showActionButton = true,
//     required this.title,
//     this.buttonTitle = "See all",
//     this.onPressed,
//   });
//
//   final Color? textColor;
//   final bool showActionButton;
//   final String title, buttonTitle;
//   final void Function()? onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(title,
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineSmall!
//                 .apply(color: textColor),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis),
//         if (showActionButton)
//           TextButton(onPressed: onPressed, child: Text(buttonTitle))
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tripwonder/styles&text&sizes/colors.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = "See all",
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor), maxLines: 1, overflow: TextOverflow.ellipsis,),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle, style: TextStyle(color: Color(0xFF55B97D)),)),
      ],
    );
  }
}
