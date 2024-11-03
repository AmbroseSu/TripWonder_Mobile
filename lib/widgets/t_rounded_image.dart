import 'package:flutter/material.dart';

import '../styles&text&sizes/colors.dart';
import '../styles&text&sizes/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = TColors.light,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        // child: ClipRRect(borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,

          child: ClipRRect(
            borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
            child: isNetworkImage
                ? Image.network(
              imageUrl,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                // Trả về một widget thay thế nếu có lỗi
                return Container(
                  color: Colors.grey, // Màu nền khi có lỗi
                  child: Icon(Icons.error, color: Colors.red), // Hình ảnh lỗi
                );
              },
            )
                : Image.asset(
              imageUrl,
              fit: fit,
            ),
          ),

          // child: Image(fit: fit, image: isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl) as ImageProvider)),
      ),
    );
  }
}