import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://tripwonder.onrender.com/api/v1/packageOff';

  // Phương thức gọi API để lấy dữ liệu tour theo packageOfficialId
  static Future<Map<String, dynamic>?> fetchTourById(int packageOfficialId) async {
    final url = '$baseUrl/get-package-tour-by-id?packageOfficialId=$packageOfficialId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body); // Trả về dữ liệu JSON
      } else {
        print("Lỗi: ${response.statusCode}");
        return null; // Trả về null nếu không thành công
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return null; // Trả về null khi có lỗi
    }
  }
}
