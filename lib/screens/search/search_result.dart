import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/grid_layout.dart';

class SearchResult extends StatefulWidget {
  final String query; // Query tìm kiếm

  const SearchResult({super.key, required this.query});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<dynamic> tours = []; // Danh sách các tour tìm thấy

  // Hàm gọi API để lấy dữ liệu các tour
  Future<void> fetchTours() async {
    try {
      final response = await http.get(
        Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/search/${widget.query}?page=0&size=100'),
      );

      if (response.statusCode == 200) {
        final jsonString = utf8.decode(response.bodyBytes);
        final jsonResponse = json.decode(jsonString);

        // Kiểm tra và lấy dữ liệu
        if (jsonResponse['body'] != null && jsonResponse['body']['content'] != null && jsonResponse['body']['content']['content'] != null) {
          setState(() {
            tours = jsonResponse['body']['content']['content'];
          });
        } else {
          setState(() {
            tours = []; // Không có tour nào
          });
          print('Content is null or not as expected');
        }
      } else {
        print('Failed to load tours, status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching tours: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTours(); // Gọi hàm fetchTours khi khởi tạo
  }

  // Hàm định dạng ngày tháng
  String formatDate(String dateTimeString) {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Search Result', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: tours.isEmpty
          ? Center(
        child: Text(
          'Tour này không tồn tại',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(
                itemCount: tours.length,
                itemBuilder: (_, index) {
                  final tour = tours[index];

                  String? imageUrl;
                  if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
                    imageUrl = tour['galleries'][0]['imageUrl'];
                  }

                  return TProductCardVertical(
                    title: tour['name'].toString(),
                    price: tour['price'].toString(),
                    province: tour['province'].toString(),
                    gallery: imageUrl.toString(),
                    startTime: tour['startTime'] != null ? formatDate(tour['startTime']) : 'N/A',
                    endTime: tour['endTime'] != null ? formatDate(tour['endTime']) : 'N/A',
                    shortDescription : tour['shortDescription'].toString(),
                    description : tour['description'].toString(),
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
