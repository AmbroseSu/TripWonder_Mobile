
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tripwonder/screens/profile/profile.dart';
import 'package:tripwonder/styles&text&sizes/image_strings.dart';
import 'package:tripwonder/widgets/appbar.dart';
import 'package:tripwonder/widgets/my_trip_card.dart';
import '../../widgets/t_circular_icon.dart';

class MyTripScreen extends StatefulWidget {
  const MyTripScreen({super.key});

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  // This is the selected day
  int selectedDay = 0;

  // List of available days for the trip
  final List<String> days = ["July 2nd", "July 3rd", "July 4th"];

  // Method to change the displayed day content
  void changeDay(int index) {
    setState(() {
      selectedDay = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TAppBar(
        title: Text('My Trip', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Selector
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => changeDay(index),
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
                        days[index],
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
            child: selectedDay == 0
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mount Fuji',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fuji-Hakone-Izu National Park',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'May 28 - May 30, 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'A Couple - Luxury',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildActionButton(
                      context,
                      icon: Iconsax.edit,
                      label: 'Edit Address',
                      onPressed: () => Get.to(() => const ProfileScreen()),
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      context,
                      icon: Iconsax.note_text,
                      label: 'Add Note',
                      onPressed: () {
                        // Add your logic for Add Note here
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
              ],
            )
                : const SizedBox.shrink(), // Ẩn phần nội dung cho ngày khác
          ),

          Expanded(
            child: _buildDayContent(selectedDay),
          ),
        ],
      ),
    );
  }


  Widget _buildDayContent(int dayIndex) {
    switch (dayIndex) {
      case 0: // July 2nd
      // Sử dụng ListView để hiển thị nhiều thẻ MyTripCard
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: const [
             MyTripCard(cafeName: 'Cafe de I’ambre', cafeImage: TImages.canada, rating: 4.9, time: '9:00 - 10:00 AM', price: 30.0, reviewCount: 230,), // Thẻ đầu tiên
            // MyTripCard(), // Thẻ thứ hai
            // MyTripCard(), // Thẻ thứ ba
            // Có thể thêm nhiều thẻ hơn tùy ý
          ],
        );
      case 1: // July 3rd
        return Center(
          child: Text('Schedule for July 3rd'),
        );
      case 2: // July 4th
        return Center(
          child: Text('Schedule for July 4th'),
        );
      default:
        return const SizedBox.shrink();
    }
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
