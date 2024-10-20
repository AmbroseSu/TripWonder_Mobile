import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/checkout/checkout.dart';
import 'package:tripwonder/screens/product_detail/product_reviews.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/gallery_slider.dart';
import 'package:tripwonder/widgets/section_heading.dart';

import '../../styles&text&sizes/image_strings.dart';
import '../../widgets/promo_slider.dart';

class PlaceScreen extends StatefulWidget {
  final String title;
  final String price;
  final String province;
  final String? gallery;
  final String startTime;
  final String endTime;
  final String shortDescription;
  final String description;

  const PlaceScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.province,
    this.gallery,
    required this.startTime,
    required this.endTime,
    required this.shortDescription,
    required this.description,
  }) : super(key: key);

  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height / 2.4,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     image: DecorationImage(
                    //       image: widget.gallery != null
                    //           ? AssetImage(widget.gallery!)
                    //           : AssetImage('assets/images/default_image.png'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.all(15),
                    //           padding: EdgeInsets.all(10),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.black12,
                    //                 blurRadius: 2,
                    //                 spreadRadius: 4,
                    //               ),
                    //             ],
                    //           ),
                    //           child: Icon(
                    //             Icons.arrow_back,
                    //             color: Color(0xFFB8B8B8),
                    //             size: 20,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          widget.gallery!, // Thêm dấu chấm than (!) để tránh lỗi null
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Hiển thị hình ảnh mặc định hoặc thông báo khi không tải được
                            return Center(child: Text('Failed to load image'));
                          },
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFFB8B8B8),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                        bottom: -20,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.redAccent,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.getFont(
                            "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Color(0xFF232323),
                          ),
                        ),
                      ),
                      SizedBox(width: 20), // Increase this value for more space
                      Text(
                        "Show Map",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF55B97D),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 5),
                    Text(
                      "4.5 (345 Reviews)",
                      style: GoogleFonts.getFont(
                        "Roboto Condensed",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF606060),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  widget.shortDescription,
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFF9B9B9B),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 29),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Facilities",
                        style: GoogleFonts.getFont(
                          "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF232323),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildCard(
                              assetPath: 'assets/vectors/vector_2_x2.svg',
                              text: "1 Heater"),
                          _buildCard(
                              assetPath: 'assets/vectors/vector_1_x2.svg',
                              text: "1 Dinner"),
                          _buildCard(
                              assetPath: 'assets/vectors/vector_x2.svg',
                              text: "1 Tub"),
                          _buildCard(
                              assetPath: 'assets/vectors/vector_3_x2.svg',
                              text: "Pool"),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),

                /// -- Galleries
                Text(
                  "Galleries",
                  style: GoogleFonts.getFont(
                    "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: TGallerySlider(
                    banners: [TImages.chicago, TImages.lima, TImages.tokyo],
                  ),
                ),
                // SizedBox(height: 25),

                /// Best time to visit
                SizedBox(height: 15),
                Text(
                  "Best time to visit",
                  style: GoogleFonts.getFont(
                    "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.description,
                  style: GoogleFonts.getFont(
                    "Roboto Condensed",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFF9B9B9B),
                  ),
                ),

                /// -- Reviews
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TSectionHeading(
                        title: 'Reviews (345)', showActionButton: false),
                    IconButton(
                        onPressed: () =>
                            Get.to(() => const ProductReviewsScreen()),
                        icon: const Icon(Iconsax.arrow_right_3))
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Price",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF232323),
                        ),
                      ),
                    ),
                    Text(
                      widget.price,
                      style: GoogleFonts.getFont(
                        "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xE2FF5252),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => const CheckoutScreen()),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF55B97D),
                  ),
                  child: Center(
                    child: Text(
                      "Book Now",
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

  Widget _buildCard({required String assetPath, required String text}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.fromLTRB(0, 14, 0, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0x0D176FF2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              width: 30,
              height: 28,
              child: SvgPicture.asset(assetPath),
            ),
            Padding(
              padding: EdgeInsets.only(right: 1.3),
              child: Text(
                text,
                style: GoogleFonts.getFont(
                  "Roboto Condensed",
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black26,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
