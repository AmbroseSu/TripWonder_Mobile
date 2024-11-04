import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tripwonder/screens/chat/allchats_screen.dart';
import 'package:tripwonder/screens/chat/chat_screen.dart';
import 'package:tripwonder/screens/product_detail/all_tours.dart';
import 'package:tripwonder/screens/search/search_result.dart';
import '../api/response/tour.dart';
import '../widgets/popular_item.dart';
import '../widgets/recommend_item.dart';
import '../widgets/promo_slider.dart';
import '../widgets/article_card.dart';
import '../widgets/section_heading.dart';
import '../styles&text&sizes/image_strings.dart';
import '../styles&text&sizes/sizes.dart';
import 'product_detail/place_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _categories = [];
  List<dynamic> _recommendedTours = []; // Thêm danh sách cho gói tour
  Map<String, List<dynamic>> _categoryTours = {};


  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchRecommendedTours();// Gọi API cho gói tour
  }


    Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://tripwonder.onrender.com/api/v1/category/get-all?page=1&limit=100'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final List categories = data['content'];

        setState(() {
          _categories = categories.map((category) => {
            'id': category['id'],
            'name': category['name']
          }).toList();
          _tabController = TabController(length: _categories.length, vsync: this);
        });

        // Gọi API để lấy tour cho mỗi category
        for (var category in _categories) {
          await fetchToursByCategory(category['id'].toString());
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> fetchToursByCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100&category=$categoryId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));

        setState(() {
          _categoryTours['$categoryId'] = data['content']['content']; // Lưu tour theo categoryId
        });
      } else {
        throw Exception('Failed to load tours for category: $categoryId');
      }
    } catch (e) {
      print("Error fetching tours for category $categoryId: $e");
    }
  }


  // Thêm phương thức để gọi API lấy tour
  Future<void> fetchRecommendedTours() async {
    try {
      // final response = await http.get(
      //   Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
      // );
      //
      // if (response.statusCode == 200) {
      //   final data = json.decode(utf8.decode(response.bodyBytes));
      //   final List<dynamic> tourJsonList = json.decode(data)['content']['content'];
      //
      //
      //   setState(() {
      //     // _recommendedTours = data['content']['content'];
      //
      //     _recommendedTours = tourJsonList.map((json) => Tour.fromJson(json)).toList();
      //
      //   });
      // } else {
      //   throw Exception('Failed to load recommended tours');
      // }
      final response = await http.get(
        Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
      );

      if (response.statusCode == 200) {
        final jsonString = utf8.decode(response.bodyBytes);
        final List<dynamic> tourJsonList = json.decode(jsonString)['content']['content'];

        setState(() {
          // Chuyển đổi từng phần tử trong danh sách JSON thành đối tượng Tour
          _recommendedTours = tourJsonList.map((json) => Tour.fromJson(json)).toList();        });
      } else {
        print('Failed to load tours');
      }
    } catch (e) {
      print("Error fetching recommended tours: $e");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                _buildHeader(),
                _buildSearchBar(),
                _buildTabBar(),
                _buildTabBarView(),
              ],
            ),
            // Positioned(
            //   bottom: 16,
            //   right: 16,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       // Define the action for the Help button here
            //       Get.to(() => const AllChatsScreen());
            //       Get.snackbar(
            //         "Help",
            //         "Need assistance? Contact our support team.",
            //         snackPosition: SnackPosition.BOTTOM,
            //         duration: Duration(seconds: 3),
            //       );
            //     },
            //     backgroundColor: Color(0xFF55B97D),
            //     child: Icon(
            //       CupertinoIcons.question_circle,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Text(
                "TripWonder",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 32),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.location_solid,
                color: Color(0xFF55B97D),
                size: 20,
              ),
              SizedBox(width: 6),
              Text(
                "Dĩ An, \nBình Dương",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF606060)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF3F8FE),
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextField(
          decoration: InputDecoration (
            hintText: "Find places to visit",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            hintStyle: GoogleFonts.montserrat(color: Colors.grey),
          ),
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              Get.to(() => SearchResult(query: query));
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    if (_categories.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Color(0xFF55B97D),
      labelColor: Color(0xFF55B97D),
      unselectedLabelColor: Color(0xFFB8B8B8),
      labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 16),
      unselectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 16),
      // tabs: _categories.map((category) => Tab(text: category)).toList(),
      tabs: _categories.map((category) => Tab(text: category['name'])).toList(),

    );
  }

  Widget _buildTabBarView() {
    if (_categories.isEmpty) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: TabBarView(
        controller: _tabController,
        // children: _categories.map((category) => buildTabContent(category)).toList(),
        children: _categories.map((category) => buildTabContent(category)).toList(),
      ),
    );
  }

  Widget buildTabContent(Map<String, dynamic> category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPromoSlider(),
            SizedBox(height: 12),
            _buildSectionHeader("Popular"),
            _buildPopularItems(category['id'].toString()),
            SizedBox(height: 32),
            _buildSectionHeader_1("All Tours"),
            _buildRecommendedItems(),
            SizedBox(height: 50),
            _buildArticleSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoSlider() {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: TPromoSlider(
        banners: [TImages.chicago, TImages.lima, TImages.tokyo],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF232323)),
        ),
        // Text(
        //   "See all",
        //   style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF55B97D)),
        // ),
      ],
    );
  }
  Widget _buildSectionHeader_1(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF232323)),
        ),
        TextButton(onPressed: () => Get.to(() => const AllToursScreen()), child: Text(  "See all", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF55B97D)),))
      ],
    );
  }

  // Widget _buildPopularItems() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: [
  //         PopularItem(title: "Alley Place", rating: "4.1", image: "assets/images/Alley Palace.png"),
  //         SizedBox(width: 16),
  //         PopularItem(title: "Condures Alpes", rating: "4.9", image: "assets/images/Coeurdes Alpes.png"),
  //       ],
  //     ),
  //   );
  // }

    Widget _buildPopularItems(String categoryId) {
    if (!_categoryTours.containsKey(categoryId) || _categoryTours[categoryId] == null) {
      return Center(child: CircularProgressIndicator()); // Hiển thị loading nếu chưa có dữ liệu
    }

    final displayedTours = _categoryTours[categoryId]?.toList() ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: displayedTours.map((tour) {
          // Lấy hình ảnh từ danh sách galleries
          String? imageUrl;
          if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
            imageUrl = tour['galleries'][0]['imageUrl'] as String;
          }

          return PopularItem(
            title: tour['name'].toString(),
            rating: "4.0", // Điều chỉnh nếu có rating thực
            image: imageUrl ?? "đường_dẫn_ảnh_mặc định",
            onTap: ()
            {Tour tourObj = Tour.fromMap(tour);
                Get.to(() =>
                PlaceScreen(tour: tourObj,// Cũng cung cấp giá trị mặc định ở đây nếu cần
                )
            );}
          );
        }).toList(),
      ),
    );
  }
  Widget _buildRecommendedItems() {
    if (_recommendedTours.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    // Lấy tối đa 8 tour
    final displayedTours = _recommendedTours.take(8).toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: displayedTours.map((tour) {
              // Lấy hình ảnh từ danh sách galleries
              String? imageUrl = tour.getFirstImageUrl();
              // if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
              //   // imageUrl = tour['galleries'][0]['imageUrl'] as String; // Chuyển đổi về kiểu String
              // }

              //imageUrl = tour.g; // Chuyển đổi về kiểu String


              return RecommendCard(
                title: tour.name,
                duration: "4N/5D", // Điều chỉnh nếu có thời gian thực trong API
                deal: "Hot Deal", // Có thể thay bằng dữ liệu thật từ API
                image: imageUrl ?? "đường_dẫn_ảnh_mặc định", // Sử dụng toán tử ?? để cung cấp giá trị mặc định
                onTap: () => Get.to(() =>
                    PlaceScreen(tour: tour,
                )
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }





  Widget _buildArticleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace / 2),
      child: Column(
        children: [
          TSectionHeading(
            title: 'Article',
            showActionButton: true,
            textColor: Colors.black,
            onPressed: () {},
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return const ArticleCard(
                  imageUrl: AssetImage(TImages.canada),
                  title: 'The essential guide to visiting Canada',
                  author: 'Alexander Wooley',
                  date: '5 June 2024',
                  url: 'https://www.nationalgeographic.com/travel/article/essential-guide-canada',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
