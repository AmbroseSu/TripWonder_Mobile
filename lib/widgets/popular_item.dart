import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripwonder/screens/product_detail/place_screen.dart';

class PopularItem extends StatelessWidget {
  final String title;
  final String rating;
  final String image;
  final VoidCallback? onTap;


  const PopularItem({
    super.key,
    required this.title,
    required this.rating,
    required this.image, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => PlaceScreen(
      //         title: title, // Truyền title vào PlaceScreen
      //         price: '', // Cần điền thông tin giá nếu có
      //         province: '', // Cần điền thông tin tỉnh nếu có
      //         startTime: '', // Cần điền thông tin thời gian bắt đầu nếu có
      //         endTime: '', // Cần điền thông tin thời gian kết thúc nếu có
      //         shortDescription: '', // Cần điền mô tả ngắn nếu có
      //         description: '', // Cần điền mô tả nếu có
      //         gallery: '', // Cần điền thông tin gallery nếu có
      //       ),
      //     ),
      //   );
      // },
      onTap: onTap,
      child: Container(
        width: 250,
        height: 290,
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.9,
            image: NetworkImage(image), // Sử dụng NetworkImage
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF4D5652),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF4D5652),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/star_1_x2.svg',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 5), // Thêm khoảng cách giữa sao và rating
                          Text(
                            rating,
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:get/get.dart';
//
// class ExploreScreen extends StatefulWidget {
//   const ExploreScreen({super.key});
//
//   @override
//   State<ExploreScreen> createState() => _ExploreScreenState();
// }
//
// class _ExploreScreenState extends State<ExploreScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<Map<String, dynamic>> _categories = [];
//   List<dynamic> _recommendedTours = [];
//   Map<String, List<dynamic>> _categoryTours = {}; // Lưu danh sách tour theo categoryId
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//     fetchRecommendedTours();
//   }
//
//   Future<void> fetchCategories() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://tripwonder.onrender.com/api/v1/category/get-all?page=1&limit=100'),
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(utf8.decode(response.bodyBytes));
//         final List categories = data['content'];
//
//         setState(() {
//           _categories = categories.map((category) => {
//             'id': category['id'],
//             'name': category['name']
//           }).toList();
//           _tabController = TabController(length: _categories.length, vsync: this);
//         });
//
//         // Gọi API để lấy tour cho mỗi category
//         for (var category in _categories) {
//           await fetchToursByCategory(category['id'].toString());
//         }
//       } else {
//         throw Exception('Failed to load categories');
//       }
//     } catch (e) {
//       print("Error fetching categories: $e");
//     }
//   }
//
//   Future<void> fetchToursByCategory(String categoryId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100&category=$categoryId'),
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(utf8.decode(response.bodyBytes));
//         setState(() {
//           _categoryTours[categoryId] = data['content']['content']; // Lưu tour theo categoryId
//         });
//       } else {
//         throw Exception('Failed to load tours for category: $categoryId');
//       }
//     } catch (e) {
//       print("Error fetching tours for category $categoryId: $e");
//     }
//   }
//
//   Future<void> fetchRecommendedTours() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(utf8.decode(response.bodyBytes));
//         setState(() {
//           _recommendedTours = data['content']['content'];
//         });
//       } else {
//         throw Exception('Failed to load recommended tours');
//       }
//     } catch (e) {
//       print("Error fetching recommended tours: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             SizedBox(height: 10),
//             _buildHeader(),
//             _buildSearchBar(),
//             _buildTabBar(),
//             _buildTabBarView(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Explore",
//                 style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 16),
//               ),
//               Text(
//                 "TripWonder",
//                 style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 32),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.location_on,
//                 color: Color(0xFF55B97D),
//                 size: 20,
//               ),
//               SizedBox(width: 6),
//               Text(
//                 "District 9, \nHo Chi Minh",
//                 style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF606060)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         decoration: BoxDecoration(
//           color: Color(0xFFF3F8FE),
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: "Find places to visit",
//             border: InputBorder.none,
//             prefixIcon: Icon(Icons.search),
//             hintStyle: GoogleFonts.montserrat(color: Colors.grey),
//           ),
//           onSubmitted: (query) {
//             if (query.isNotEmpty) {
//               Get.to(() => SearchResult(query: query));
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabBar() {
//     if (_categories.isEmpty) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     return TabBar(
//       controller: _tabController,
//       isScrollable: true,
//       indicatorColor: Color(0xFF55B97D),
//       labelColor: Color(0xFF55B97D),
//       unselectedLabelColor: Color(0xFFB8B8B8),
//       labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 16),
//       unselectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 16),
//       tabs: _categories.map((category) => Tab(text: category['name'])).toList(),
//     );
//   }
//
//   Widget _buildTabBarView() {
//     if (_categories.isEmpty) {
//       return Expanded(child: Center(child: CircularProgressIndicator()));
//     }
//
//     return Expanded(
//       child: TabBarView(
//         controller: _tabController,
//         children: _categories.map((category) => buildTabContent(category)).toList(),
//       ),
//     );
//   }
//
//   Widget buildTabContent(Map<String, dynamic> category) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildPromoSlider(),
//             SizedBox(height: 12),
//             _buildSectionHeader("Popular"),
//             _buildPopularItems(category['id'].toString()), // Truyền categoryId vào đây
//             SizedBox(height: 32),
//             _buildSectionHeader_1("All Tours"),
//             _buildRecommendedItems(),
//             SizedBox(height: 50),
//             _buildArticleSection(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPromoSlider() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TPromoSlider(
//         banners: [TImages.chicago, TImages.lima, TImages.tokyo],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF232323)),
//         ),
//         // TextButton(
//         //   onPressed: () => Get.to(() => const AllToursScreen()),
//         //   child: Text("See all", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF55B97D))),
//         // ),
//       ],
//     );
//   }
//
//   Widget _buildSectionHeader_1(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF232323)),
//         ),
//         TextButton(
//           onPressed: () => Get.to(() => const AllToursScreen()),
//           child: Text("See all", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF55B97D))),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPopularItems(String categoryId) {
//     if (!_categoryTours.containsKey(categoryId) || _categoryTours[categoryId] == null) {
//       return Center(child: CircularProgressIndicator()); // Hiển thị loading nếu chưa có dữ liệu
//     }
//
//     final displayedTours = _categoryTours[categoryId]?.take(5).toList() ?? []; // Lấy tối đa 2 tour
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: displayedTours.map((tour) {
//           // Lấy hình ảnh từ danh sách galleries
//           String? imageUrl;
//           if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
//             imageUrl = tour['galleries'][0]['imageUrl'] as String;
//           }
//
//           return PopularItem(
//             title: tour['name'].toString(),
//             rating: "4.0", // Điều chỉnh nếu có rating thực
//             image: imageUrl ?? "đường_dẫn_ảnh_mặc định",
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildRecommendedItems() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: _recommendedTours.map((tour) {
//           String? imageUrl;
//           if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
//             imageUrl = tour['galleries'][0]['imageUrl'] as String;
//           }
//
//           return RecommendCard(
//             title: tour['name'].toString(),
//             duration: "4N/5D", // Điều chỉnh nếu có thời gian thực trong API
//             deal: "Hot Deal", // Có thể thay bằng dữ liệu thật từ API
//             image: imageUrl ?? "đường_dẫn_ảnh_mặc định", // Sử dụng toán tử ?? để cung cấp giá trị mặc định
//             onTap: () => Get.to(() => PlaceScreen(
//               title: tour['name'],
//               price: tour['price'].toString(),
//               province: tour['province'],
//               startTime: tour['startTime'],
//               endTime: tour['endTime'],
//               shortDescription: tour['shortDescription'],
//               description: tour['description'],
//               gallery: imageUrl ?? "đường_dẫn_ảnh_mặc định", // Cũng cung cấp giá trị mặc định ở đây nếu cần
//             )),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildArticleSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace / 2),
//       child: Column(
//         children: [
//           TSectionHeading(
//             title: 'Article',
//             showActionButton: true,
//             textColor: Colors.black,
//             onPressed: () {},
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),
//           SizedBox(
//             height: 250,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 return const ArticleCard(
//                   imageUrl: AssetImage(TImages.canada),
//                   title: 'The essential guide to visiting Canada',
//                   author: 'Alexander Wooley',
//                   date: '5 June 2024',
//                   url: 'https://www.nationalgeographic.com/travel/article/essential-guide-canada',
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
