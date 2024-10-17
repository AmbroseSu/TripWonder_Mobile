import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://tripwonder.onrender.com/api/v1/category/get-all?page=1&limit=100'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List categories = data['content'];

        setState(() {
          _categories = categories.map((category) => category['name'] as String).toList();
          _tabController = TabController(length: _categories.length, vsync: this);
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("Error fetching categories: $e");
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
        body: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "TripWonder",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
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
                        "District 9, \nHo Chi Minh",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF606060),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF3F8FE),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Find places to visit",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            if (_categories.isNotEmpty) ...[
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Color(0xFF55B97D),
                labelColor: Color(0xFF55B97D),
                unselectedLabelColor: Color(0xFFB8B8B8),
                labelStyle: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                unselectedLabelStyle: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                tabs: _categories
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
              SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _categories
                      .map((category) => buildTabContent(category))
                      .toList(),
                ),
              ),
            ] else ...[
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildTabContent(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: TPromoSlider(
                banners: [TImages.chicago, TImages.lima, TImages.tokyo],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF55B97D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PopularItem(
                    title: "Alley Place",
                    rating: "4.1",
                    image: "assets/images/Alley Palace.png",
                  ),
                  SizedBox(width: 16),
                  PopularItem(
                    title: "Condures Alpes",
                    rating: "4.9",
                    image: "assets/images/Coeurdes Alpes.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF55B97D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecommendCard(
                    title: "Explore TripWonder",
                    duration: "4N/5D",
                    deal: "Hot Deal",
                    image: "assets/images/rectangle_9921.jpeg",
                    onTap: () {
                      Get.to(() => const PlaceScreen());
                    },
                  ),
                  SizedBox(width: 16),
                  RecommendCard(
                    title: "Luxurious TripWonder",
                    duration: "2N/3D",
                    deal: "New Deal",
                    image: TImages.tokyo,
                    onTap: () {
                      Get.to(() => const PlaceScreen());
                    },
                  ),
                  SizedBox(width: 16),
                  RecommendCard(
                    title: "Luxurious TripWonder",
                    duration: "2N/3D",
                    deal: "Hot Deal",
                    image: TImages.lima,
                    onTap: () {
                      Get.to(() => const PlaceScreen());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}

