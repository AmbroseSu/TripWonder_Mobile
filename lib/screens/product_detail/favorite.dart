import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/explore_screen.dart';
import 'package:tripwonder/styles&text&sizes/image_strings.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical_fav.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/appbar.dart';
import 'package:tripwonder/widgets/grid_layout.dart';
import 'package:tripwonder/widgets/t_circular_icon.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../api/global_variables/user_manage.dart';
import '../../api/response/tour.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<dynamic> favoriteTours = [];


  Future<void> fetchFavoriteTours() async {
    final int? userId = UserManager().id;
    final response = await http.get(Uri.parse(
        'https://tripwonder.onrender.com/api/v1/favorite_package/get-all-favorite-package-by-user-id?userId=$userId&page=1&limit=100'));

    if (response.statusCode == 200) {
      // Sử dụng utf8.decode để giải mã dữ liệu trả về
      final data = json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> tourJsonList = data['content'];

      setState(() {
        // favoriteTours = data['content'];
        favoriteTours = tourJsonList.map((json) => Tour.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load favorite tours');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchFavoriteTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Favorite', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: favoriteTours.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(
                itemCount: favoriteTours.length,
                itemBuilder: (_, index) {
                  final tour = favoriteTours[index];
                  // final startTime = DateTime.parse(tour['startTime']);
                  // final endTime = DateTime.parse(tour['endTime']);
                  // final formattedStartTime = '${startTime.day}/${startTime.month}/${startTime.year}';
                  // final formattedEndTime = '${endTime.day}/${endTime.month}/${endTime.year}';
                  // final imageUrl = tour['galleries'].isNotEmpty
                  //     ? tour['galleries'][0]['imageUrl']
                  //     : TImages.tokyo;

                  return TProductCardVerticalFav(tour: tour,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
