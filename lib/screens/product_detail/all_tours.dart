import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/grid_layout.dart';
import 'package:http/http.dart' as http;

import '../../api/response/tour.dart';


class AllToursScreen extends StatefulWidget {
  const AllToursScreen({super.key});

  @override
  _AllToursScreenState createState() => _AllToursScreenState();
}

class _AllToursScreenState extends State<AllToursScreen> {
  List<dynamic> tours = [];


  // Future<void> fetchTours() async {
  //   final response = await http.get(
  //     Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final jsonString = utf8.decode(response.bodyBytes);
  //     print(jsonString);
  //     setState(() {
  //       tours = json.decode(jsonString)['content']['content'];
  //     });
  //   } else {
  //     print('Failed to load tours');
  //   }
  // }

  Future<void> fetchTours() async {
    final response = await http.get(
      Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
    );

    if (response.statusCode == 200) {
      final jsonString = utf8.decode(response.bodyBytes);
      final List<dynamic> tourJsonList = json.decode(jsonString)['content']['content'];

      setState(() {
        // Chuyển đổi từng phần tử trong danh sách JSON thành đối tượng Tour
        tours = tourJsonList.map((json) => Tour.fromJson(json)).toList();
      });
    } else {
      print('Failed to load tours');
    }
  }



  @override
  void initState() {
    super.initState();
    fetchTours();
  }



    String formatDate(String dateTimeString) {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       title: Text('All Tours', style: Theme.of(context).textTheme.headlineMedium),
  //       centerTitle: true,
  //     ),
  //     body: tours.isEmpty
  //         ? Center(child: CircularProgressIndicator())
  //         : SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(TSizes.defaultSpace),
  //         child: Column(
  //           children: [
  //             TGridLayout(
  //               itemCount: tours.length,
  //               itemBuilder: (_, index) {
  //
  //                 final tour = tours[index];
  //
  //         // Lấy hình ảnh từ danh sách galleries
  //         String? imageUrl;
  //         if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
  //           imageUrl = tour['galleries'][0]['imageUrl'];
  //         }
  //
  //         return TProductCardVertical(
  //                 tour: tour,
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(
                itemCount: tours.length,
                itemBuilder: (_, index) {
                  final tour = tours[index]; // Đây sẽ là một đối tượng Tour

                  return TProductCardVertical(
                    tour: tour,
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
