import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/explore_screen.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/appbar.dart';
import 'package:tripwonder/widgets/grid_layout.dart';
import 'package:tripwonder/widgets/login_signup/all_tour_grid_layout.dart';
import 'package:tripwonder/widgets/t_circular_icon.dart';
import 'package:http/http.dart' as http;

class AllToursScreen extends StatefulWidget {
  const AllToursScreen({super.key});

  @override
  _AllToursScreenState createState() => _AllToursScreenState();
}

class _AllToursScreenState extends State<AllToursScreen> {
  List<dynamic> tours = [];

  @override
  void initState() {
    super.initState();
    fetchTours();
  }

  Future<void> fetchTours() async {
    final response = await http.get(
      Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
    );

    if (response.statusCode == 200) {
      print(response.body); // In ra phản hồi JSON
      setState(() {
        tours = json.decode(response.body)['content']['content'];
      });
    } else {
      // Xử lý lỗi khi gọi API thất bại
      print('Failed to load tours');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('All Tours', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: tours.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: TSizes.defaultSpace,
          crossAxisSpacing: TSizes.defaultSpace,
        ),
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final tour = tours[index];
          return
            TProductCardVertical(
            title: tour['name'],
            price: tour['price'].toString(),
            province: tour['province'],
          );
        },
      ),
    );
  }
}