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
//
// class PlaceScreen extends StatelessWidget {
//   const PlaceScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height / 2.4,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/Coeurdes Alpes.png"),
//                             fit: BoxFit.cover,
//                           )),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(15),
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 2,
//                                     spreadRadius: 4,
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.arrow_back,
//                                 color: Color(0xFFB8B8B8),
//                                 size: 20,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                         bottom: -20,
//                         right: 20,
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 2,
//                                 spreadRadius: 4,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.favorite,
//                             size: 30,
//                             color: Colors.redAccent,
//                           ),
//                         )),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Coeurdes Aples",
//                         style: GoogleFonts.getFont(
//                           "Montserrat",
//                           fontWeight: FontWeight.w600,
//                           fontSize: 28,
//                           color: Color(0xFF232323),
//                         ),
//                       ),
//                       Text(
//                         "Show Map",
//                         style: GoogleFonts.getFont(
//                           "Roboto Condensed",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: Color(0xFF55B97D),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(Icons.star, color: Colors.amber),
//                     SizedBox(width: 5),
//                     Text(
//                       "4.5 (345 Reviews)",
//                       style: GoogleFonts.getFont(
//                         "Roboto Condensed",
//                         fontWeight: FontWeight.w500,
//                         fontSize: 15,
//                         color: Color(0xFF606060),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   "Aspen, in Colorado’s Rocky Mountains, is a ski resort town and year-round destination for outdoor recreation. It's also known for high-end restaurants and boutiques, and landmarks like the Wheeler Opera House, built in 1889 during the area’s silver mining boom. ",
//                   style: GoogleFonts.getFont(
//                     "Roboto Condensed",
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15,
//                     color: Color(0xFF9B9B9B),
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 29),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Facilities",
//                         style: GoogleFonts.getFont(
//                           "Montserrat",
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           color: Color(0xFF232323),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           _buildCard(
//                               assetPath: 'assets/vectors/vector_2_x2.svg',
//                               text: "1 Heater"),
//                           _buildCard(
//                               assetPath: 'assets/vectors/vector_1_x2.svg',
//                               text: "1 Dinner"),
//                           _buildCard(
//                               assetPath: 'assets/vectors/vector_x2.svg',
//                               text: "1 Tub"),
//                           _buildCard(
//                               assetPath: 'assets/vectors/vector_3_x2.svg',
//                               text: "Pool"),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 25),
//
//                 /// -- Galleries
//                 Text(
//                   "Galleries",
//                   style: GoogleFonts.getFont(
//                     "Montserrat",
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Color(0xFF232323),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(TSizes.defaultSpace),
//                   child: TGallerySlider(banners: [TImages.chicago, TImages.lima, TImages.tokyo],),
//                 ),
//                 // SizedBox(height: 25),
//
//                 /// Best time to visit
//                 SizedBox(height: 15),
//                 Text(
//                   "Best time to visit",
//                   style: GoogleFonts.getFont(
//                     "Montserrat",
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Color(0xFF232323),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "November to February: This period is generally considered the best time to visit Mount Fuji for clear views.\n April and May: During these months, Mount Fuji becomes adorned with pink moss at its base, making it easier to spot even from a distance.\n June to August: These are the most challenging months to see Mount Fuji due to cloud cover.",
//                   style: GoogleFonts.getFont(
//                     "Roboto Condensed",
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15,
//                     color: Color(0xFF9B9B9B),
//                   ),
//                 ),
//
//                 /// -- Reviews
//                 const Divider(),
//                 const SizedBox(height: TSizes.spaceBtwItems),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const TSectionHeading(title: 'Reviews (345)', showActionButton: false),
//                     IconButton(onPressed: () => Get.to(() => const ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right_3))
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           height: 80,
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         "Price",
//                         style: GoogleFonts.getFont(
//                           "Roboto Condensed",
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Color(0xFF232323),
//                         ),
//                       ),
//
//                     ),
//                     Text(
//                       "\$199",
//                       style: GoogleFonts.getFont(
//                         "Montserrat",
//                         fontWeight: FontWeight.w700,
//                         fontSize: 24,
//                         color: Color(0xE2FF5252),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Get.to(() => const CheckoutScreen()),
//                 child: Container(
//                   height: 60,
//                   width: MediaQuery.of(context).size.width / 2,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Color(0xFF55B97D),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Book Now",
//                       style: GoogleFonts.getFont(
//                         "Roboto Condensed",
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({required String assetPath, required String text}) {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         padding: EdgeInsets.fromLTRB(0, 14, 0, 12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Color(0x0D176FF2),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 8),
//               width: 30,
//               height: 28,
//               child: SvgPicture.asset(assetPath),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 1.3),
//               child: Text(
//                 text,
//                 style: GoogleFonts.getFont(
//                   "Roboto Condensed",
//                   fontWeight: FontWeight.w500,
//                   fontSize: 15,
//                   color: Colors.black26,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key});

  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  Future<Map<String, dynamic>> _fetchTourData(int packageOfficialId) async {
    final response = await http.get(Uri.parse(
        'https://tripwonder.onrender.com/api/v1/packageOff/get-package-tour-by-id?packageOfficialId=$packageOfficialId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['content'];
    } else {
      throw Exception('Failed to load tour data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchTourData(1), // Sử dụng packageOfficialId là 1
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            final tourData = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phần Stack và hình ảnh
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(tourData['galleries'][0]['imageUrl']), // Lấy hình ảnh từ API
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
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
                              )
                            ],
                          ),
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tourData['name'], // Tên tour từ API
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: Color(0xFF232323)),
                          ),
                          Text(
                            "Show Map",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF55B97D)),
                          ),
                        ],
                      ),
                    ),
                    // Các phần khác...
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
