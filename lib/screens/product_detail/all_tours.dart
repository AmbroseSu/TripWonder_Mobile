import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:tripwonder/screens/explore_screen.dart';
import 'package:tripwonder/styles&text&sizes/product_card_vertical.dart';
import 'package:tripwonder/styles&text&sizes/sizes.dart';
import 'package:tripwonder/widgets/appbar.dart';
import 'package:tripwonder/widgets/grid_layout.dart';
import 'package:tripwonder/widgets/login_signup/all_tour_grid_layout.dart';
import 'package:tripwonder/widgets/t_circular_icon.dart';
import 'package:http/http.dart' as http;
//
// class AllToursScreen extends StatefulWidget {
//   const AllToursScreen({super.key});
//
//   @override
//   _AllToursScreenState createState() => _AllToursScreenState();
// }
//
// class _AllToursScreenState extends State<AllToursScreen> {
//   List<dynamic> tours = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchTours();
//   }
//
//   // Future<void> fetchTours() async {
//   //   final response = await http.get(
//   //     Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     print(response.body); // In ra phản hồi JSON
//   //     setState(() {
//   //       tours = json.decode(response.body)['content']['content'];
//   //     });
//   //   } else {
//   //     // Xử lý lỗi khi gọi API thất bại
//   //     print('Failed to load tours');
//   //   }
//   // }
//
//   Future<void> fetchTours() async {
//     final response = await http.get(
//       Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
//     );
//
//     if (response.statusCode == 200) {
//       // Giải mã phản hồi với UTF-8
//       final jsonString = utf8.decode(response.bodyBytes);
//       print(jsonString); // In ra phản hồi JSON đã được giải mã
//       setState(() {
//         tours = json.decode(jsonString)['content']['content'];
//       });
//     } else {
//       // Xử lý lỗi khi gọi API thất bại
//       print('Failed to load tours');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('All Tours', style: Theme.of(context).textTheme.headlineMedium),
//         centerTitle: true,
//       ),
//       body: tours.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: TSizes.defaultSpace,
//           crossAxisSpacing: TSizes.defaultSpace,
//         ),
//         itemCount: tours.length,
//         itemBuilder: (context, index) {
//           final tour = tours[index];
//           return
//             TProductCardVertical(
//             title: tour['name'],
//             price: tour['price'].toString(),
//             province: tour['province'],
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripwonder/styles&text&sizes/sizes.dart';
//
// class AllToursScreen extends StatefulWidget {
//   const AllToursScreen({super.key});
//
//   @override
//   _AllToursScreenState createState() => _AllToursScreenState();
// }
//
// class _AllToursScreenState extends State<AllToursScreen> {
//   List<dynamic> tours = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchTours();
//   }
//
//   Future<void> fetchTours() async {
//     final response = await http.get(
//       Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get?page=0&size=100'),
//     );
//
//     if (response.statusCode == 200) {
//       // Giải mã phản hồi với UTF-8 để xử lý tiếng Việt
//       final jsonString = utf8.decode(response.bodyBytes);
//       print(jsonString); // In ra phản hồi JSON đã được giải mã
//       setState(() {
//         tours = json.decode(jsonString)['content']['content'];
//       });
//     } else {
//       // Xử lý lỗi khi gọi API thất bại
//       print('Failed to load tours');
//     }
//   }
//   String formatDate(String dateTimeString) {
//     DateTime parsedDate = DateTime.parse(dateTimeString);
//     return DateFormat('dd/MM/yyyy').format(parsedDate); // Định dạng lại theo ngày/tháng/năm
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('All Tours', style: Theme.of(context).textTheme.headlineMedium),
//         centerTitle: true,
//       ),
//       body: tours.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: TSizes.defaultSpace,
//           crossAxisSpacing: TSizes.defaultSpace,
//         ),
//         itemCount: tours.length,
//         // itemBuilder: (context, index) {
//         //   final tour = tours[index];
//         //
//         //   // Đảm bảo các trường bạn truyền vào card là đúng
//         //   return TProductCardVertical(
//         //     title: tour['name'].toString(), // Chuyển thành chuỗi
//         //     price: tour['price'].toString(), // Chuyển thành chuỗi
//         //     province: tour['province'].toString(), // Chuyển thành chuỗi
//         //     gallery: tour['gallery'] != null ? tour['gallery'].toString() : null, // Xử lý trường hợp có/không có ảnh
//         //     startTime: tour['startTime']?.toString() ?? 'N/A', // Xử lý nếu không có startTime
//         //     endTime: tour['endTime']?.toString() ?? 'N/A', // Xử lý nếu không có endTime
//         //   );
//         // },
//         itemBuilder: (context, index) {
//           final tour = tours[index];
//
//           return TProductCardVertical(
//             title: tour['name'].toString(),
//             price: tour['price'].toString(),
//             province: tour['province'].toString(),
//             gallery: tour['gallery'] != null ? tour['gallery'].toString() : null,
//             startTime: tour['startTime'] != null ? formatDate(tour['startTime']) : 'N/A', // Định dạng startTime
//             endTime: tour['endTime'] != null ? formatDate(tour['endTime']) : 'N/A', // Định dạng endTime
//           );
//         },
//       ),
//     );
//   }
// }


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
      final jsonString = utf8.decode(response.bodyBytes);
      print(jsonString);
      setState(() {
        tours = json.decode(jsonString)['content']['content'];
      });
    } else {
      print('Failed to load tours');
    }
  }

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

          // Lấy hình ảnh từ danh sách galleries
          String? imageUrl;
          if (tour['galleries'] != null && tour['galleries'].isNotEmpty) {
            imageUrl = tour['galleries'][0]['imageUrl'];
          }

          return TProductCardVertical(
            title: tour['name'].toString(),
            price: tour['price'].toString(),
            province: tour['province'].toString(),
            gallery: imageUrl, // Sử dụng imageUrl
            startTime: tour['startTime'] != null ? formatDate(tour['startTime']) : 'N/A',
            endTime: tour['endTime'] != null ? formatDate(tour['endTime']) : 'N/A',
          );
        },
      ),
    );
  }
}