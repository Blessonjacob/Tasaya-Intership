import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://tasaya.in/Api/Rider/';

  Future<Map<String, dynamic>> forgotPassword(String mobile) async {
    final url = Uri.parse('$baseUrl/forgot');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'mobile': mobile});

    final response = await http.post(url, headers: headers, body: body);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> otpVerification(String mobile, String otp) async {
    final url = Uri.parse('$baseUrl/OtpVerification');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'mobile': mobile, 'otp': otp});

    final response = await http.post(url, headers: headers, body: body);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> changePassword(String mobile, String password) async {
    final url = Uri.parse('$baseUrl/Changepassword');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'mobile': mobile, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    return jsonDecode(response.body);
  }

  // Add more functions for other API endpoints as needed...

  // Example function for registration
  Future<Map<String, dynamic>> register(String name, String email, String mobile, String city, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'email': email,
      'mobile': mobile,
      'city': city,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    return jsonDecode(response.body);
  }
}
