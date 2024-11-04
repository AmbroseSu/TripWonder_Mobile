import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:tripwonder/screens/map/google_map_polyline.dart';
import 'package:tripwonder/screens/profile/profile.dart';
import 'package:tripwonder/styles&text&sizes/my_trip_card.dart';

class MyTripScreen extends StatefulWidget {
  final int tourId;

  const MyTripScreen({Key? key, required this.tourId}) : super(key: key);

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  int selectedDay = 0;
  List<Map<String, dynamic>> daysData = [];
  String tourName = "";
  String location = "";
  String startDate = "";
  String endDate = "";
  String category = "";
  List<String> galleries = [];

  @override
  void initState() {
    super.initState();
    fetchTourDetails();
  }

  // Future<void> fetchTourDetails() async {
  //   final response = await http.get(
  //     Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get-detail-tour/${widget.tourId}'),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Chuyển đổi nội dung phản hồi sang UTF-8 để hỗ trợ tiếng Việt
  //     final data = jsonDecode(utf8.decode(response.bodyBytes));
  //     final content = data["content"]["5"];
  //
  //     setState(() {
  //       tourName = content[0]["packageTour"]["name"].toString();
  //       location = content[0]["packageTour"]["shortDescription"].toString();
  //       startDate = content[0]["startDate"].toString();
  //       endDate = content[0]["endDate"].toString();
  //       category = content[0]["packageTour"]["category"]["name"].toString();
  //       galleries = List<String>.from(
  //         content[0]["packageTour"]["galleries"].map((gallery) => gallery["imageUrl"].toString()),
  //       );
  //
  //       daysData = content.map<Map<String, dynamic>>((day) => {
  //         "id": day["dayString"],
  //         "name": day["name"].toString(),
  //         "startTime": day["startTime"].toString(),
  //         "endTime": day["endTime"].toString(),
  //       }).toList();
  //     });
  //   } else {
  //     print("Error fetching tour details: ${response.statusCode}");
  //   }
  // }


  Future<void> fetchTourDetails() async {
    final response = await http.get(
      Uri.parse('https://tripwonder.onrender.com/api/v1/packageOff/get-detail-tour/${widget.tourId}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final content = data["content"];

      setState(() {
        tourName = content["1"][0]["packageTour"]["name"].toString();
        location = content["1"][0]["packageTour"]["shortDescription"].toString();
        startDate = content["1"][0]["startDate"].toString();
        endDate = content["1"][0]["endDate"].toString();
        category = content["1"][0]["packageTour"]["category"]["name"].toString();
        galleries = List<String>.from(
          content["1"][0]["packageTour"]["galleries"].map((gallery) => gallery["imageUrl"].toString()),
        );

        // Lặp qua tất cả các ngày và tạo danh sách daysData
        daysData = content.entries.map<Map<String, dynamic>>((entry) {
          String dayKey = entry.key; // '1', '2', '3', ...
          List<dynamic> dayActivities = entry.value; // Danh sách hoạt động cho ngày

          return {
            "id": dayKey,
            "activities": dayActivities.map((activity) {
              return {
                "name": activity["name"].toString(),
                "startTime": activity["startTime"].toString(),
                "endTime": activity["endTime"].toString(),
                "galleries": List<String>.from(activity["packageTour"]["galleries"].map((gallery) => gallery["imageUrl"].toString())),
                "facilitate": activity["facilitate"].toString(),
              };
            }).toList(),
          };
        }).toList();
      });
    } else {
      print("Error fetching tour details: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('My Trip', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: daysData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => selectedDay = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedDay == index ? Color(0xFF55B97D) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        "Day ${daysData[index]['id']}",
                        style: TextStyle(
                          color: selectedDay == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tourName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$startDate - $endDate', style: Theme.of(context).textTheme.bodyMedium),
                    Text(category, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        icon: Iconsax.map,
                        label: 'All Locations',
                        onPressed: () => Get.to(() =>  GoogleMapPolyline(tourId: widget.tourId)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        icon: Iconsax.edit,
                        label: 'My Profile',
                        onPressed: () => Get.to(() => const ProfileScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
              ],
            ),
          ),
          Expanded(
            child: _buildDayContent(),
          ),
        ],
      ),
    );
  }

  // Widget _buildDayContent() {
  //   final day = daysData[selectedDay];
  //   return ListView(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     children: [
  //       MyTripCard(
  //         cafeName: day["name"].toString(),
  //         cafeImage: galleries.isNotEmpty ? galleries.first : 'default_image_url',
  //         time: '${day["startTime"]} - ${day["endTime"]}',
  //         facilitate: "",
  //         reviewCount: 120,
  //       ),
  //     ],
  //   );
  // }


  Widget _buildDayContent() {
    final day = daysData[selectedDay];
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: day["activities"].map<Widget>((activity) {
        return MyTripCard(
          cafeName: activity["name"].toString(),
          cafeImage: activity["galleries"].isNotEmpty ? activity["galleries"].first : 'default_image_url',
          time: '${activity["startTime"]} - ${activity["endTime"]}',
          facilitate: activity["facilitate"].toString(), // Cập nhật nếu bạn có thông tin này
          reviewCount: 120, // Thay đổi nếu cần
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
