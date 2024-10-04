import 'package:flutter/material.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: TSizes.appBarHeight,
      left: TSizes.defaultSpace,
      bottom: TSizes.defaultSpace,
      right: TSizes.defaultSpace,
  );
}